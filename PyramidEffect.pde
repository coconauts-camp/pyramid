abstract class PyramidEffect implements Effect {
  /// Called once after other pyramid setup is done
  void setup(PApplet parent) { }
  /// Called to determine how long to play the effect for (milliseconds)
  int duration() { return 15000; }
  /// Called each time the effect is switched to
  void start(PGraphics g) { }
  /// Called each time the effect is switched away from
  void stop(PGraphics g) { }
  /// Called to draw the effect
  abstract void draw(PGraphics g);
}
