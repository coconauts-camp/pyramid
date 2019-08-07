static class Point {
  float x;
  float y;
  static Point create(float x, float y) {
    Point p = new Point();
    p.x = x;
    p.y = y;
    return p;
  }
}

// rotate point around the origin, angle in radians
static void rotatePoint(Point p, float angle) {
  float x = p.x;
  float y = p.y;
  p.x = (float) (x * Math.cos(angle) + y * Math.sin(angle));
  p.y = (float) (x * Math.sin(angle) - y * Math.cos(angle));
}
