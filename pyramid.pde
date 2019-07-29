OPC opc;

int TIME_PER_EFFECT = 10 * 1000; // in millis
int NUMBER_OF_EFFECTS = 1;
int currentEffect = -1;
int timeOfLastEffectChange = 0;

void setup() {
  size(384, 282);

  opc = new OPC(this, "127.0.0.1", 7890);
  setupMapping();

  // SOME OTHER STUFF
}

void setupMapping() {

  float moEyeSpacing = 2; // Per pixel
  float pixelMeterRatio = 64.0; // Number of pixels per meter in Processing
  float l1Size = 1.83 * pixelMeterRatio;
  float l2Size = 2.44 * pixelMeterRatio;
  float l3Size = 3.05 * pixelMeterRatio;
  float pixelSpan = 4; // Disance from the pyramid side to sample pixel color
  float moEyeDist = 0.7;
  int moSize = 70;

  int NORTH = 512 * 0;
  int EAST = 512 * 1;
  int SOUTH = 512 * 2;
  int WEST = 512 * 3;
  int SPECIAL = 512 * 4;


  // Order is always LEFT-RIGHT-TOP-BOTTOM
  // Pay attention to increment the INDEX number

  float centerX = width / 2;
  float centerY = height / 2;
  float x = 0;
  float y = 0;
  float halfSizeWithSpan = 0;

  // Mo Eyes
  float eyeOffsetSideways = (moEyeDist / 2) * moSize / sqrt(2); // sqrt(2) since we're putting Mo at an angle
  float eyeOffsetForwards = 10.0;
  // Assuming Mo faces NE (I think N is the best painted side)
  opc.ledGrid8x8(SPECIAL + 0 * 64, centerX - eyeOffsetSideways + eyeOffsetForwards, centerY - eyeOffsetSideways - eyeOffsetForwards, moEyeSpacing, radians(45), false, false);
  opc.ledGrid8x8(SPECIAL + 1 * 64, centerX + eyeOffsetSideways + eyeOffsetForwards, centerY + eyeOffsetSideways - eyeOffsetForwards, moEyeSpacing, radians(45), false, false);

  // Mo Light Up
  opc.ledStrip(SPECIAL + 2 * 64 +  0, 32, centerX + (46 + 32) / 2, centerY - (46) / 2, 1, radians(270), false);
  opc.ledStrip(SPECIAL + 2 * 64 + 32, 32, centerX + (46) / 2, centerY - (46 + 32) / 2, 1, radians(180), false);

  // Top tier
  halfSizeWithSpan = l1Size / 2 + pixelSpan;

  x = centerX - halfSizeWithSpan;
  opc.ledStrip(WEST  + 6 * 64, 64, x, centerY - 46/2 - 1.5, 1, radians(90), false);
  opc.ledStrip(WEST  + 7 * 64, 46, x, centerY + 64/2 + 1.5, 1, radians(90), false);

  x = centerX + halfSizeWithSpan;
  opc.ledStrip(EAST  + 6 * 64, 64, x, centerY + 46/2 + 1.5, 1, radians(270), false);
  opc.ledStrip(EAST  + 7 * 64, 46, x, centerY - 64/2 - 1.5, 1, radians(270), false);

  y = centerY - halfSizeWithSpan;
  opc.ledStrip(NORTH + 6 * 64, 64, centerX + 46/2 + 1.5, y, 1, radians(180), false);
  opc.ledStrip(NORTH + 7 * 64, 46, centerX - 64/2 - 1.5, y, 1, radians(180), false);

  y = centerY + halfSizeWithSpan;
  opc.ledStrip(SOUTH + 6 * 64, 64, centerX - 46/2 - 1.5, y, 1, 0, false);
  opc.ledStrip(SOUTH + 7 * 64, 46, centerX + 64/2 + 1.5, y, 1, 0, false);

  // Second tier
  halfSizeWithSpan = l2Size / 2 + pixelSpan;

  x = centerX - halfSizeWithSpan;
  opc.ledStrip(WEST + 3 * 64, 64, x, centerY - (64+19)/2 - 3, 1, radians(90), false);
  opc.ledStrip(WEST + 4 * 64, 64, x, centerY + (64-19)/2 + 0, 1, radians(90), false);
  opc.ledStrip(WEST + 5 * 64, 19, x, centerY + (64+64)/2 + 3, 1, radians(90), false);

  x = centerX + halfSizeWithSpan;
  opc.ledStrip(EAST + 3 * 64, 64, x, centerY + (64+19)/2 + 3, 1, radians(270), false);
  opc.ledStrip(EAST + 4 * 64, 64, x, centerY - (64-19)/2 - 0, 1, radians(270), false);
  opc.ledStrip(EAST + 5 * 64, 19, x, centerY - (64+64)/2 - 3, 1, radians(270), false);

  y = centerY - halfSizeWithSpan;
  opc.ledStrip(NORTH + 3 * 64, 64, centerX + (64+19)/2 + 3, y, 1, radians(180), false);
  opc.ledStrip(NORTH + 4 * 64, 64, centerX - (64-19)/2 - 0, y, 1, radians(180), false);
  opc.ledStrip(NORTH + 5 * 64, 19, centerX - (64+64)/2 - 3, y, 1, radians(180), false);

  y = centerY + halfSizeWithSpan;
  opc.ledStrip(SOUTH + 3 * 64, 64, centerX - (64+19)/2 - 3, y, 1, 0, false);
  opc.ledStrip(SOUTH + 4 * 64, 64, centerX + (64-19)/2 + 0, y, 1, 0, false);
  opc.ledStrip(SOUTH + 5 * 64, 19, centerX + (64+64)/2 + 3, y, 1, 0, false);

  // Third tier
  halfSizeWithSpan = l3Size / 2 + pixelSpan;

  x = centerX - halfSizeWithSpan;
  opc.ledStrip(WEST + 0 * 64, 64, x, centerY - (64+56)/2 - 3, 1, radians(90), false);
  opc.ledStrip(WEST + 1 * 64, 64, x, centerY + (64-56)/2 + 0, 1, radians(90), false);
  opc.ledStrip(WEST + 2 * 64, 56, x, centerY + (64+64)/2 + 3, 1, radians(90), false);

  x = centerX + halfSizeWithSpan;
  opc.ledStrip(EAST + 0 * 64, 64, x, centerY + (64+56)/2 + 3, 1, radians(270), false);
  opc.ledStrip(EAST + 1 * 64, 64, x, centerY - (64-56)/2 - 0, 1, radians(270), false);
  opc.ledStrip(EAST + 2 * 64, 56, x, centerY - (64+64)/2 - 3, 1, radians(270), false);

  y = centerY - halfSizeWithSpan;
  opc.ledStrip(NORTH + 0 * 64, 64, centerX + (64+56)/2 + 3, y, 1, radians(180), false);
  opc.ledStrip(NORTH + 1 * 64, 64, centerX - (64-56)/2 - 0, y, 1, radians(180), false);
  opc.ledStrip(NORTH + 2 * 64, 56, centerX - (64+64)/2 - 3, y, 1, radians(180), false);

  y = centerY + halfSizeWithSpan;
  opc.ledStrip(SOUTH + 0 * 64, 64, centerX - (64+56)/2 - 3, y, 1, 0, false);
  opc.ledStrip(SOUTH + 1 * 64, 64, centerX + (64-56)/2 + 0, y, 1, 0, false);
  opc.ledStrip(SOUTH + 2 * 64, 56, centerX + (64+64)/2 + 3, y, 1, 0, false);

}

void draw() {
  boolean shouldSetup = false;
  if (timeOfLastEffectChange + TIME_PER_EFFECT < millis()) {
    timeOfLastEffectChange = millis();
    currentEffect = (currentEffect + 1) % NUMBER_OF_EFFECTS;
    shouldSetup = true;
  }

  switch (currentEffect % 1) {
    case 0:
      colorWheel(shouldSetup);
      break;
    /**
      == TO ADD A NEW EFFECT ==
      - Add a new entry to this switch statement
      - Increment NUMBER_OF_EFFECTS appropriately
      - If you have any only-once-ever setup do it in setup()
      - If you have any reset-for-this-run setup do it in your effect method via if(shouldSetup)
    **/
  }

}

int COLOR_WHEEL_SLICE_SIZE = 2;

int colorWheelRotationAngle = 0;
int colorWheelSlicesPerThird = 120 / COLOR_WHEEL_SLICE_SIZE;
int colorWheelColorChangePerSlice = 256 / colorWheelSlicesPerThird;
int[][] colorWheelRGBStages = {{-1, +1, 0}, {0, -1, +1}, {+1, 0, -1}};
void colorWheel(boolean shouldSetup) {
  if (shouldSetup) {
    colorWheelRotationAngle = 0;
  }

  translate(width/2, height/2); // setting the center of the rotation to middle of the window
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
      arc(0, 0, width*0.9, width*0.9, radians(degree), radians(degree + COLOR_WHEEL_SLICE_SIZE));
      r += rChange * colorWheelColorChangePerSlice;
      g += gChange * colorWheelColorChangePerSlice;
      b += bChange * colorWheelColorChangePerSlice;
      degree += COLOR_WHEEL_SLICE_SIZE;
    }
  }

  colorWheelRotationAngle += COLOR_WHEEL_SLICE_SIZE;
}
