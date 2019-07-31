class ColorwheelEffect extends PyramidEffect {
  int COLOR_WHEEL_SLICE_SIZE = 3;
  int COLOR_WHEEL_ROTATION_RATE = 2;
  int colorWheelRotationAngle = 0;
  int colorWheelSlicesPerThird = 120 / COLOR_WHEEL_SLICE_SIZE;
  int colorWheelColorChangePerSlice = 256 / colorWheelSlicesPerThird;
  int[][] colorWheelRGBStages = {{-1, +1, 0}, {0, -1, +1}, {+1, 0, -1}};

  void reset(PApplet parent) {
      colorWheelRotationAngle = 0;
      background(0);
      colorMode(RGB, 255);
  }

  void draw(boolean onBeat) {
    translate(width/2, height/2);
    rotate(radians(colorWheelRotationAngle));

    int r = 255;
    int g = 0;
    int b = 0;
    int degree = 0;

    for (int[] rgbStage : colorWheelRGBStages) {
      int rChange = rgbStage[0];
      int gChange = rgbStage[1];
      int bChange = rgbStage[2];

      for (int i = 0; i < colorWheelSlicesPerThird; i += 1) {
        fill(r, g, b);
        arc(0, 0, width, width, radians(degree), radians(degree + COLOR_WHEEL_SLICE_SIZE));
        r += rChange * colorWheelColorChangePerSlice;
        g += gChange * colorWheelColorChangePerSlice;
        b += bChange * colorWheelColorChangePerSlice;
        degree += COLOR_WHEEL_SLICE_SIZE;
      }
    }

    colorWheelRotationAngle += COLOR_WHEEL_ROTATION_RATE;
  }

}
