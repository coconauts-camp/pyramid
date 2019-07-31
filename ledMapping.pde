OPC opc;

void setupLedMapping(PApplet parent) {
  opc = new OPC(parent, "127.0.0.1", 7890);

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

