class HSB1ColorfadeEffect extends PyramidEffect {
  static final int MAX_HUE = 255;
  int rpm;

  HSB1ColorfadeEffect() {
    this(20);
  }

  HSB1ColorfadeEffect(int rpm) {
    this.rpm = rpm;
  }

  void reset(PGraphics g) {
    g.colorMode(HSB, 255);
  }

  void draw(PGraphics g) {
    final int hue = (int) ((((float) MAX_HUE) * rpm * millis() / 60000) % (MAX_HUE + 1));
    g.background(hue, 255, 255);
  }
}

// Uses different (better?) HSV space from https://github.com/FastLED/FastLED/wiki/FastLED-HSV-Colors
class HSB2ColorfadeEffect extends PyramidEffect {
  static final int MAX_HUE = 255;
  int rpm = 60;
  CRGB rgb;

  HSB2ColorfadeEffect() {
    this(20);
  }

  HSB2ColorfadeEffect(int rpm) {
    this.rpm = rpm;
  }

  void setup(PApplet parent) {
    rgb = new CRGB();
  }

  void reset(PGraphics g) {
    g.colorMode(RGB, 255);
  }

  void draw(PGraphics g) {
    final int hue = (int) ((((float) MAX_HUE) * rpm * millis() / 60000) % (MAX_HUE + 1));
    hsv2rgb_rainbow(hue, 255, 255, rgb);
    g.background(rgb.r, rgb.g, rgb.b);
  }
}
