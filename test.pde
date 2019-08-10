class TestSpinEffect extends SpinImageEffect {
  TestSpinEffect() {
    this(-20);
  }

  TestSpinEffect(int rpm) {
    this.rpm = rpm;
  }

  PImage createImage(PApplet parent) {
    PGraphics g = parent.createGraphics(width, height);
    g.beginDraw();
    g.background(0);
    g.stroke(255);
    g.line(g.width/2, g.height/2, g.width, 0);
    g.stroke(255, 0, 0);
    g.line(g.width/2, g.height/2, g.width, g.height);
    g.stroke(0, 255, 0);
    g.line(g.width/2, g.height/2, 0, g.height);
    g.stroke(0, 0, 255);
    g.line(g.width/2, g.height/2, 0, 0);
    g.endDraw();
    return g;
  }
}

class TestFadeEffect extends PyramidEffect {
  static final int MAX_HUE = 255;
  int rpm;

  TestFadeEffect() {
    this(20);
  }

  TestFadeEffect(int rpm) {
    this.rpm = rpm;
  }

  void start(PGraphics g) {
    g.colorMode(RGB, 255);
  }

  void draw(PGraphics g) {
    final int hue = (int) ((((float) MAX_HUE) * rpm * millis() / 60000) % (MAX_HUE + 1));
    g.background(hue, 255, 255);
  }
}
