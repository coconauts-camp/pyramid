int moSize = 70;
float pixelMeterRatio = 64.0; // Number of pixels per meter in Processing
float l1Size = 1.83 * pixelMeterRatio;
float l2Size = 2.44 * pixelMeterRatio;
float l3Size = 3.05 * pixelMeterRatio;
float pixelSpan = 4; // Disance from the pyramid side to sample pixel color
float moEyeDist = 0.7;
float moEyeSize = 0.07117; // meters per side

void setupMapping() {
  // Order is always LEFT-RIGHT-TOP-BOTTOM
  // Pay attention to increment the INDEX number

  float centerX = width/2;
  float centerY = height/2;
  float x = 0;
  float y = 0;
  float halfSizeWithSpan = 0;

  // Mo Eyes
  opc.ledGrid8x8(0 * 64, centerX - moEyeRadius*moEyeDist, centerY, 2, 0, false /* TODO(geophree): zigzag? */, false);
  opc.ledGrid8x8(1 * 64, centerX + moEyeRadius*moEyeDist, centerY, 2, 0, false /* TODO(geophree): zigzag? */, false);

  // L1 - A
  halfSizeWithSpan = l1Size/2 + pixelSpan;
  x = centerX - halfSizeWithSpan;
  opc.ledStrip( 2 * 64, 64, x, centerY - 45/2, 1, 0, false);
  opc.ledStrip( 3 * 64, 45, x, centerY + 64/2, 1, 0, false);
  x = centerX + halfSizeWithSpan;
  opc.ledStrip( 4 * 64, 64, x, centerY - 45/2, 1, 0, false);
  opc.ledStrip( 5 * 64, 45, x, centerY + 64/2, 1, 0, false);
  y = centerY - halfSizeWithSpan;
  opc.ledStrip( 6 * 64, 64, centerX - 45/2, y, 1, 0, false);
  opc.ledStrip( 7 * 64, 45, centerX + 64/2, y, 1, 0, false);
  y = centerY + halfSizeWithSpan;
  opc.ledStrip( 8 * 64, 64, centerX - 45/2, y, 1, 0, false);
  opc.ledStrip( 9 * 64, 45, centerX + 64/2, y, 1, 0, false);

  // L2 - B
  halfSizeWithSpan = l2Size/2 + pixelSpan;
  x = centerX - halfSizeWithSpan;
  opc.ledStrip(10 * 64, 64, x, centerY - (64+18)/2, 1, 0, false; // INCOMPLETE?
  opc.ledStrip(11 * 64, 64, x, centerY + (64+ 0)/2, 1, 0, false; // INCOMPLETE?
  opc.ledStrip(12 * 64, 18, x, centerY + (64+64)/2, 1, 0, false; // INCOMPLETE?

  x = centerX + halfSizeWithSpan;
  opc.ledStrip(13 * 64, 64, x, centerY - (64+18)/2, 1, 0, false; // INCOMPLETE?
  opc.ledStrip(14 * 64, 64, x, centerY + (64+ 0)/2, 1, 0, false; // INCOMPLETE?
  opc.ledStrip(15 * 64, 18, x, centerY + (64+64)/2, 1, 0, false; // INCOMPLETE?

  y = centerY - halfSizeWithSpan;
  opc.ledStrip(16 * 64, 64, centerX - (64+18)/2, y, 1, 0, false; // INCOMPLETE?
  opc.ledStrip(17 * 64, 64, centerX - (64+ 0)/2, y, 1, 0, false; // INCOMPLETE?
  opc.ledStrip(18 * 64, 18, centerX - (64+64)/2, y, 1, 0, false; // INCOMPLETE?

  y = centerY + halfSizeWithSpan;
  opc.ledStrip(19 * 64, 64, centerX - (64+18)/2, y, 1, 0, false; // B-B1-RGB
  opc.ledStrip(20 * 64, 64, centerX + (64+ 0)/2, y, 1, 0, false; // B-B1-RGB
  opc.ledStrip(21 * 64, 18, centerX + (64+64)/2, y, 1, 0, false; // B-B1-RGB

  // INCOMPLETE
}

// INCOMPLETE
