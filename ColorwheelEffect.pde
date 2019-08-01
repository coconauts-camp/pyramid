class RGBColorwheelEffect extends PyramidEffect {
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

class HSB1ColorwheelEffect extends PyramidEffect {
  int SLICE_SIZE = 3;
  int ROTATION_RATE = 2;
  int rotationAngle = 0;

  void reset(PApplet parent) {
    rotationAngle = 0;
    colorMode(HSB, 360, 100, 100, 100);
    background(0, 0, 0);
  }

  void draw(boolean onBeat) {
    translate(width/2, height/2);
    rotate(radians(rotationAngle));

    for (int degree = 0; degree < 360; degree += SLICE_SIZE) {
      fill(degree, 100, 75);
      arc(0, 0, width, width, radians(degree), radians(degree + SLICE_SIZE));
    }

    rotationAngle += ROTATION_RATE;
  }
}

class HSB2ColorwheelEffect extends PyramidEffect {
  int SLICE_SIZE = 3;
  int ROTATION_RATE = 2;
  int rotationAngle = 0;
  CRGB rgb;

  void reset(PApplet parent) {
    rgb = new CRGB();
    rotationAngle = 0;
    colorMode(RGB, 255);
    background(0, 0, 0);
  }

  void draw(boolean onBeat) {
    translate(width/2, height/2);
    rotate(radians(rotationAngle));

    for (int degree = 0; degree < 360; degree += SLICE_SIZE) {
      hsv2rgb_rainbow(degree * 256/360, 255, 255, rgb);
      fill(rgb.r, rgb.g, rgb.b);
      arc(0, 0, width, width, radians(degree), radians(degree + SLICE_SIZE));
    }

    rotationAngle += ROTATION_RATE;
  }
}
