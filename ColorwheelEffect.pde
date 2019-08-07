class CRGB {
  int r,g,b;
}

abstract class SpinImageEffect extends PyramidEffect {
  int rpm;
  PImage im;

  SpinImageEffect() {
    this(20);
  }

  SpinImageEffect(int rpm) {
    this.rpm = rpm;
  }

  void setup(PApplet parent) {
    if (im == null) im = createImage(parent);
  }

  void reset(PGraphics g) {
    g.imageMode(CENTER);
  }

  abstract PImage createImage(PApplet parent);

  void draw(PGraphics g) {
    final float rotationAngle = TWO_PI * rpm * millis() / 60000;
    g.translate(width/2, height/2);
    g.rotate(rotationAngle);
    g.image(im, 0, 0);
  }
}

abstract class Wheel {
  float sliceSize;

  Wheel(int slices) {
    sliceSize = TWO_PI / slices;
  }

  abstract void getColor(float rad, CRGB rgb);
  void setup(PGraphics g) {
    g.colorMode(RGB, 255);
  }

  PImage createImage(PApplet parent) {
    CRGB rgb = new CRGB();
    PGraphics g = parent.createGraphics(width, height);
    g.beginDraw();
    setup(g);
    g.translate(width/2, height/2);

    for (float rad = 0; rad < TWO_PI; rad += sliceSize) {
      getColor(rad, rgb);
      g.fill(rgb.r, rgb.g, rgb.b);
      g.arc(0, 0, width, width, rad, rad + sliceSize);
    }
    g.endDraw();
    return g;
  }
}

class RGBColorwheelEffect extends SpinImageEffect {
  RGBColorwheelEffect() {
    this(20);
  }

  RGBColorwheelEffect(int rpm) {
    this.rpm = rpm;
  }

  PImage createImage(PApplet parent) {
    return (new Wheel(2 * width + 2 * height) {
      public void getColor(float rad, CRGB rgb) {
        rgb.r = (int) (256 - Math.abs((rad - 1 * TWO_PI / 3)) * 3 * 256/TWO_PI);
        rgb.g = (int) (256 - Math.abs((rad - 2 * TWO_PI / 3)) * 3 * 256/TWO_PI);
        rgb.b = (int) (256 - Math.min(Math.abs(rad), Math.abs(rad - TWO_PI)) * 3 * 256/TWO_PI);
      }
    }).createImage(parent);
  }
}

class HSBColorwheelEffect extends SpinImageEffect {
  HSBColorwheelEffect() {
    this(20);
  }

  HSBColorwheelEffect(int rpm) {
    this.rpm = rpm;
  }

  PImage createImage(PApplet parent) {
    return (new Wheel(2 * parent.width + 2 * parent.height) {
      public void setup(PGraphics g) {
        g.colorMode(HSB, 255, 100, 100, 100);
      }
      public void getColor(float rad, CRGB rgb) {
        rgb.r = (int) (rad * 256/TWO_PI);
        rgb.g = 100;
        rgb.b = 75;
      }
    }).createImage(parent);
  }
}
