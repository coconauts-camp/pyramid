class HSBColorfadeEffect extends PyramidEffect {
  static final int MAX_HUE = 255;
  int rpm;

  HSBColorfadeEffect() {
    this(20);
  }

  HSBColorfadeEffect(int rpm) {
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
