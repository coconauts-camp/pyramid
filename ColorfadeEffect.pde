class HSB1ColorfadeEffect extends PyramidEffect {
  int CHANGE_RATE = 2;
  int MAX_HUE = 255;
  int hue = 0;

  void reset(PApplet parent) {
    hue = 0;
    colorMode(HSB, 255);
  }

  void draw(boolean onBeat) {
    background(hue, 255, 255);
    hue = (hue + CHANGE_RATE) % (MAX_HUE + 1);
  }
}

// Uses different (better?) HSV space from https://github.com/FastLED/FastLED/wiki/FastLED-HSV-Colors
class HSB2ColorfadeEffect extends PyramidEffect {
  int CHANGE_RATE = 2;
  int MAX_HUE = 255;
  int hue = 0;
  CRGB rgb;

  void setup(PApplet parent) {
    rgb = new CRGB();
  }

  void reset(PApplet parent) {
    hue = 0;
    colorMode(RGB, 255);
  }

  void draw(boolean onBeat) {
    hsv2rgb_rainbow(hue, 255, 255, rgb);
    background(rgb.r, rgb.g, rgb.b);
    hue = (hue + CHANGE_RATE) % (MAX_HUE + 1);
  }
}
