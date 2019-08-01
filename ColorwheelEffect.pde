abstract class SpinImageEffect extends PyramidEffect {
  int rpm = 60;
  PGraphics im;

  void reset(PApplet parent) {
    if (im == null) im = createImage();
    imageMode(CENTER);
  }

  abstract PGraphics createImage();

  void draw(boolean onBeat) {
    final float rotationAngle = TWO_PI * rpm * millis() / 60000;
    translate(width/2, height/2);
    rotate(rotationAngle);
    image(im, 0, 0);
  }
}

abstract class Wheel {
  float sliceSize;

  Wheel(int slices) {
    sliceSize = TWO_PI / slices;
  }

  abstract void getColor(float rad, CRGB rgb);
  void setup(PGraphics pg) {
    pg.colorMode(RGB, 255);
  }

  PGraphics createImage() {
    CRGB rgb = new CRGB();
    PGraphics pg = createGraphics(width, height);
    pg.beginDraw();
    setup(pg);
    pg.translate(width/2, height/2);

    for (float rad = 0; rad < TWO_PI; rad += sliceSize) {
      getColor(rad, rgb);
      pg.fill(rgb.r, rgb.g, rgb.b);
      pg.arc(0, 0, width, width, rad, rad + sliceSize);
    }
    pg.endDraw();
    return pg;
  }
}

class RGBColorwheelEffect extends SpinImageEffect {
  void setup(PApplet parent) {
    rpm = 60;
  }

  PGraphics createImage() {
    return (new Wheel(2 * width + 2 * height) {
      public void getColor(float rad, CRGB rgb) {
        rgb.r = (int) (rad * 256/TWO_PI);
        rgb.r = (int) (256 - Math.abs((rad - 1 * TWO_PI / 3)) * 3 * 256/TWO_PI);
        rgb.g = (int) (256 - Math.abs((rad - 2 * TWO_PI / 3)) * 3 * 256/TWO_PI);
        rgb.b = (int) (256 - Math.min(Math.abs(rad), Math.abs(rad - TWO_PI)) * 3 * 256/TWO_PI);
      }
    }).createImage();
  }
}

class HSB1ColorwheelEffect extends SpinImageEffect {
  void setup(PApplet parent) {
    rpm = 60;
  }

  PGraphics createImage() {
    return (new Wheel(2 * width + 2 * height) {
      public void setup(PGraphics pg) {
        pg.colorMode(HSB, 255, 100, 100, 100);
      }
      public void getColor(float rad, CRGB rgb) {
        rgb.r = (int) (rad * 256/TWO_PI);
        rgb.g = 100;
        rgb.b = 75;
      }
    }).createImage();
  }
}

// Uses different (better?) HSV space from https://github.com/FastLED/FastLED/wiki/FastLED-HSV-Colors
class HSB2ColorwheelEffect extends SpinImageEffect {
  void setup(PApplet parent) {
    rpm = 60;
  }

  PGraphics createImage() {
    return (new Wheel(2 * width + 2 * height) {
      public void getColor(float rad, CRGB rgb) {
        hsv2rgb_rainbow((int) (rad * 256/TWO_PI), 255, 255, rgb);
      }
    }).createImage();
  }
}
