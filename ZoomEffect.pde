class ZoomImageEffect extends PyramidEffect {
  float maxZoom;
  int duration;
  int startMillis;
  float resizeWidth;
  float resizeHeight;
  PImage im;

  ZoomImageEffect(PImage im) {
    this(im, 10);
  }

  ZoomImageEffect(PImage im, float maxZoom) {
    this(im, maxZoom, 15000);
  }

  ZoomImageEffect(PImage im, float maxZoom, int duration) {
    this.im = im;
    this.maxZoom = maxZoom;
    this.duration = duration;
  }

  int duration() {
    return duration;
  }

  void start(PGraphics g) {
    startMillis = millis();
    g.imageMode(CENTER);
  }

  void updateDimensions(PGraphics g) {
    if (resizeWidth != 0 || resizeHeight != 0) return;
    float imageAspect = ((float) im.width) / im.height;
    float aspect = ((float) g.width) / g.height;
    if (imageAspect > aspect) {
      resizeWidth = im.width * g.height / im.height;
      resizeHeight = g.height;
    } else {
      resizeWidth = g.width;
      resizeHeight = im.height * g.width / im.width;
    }
  }

  void draw(PGraphics g) {
    updateDimensions(g);
    final double zoom = Math.pow(maxZoom, ((double) millis() - startMillis) / duration);
    g.image(im, g.width/2, g.height/2, (float) (resizeWidth * zoom), (float) (resizeHeight * zoom));
  }
}
