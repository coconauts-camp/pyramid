import processing.video.*;

/// Plays a video centered with the longer dimension cut off
class MovieEffect extends PyramidEffect {
  String filename;
  Movie m;
  int resizeWidth;
  int resizeHeight;
  PImage currentFrame;
  int duration; // milliseconds

  MovieEffect(String filename) {
    this.filename = filename;
  }

  int duration() {
    return duration;
  }

  void setup(PApplet parent) {
    m = new Movie(parent, filename);
    m.noLoop();
    m.play();
    m.volume(0);
    duration = (int) (m.duration() * 1000);
    m.stop();
  }

  void start(PGraphics g) {
    g.imageMode(CENTER);
    m.play();
  }

  void stop(PGraphics g) {
    m.stop();
    currentFrame = null;
  }

  void captureFrame() {
    m.read();
    currentFrame = m.get();
    updateDimensions();
    currentFrame.resize(resizeWidth, resizeHeight);
  }

  void updateDimensions() {
    if (resizeWidth != 0 || resizeHeight != 0) return;
    float movieAspect = ((float) currentFrame.width) / currentFrame.height;
    float aspect = ((float) width) / height;
    if (movieAspect > aspect) {
      resizeWidth = 0;
      resizeHeight = height;
    } else {
      resizeWidth = width;
      resizeHeight = 0;
    }
  }

  void draw(PGraphics g) {
    if (m.available()) captureFrame();
    if (currentFrame != null) {
      g.image(currentFrame, width/2, height/2);
    }
  }
}
