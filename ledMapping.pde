OPC opc;

static final float pixelMeterRatio = 60.0; // # of pixels/m for lightstrips

class Pyramid {
  static final float l1Size = 1.83 * pixelMeterRatio; //  6'
  static final float l2Size = 2.44 * pixelMeterRatio; //  8'
  static final float l3Size = 3.05 * pixelMeterRatio; // 10'
}

class Mo {
  static final float baseWidth = 1.32 * pixelMeterRatio; // 4'4"
  static final float baselength = .99 * pixelMeterRatio; // 3'3"
  static final float height = 1.83 * pixelMeterRatio; //    6'

  static final int moSize = 70;
  // Mo Eyes
  static final float eyeDist = 0.7;
  static final float eyeOffsetSideways = (eyeDist / 2) * moSize / 1.4142; // sqrt(2) since we're putting Mo at an angle
  static final float eyeOffsetForwards = 10.0;
  // Assuming Mo faces NE (I think N is the best painted side)
}

void setupLedMapping(PApplet parent) {
  opc = new OPC(parent, "127.0.0.1", 7890);

  float moEyeSpacing = 2; // place every other pixel

  int NORTH = 512 * 0;
  int EAST = 512 * 1;
  int SOUTH = 512 * 2;
  int WEST = 512 * 3;
  int SPECIAL = 512 * 4;

  float centerX = width / 2;
  float centerY = height / 2;
  float x = 0;
  float y = 0;
  float halfSize = 0;

  opc.ledGrid8x8(SPECIAL + 0 * 64, centerX - Mo.eyeOffsetSideways + Mo.eyeOffsetForwards, centerY - Mo.eyeOffsetSideways - Mo.eyeOffsetForwards, moEyeSpacing, radians(45), false, false);
  opc.ledGrid8x8(SPECIAL + 1 * 64, centerX + Mo.eyeOffsetSideways + Mo.eyeOffsetForwards, centerY + Mo.eyeOffsetSideways - Mo.eyeOffsetForwards, moEyeSpacing, radians(45), false, false);

  // Mo Light Up
  opc.ledStrip(SPECIAL + 2 * 64 +  0, 32, centerX + (46 + 32) / 2, centerY - (46) / 2, 1, radians(270), false);
  opc.ledStrip(SPECIAL + 2 * 64 + 32, 32, centerX + (46) / 2, centerY - (46 + 32) / 2, 1, radians(180), false);

  // Level orientation
  // "arrow" is strip direction
  //
  // 0,0
  //    +->+x
  //    |       N
  //    V    +--<--+
  //   +y    |     |
  //       W V     ^ E
  //         |     |
  //         +-->--+
  //            S

  // Top tier
  halfSize = Pyramid.l1Size / 2;

  x = centerX - halfSize;
  opc.ledStrip(WEST  + 6 * 64, 64, x, centerY - 46/2 - 1.5, 1, radians(90), false);
  opc.ledStrip(WEST  + 7 * 64, 46, x, centerY + 64/2 + 1.5, 1, radians(90), false);

  x = centerX + halfSize;
  opc.ledStrip(EAST  + 0 * 64, 64, x, centerY + 46/2 + 1.5, 1, radians(270), false);
  opc.ledStrip(EAST  + 1 * 64, 46, x, centerY - 64/2 - 1.5, 1, radians(270), false);

  y = centerY - halfSize;
  opc.ledStrip(NORTH + 0 * 64, 64, centerX + 46/2 + 1.5, y, 1, radians(180), false);
  opc.ledStrip(NORTH + 1 * 64, 46, centerX - 64/2 - 1.5, y, 1, radians(180), false);

  y = centerY + halfSize;
  opc.ledStrip(SOUTH + 0 * 64, 64, centerX - 46/2 - 1.5, y, 1, 0, false);
  opc.ledStrip(SOUTH + 1 * 64, 46, centerX + 64/2 + 1.5, y, 1, 0, false);

  // Second tier
  halfSize = Pyramid.l2Size / 2;

  x = centerX - halfSize;
  opc.ledStrip(WEST + 2 * 64, 64, x, centerY - (64+19)/2 - 3, 1, radians(90), false);
  opc.ledStrip(WEST + 3 * 64, 64, x, centerY + (64-19)/2 + 0, 1, radians(90), false);
  opc.ledStrip(WEST + 4 * 64, 19, x, centerY + (64+64)/2 + 3, 1, radians(90), false);

  x = centerX + halfSize;
  opc.ledStrip(EAST + 2 * 64, 64, x, centerY + (64+19)/2 + 3, 1, radians(270), false);
  opc.ledStrip(EAST + 3 * 64, 64, x, centerY - (64-19)/2 - 0, 1, radians(270), false);
  opc.ledStrip(EAST + 4 * 64, 19, x, centerY - (64+64)/2 - 3, 1, radians(270), false);

  y = centerY - halfSize;
  opc.ledStrip(NORTH + 2 * 64, 64, centerX + (64+19)/2 + 3, y, 1, radians(180), false);
  opc.ledStrip(NORTH + 3 * 64, 64, centerX - (64-19)/2 - 0, y, 1, radians(180), false);
  opc.ledStrip(NORTH + 4 * 64, 19, centerX - (64+64)/2 - 3, y, 1, radians(180), false);

  y = centerY + halfSize;
  opc.ledStrip(SOUTH + 2 * 64, 64, centerX - (64+19)/2 - 3, y, 1, 0, false);
  opc.ledStrip(SOUTH + 3 * 64, 64, centerX + (64-19)/2 + 0, y, 1, 0, false);
  opc.ledStrip(SOUTH + 4 * 64, 19, centerX + (64+64)/2 + 3, y, 1, 0, false);

  // Third tier
  halfSize = Pyramid.l3Size / 2;

  x = centerX - halfSize;
  opc.ledStrip(WEST + 5 * 64, 64, x, centerY - (64+56)/2 - 3, 1, radians(90), false);
  opc.ledStrip(WEST + 6 * 64, 64, x, centerY + (64-56)/2 + 0, 1, radians(90), false);
  opc.ledStrip(WEST + 7 * 64, 56, x, centerY + (64+64)/2 + 3, 1, radians(90), false);

  x = centerX + halfSize;
  opc.ledStrip(EAST + 5 * 64, 64, x, centerY + (64+56)/2 + 3, 1, radians(270), false);
  opc.ledStrip(EAST + 6 * 64, 64, x, centerY - (64-56)/2 - 0, 1, radians(270), false);
  opc.ledStrip(EAST + 7 * 64, 56, x, centerY - (64+64)/2 - 3, 1, radians(270), false);

  y = centerY - halfSize;
  opc.ledStrip(NORTH + 5 * 64, 64, centerX + (64+56)/2 + 3, y, 1, radians(180), false);
  opc.ledStrip(NORTH + 6 * 64, 64, centerX - (64-56)/2 - 0, y, 1, radians(180), false);
  opc.ledStrip(NORTH + 7 * 64, 56, centerX - (64+64)/2 - 3, y, 1, radians(180), false);

  y = centerY + halfSize;
  opc.ledStrip(SOUTH + 5 * 64, 64, centerX - (64+56)/2 - 3, y, 1, 0, false);
  opc.ledStrip(SOUTH + 6 * 64, 64, centerX + (64-56)/2 + 0, y, 1, 0, false);
  opc.ledStrip(SOUTH + 7 * 64, 56, centerX + (64+64)/2 + 3, y, 1, 0, false);

}

