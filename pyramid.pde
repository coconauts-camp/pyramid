int moSize = 70;
float l1Size = 183 * pixelMeterRatio;
float l2Size = 244 * pixelMeterRatio;
float l3Size = 305 * pixelMeterRatio;
float moEyeDist = 0.7;

void setupMapping() {
  // Order is always LEFT-RIGHT-TOP-BOTTOM
  // Pay attention to increment the INDEX number

  // Mo Eyes
  opc.ledGrid8x8(0 * 64, width/2 - moEyeRadius*moEyeDist, height/2, 2, // INCOMPLETE
  opc.ledGrid8x8(1 * 64, width/2 + moEyeRadius*moEyeDist, height/2, 2, // INCOMPLETE

  // L1 - A
  opc.ledStrip(2 * 64, 64, width/2 - l1Size/2 - pixelSpan, height/2 -  // INCOMPLETE
  opc.ledStrip(3 * 64, 45, width/2 - l1Size/2 - pixelSpan, height/2 +  // INCOMPLETE
  opc.ledStrip(4 * 64, 64, width/2 + l1Size/2 + pixelSpan, height/2 -  // INCOMPLETE
  opc.ledStrip(5 * 64, 45, width/2 + l1Size/2 + pixelSpan, height/2 +  // INCOMPLETE
  opc.ledStrip(6 * 64, 64, width/2 - 45/2, height/2 - l1Size/2 - pixel // INCOMPLETE
  opc.ledStrip(7 * 64, 45, width/2 + 64/2, height/2 - l1Size/2 - pixel // INCOMPLETE
  opc.ledStrip(8 * 64, 64, width/2 - 45/2, height/2 + l1Size/2 + pixel // INCOMPLETE
  opc.ledStrip(9 * 64, 45, width/2 + 64/2, height/2 + l1Size/2 + pixel // INCOMPLETE

  // L2 - B
  opc.ledStrip(10 * 64, 64, width/2 - l2Size/2 - pixelSpan, height/2 - // INCOMPLETE
  opc.ledStrip(11 * 64, 64, width/2 - l2Size/2 - pixelSpan, height/2 + // INCOMPLETE
  opc.ledStrip(12 * 64, 18, width/2 - l2Size/2 - pixelSpan, height/2 + // INCOMPLETE

  opc.ledStrip(13 * 64, 64, width/2 + l2Size/2 + pixelSpan, height/2 - // INCOMPLETE
  opc.ledStrip(14 * 64, 64, width/2 + l2Size/2 + pixelSpan, height/2 + // INCOMPLETE
  opc.ledStrip(15 * 64, 18, width/2 + l2Size/2 + pixelSpan, height/2 + // INCOMPLETE

  opc.ledStrip(16 * 64, 64, width/2 - (64+18)/2, height/2 - l2Size/2 - // INCOMPLETE
  opc.ledStrip(17 * 64, 64, width/2 - 64/2, height/2 - l2Size/2 - pixe // INCOMPLETE
  opc.ledStrip(18 * 64, 18, width/2 - (64+64)/2, height/2 - l2Size/2 - // INCOMPLETE

  opc.ledStrip(19 * 64, 64, width/2 - (64+18)/2, height/2 + l2Size/2 + pixelSpan , 1, 0, false; // B-B1-RGB
  opc.ledStrip(20 * 64, 64, width/2 + 64/2, height/2 + l2Size/2 + pixelSpan , 1, 0, false;      // B-B1-RGB
  opc.ledStrip(21 * 64, 18, width/2 + (64+64)/2, height/2 + l2Size/2 + pixelSpan , 1, 0, false; // B-B1-RGB

  // INCOMPLETE
}

// INCOMPLETE
