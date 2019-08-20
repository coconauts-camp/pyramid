class TestSpinEffect extends SpinImageEffect {
  TestSpinEffect() {
    this(-2);
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
  static final int MILLIS_PER_COLOR = 5000;
  int startMillis;

  void start(PGraphics g) {
    g.colorMode(RGB, 255);
    startMillis = millis();
  }

  void draw(PGraphics g) {
    final int mils = (millis() - startMillis) % (3 * MILLIS_PER_COLOR);
    final int red = (int) (256 - Math.abs((mils - 1 * MILLIS_PER_COLOR / 2)) * 2 * 256/MILLIS_PER_COLOR);
    final int green = (int) (256 - Math.abs((mils - 3 * MILLIS_PER_COLOR / 2)) * 2 * 256/MILLIS_PER_COLOR);
    final int blue = (int) (256 - Math.abs((mils - 5 * MILLIS_PER_COLOR / 2)) * 2 * 256/MILLIS_PER_COLOR);
    g.background(red, green, blue);
  }
}
