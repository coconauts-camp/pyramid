class HSB1ColorfadeEffect extends PyramidEffect {
  static final int MAX_HUE = 255;
  int rpm = 60;

  void reset(PApplet parent) {
    colorMode(HSB, 255);
  }

  void draw(boolean onBeat) {
    final int hue = (int) ((((float) MAX_HUE) * rpm * millis() / 60000) % (MAX_HUE + 1));
    background(hue, 255, 255);
  }
}

// Uses different (better?) HSV space from https://github.com/FastLED/FastLED/wiki/FastLED-HSV-Colors
class HSB2ColorfadeEffect extends PyramidEffect {
  static final int MAX_HUE = 255;
  int rpm = 60;
  CRGB rgb;

  void setup(PApplet parent) {
    rgb = new CRGB();
  }

  void reset(PApplet parent) {
    colorMode(RGB, 255);
  }

  void draw(boolean onBeat) {
    final int hue = (int) ((((float) MAX_HUE) * rpm * millis() / 60000) % (MAX_HUE + 1));
    hsv2rgb_rainbow(hue, 255, 255, rgb);
    background(rgb.r, rgb.g, rgb.b);
  }
}
