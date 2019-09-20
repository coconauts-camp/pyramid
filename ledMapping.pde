OPC opc;

static final float pixelMeterRatio = 60.0; // # of pixels/m for lightstrips

static class Pyramid {
  static final int[] levelLedsWidth = {
    64 + 46,          // A
    64 + 64 + 19 + 1, // B +1 phantom led to make an even number
    64 + 64 + 56,     // C
  };

  static final int[][] ledStartSigns = {
    // x, y, strip direction (degrees)
    { 1, -1, 180}, // N Pattern-painted side
    { 1,  1, 270}, // E Good painted side
    {-1,  1,   0}, // S Splatter painted side
    {-1, -1,  90}, // W Good German painted side
  };
}

//      ______           ____
//     /      \         /    \
//    /  *  *  \       /      \
//  _/__________\_   _/_______ \
// |              | |           \
// |______________| |____________\
static class Mo {
  static final float baseWidth = 1.32 * pixelMeterRatio; // 4'4"
  static final float baseDepth = 0.99 * pixelMeterRatio; // 3'3"
  static final float topWidth  = 0.91 * pixelMeterRatio; // 3'
  static final float topDepth  = 0.53 * pixelMeterRatio; // 1'9"
  static final float height    = 1.83 * pixelMeterRatio; // 6'
  static final float eyeDist   = 0.61 * pixelMeterRatio; // 2' center to center

  // Set the location of Mo's LEDs.
  // angle is in radians, measured clockwise from +x.
  // (x,y) is the center of Mo.
  static void placeLeds(OPC opc, int index, float x, float y, float angle) {
    // Mo eyes
    float eyeX = topDepth / 2;
    float eyeY = eyeDist / 2;

    // as if at the origin facing +X (E)
    // Everything is counter clockwise direction because that's how the strips
    // are connected to the pyramid.
    //  ____________
    // |\       _   |
    // |  \ ____ /| |
    // |   |    | | |
    // |   |    |*| |
    // |   |    |^| ^
    // |   |    |*| |
    // |   |____| | |
    // |  /     _\| |
    // |/___________|

    Point eyeR = Point.create(eyeX,  eyeY);
    Point eyeL = Point.create(eyeX, -eyeY);
    // now rotate to correct angle
    rotatePoint(eyeR, angle);
    rotatePoint(eyeL, angle);
    opc.ledGrid8x8(index + 0 * 64, x + eyeR.x, y + eyeR.y, 1, angle, false, false);
    opc.ledGrid8x8(index + 1 * 64, x + eyeL.x, y + eyeL.y, 1, angle, false, false);

    // Mo up light
    float halfWidth = baseWidth / 2;
    float halfDepth = baseDepth / 2;
    // as if at the origin facing +X (E)
    Point u1 = Point.create(halfDepth,  halfWidth);
    Point u2 = Point.create(halfDepth, -halfWidth);

    // now rotate to correct angle
    rotatePoint(u1, angle);
    rotatePoint(u2, angle);
    ledStripByEndpoints(opc, index + 2 * 64, 64, x + u1.x, y + u1.y, x + u2.x, y + u2.y, false);

  }

}

// Set the location of several LEDs arranged in a strip.
// (x1,y1) is start, x2, y2 is the end.
static void ledStripByEndpoints(OPC opc, int index, int count, float x1, float y1, float x2, float y2, boolean reversed)
{
  float dx = (x2 - x1) / count;
  float dy = (y2 - y1) / count;
  for (int i = 0; i < count; i++) {
    opc.led(reversed ? (index + count - 1 - i) : (index + i),
      (int)(x1 + dx * i + 0.5),
      (int)(y1 + dy * i + 0.5));
  }
}

void setupLedMapping(PApplet parent) {
  opc = new OPC(parent, "127.0.0.1", 7890);

  int[] sideStartLed = {
    512 * 0, // N
    512 * 1, // E
    512 * 2, // S
    512 * 3, // W
  };

  int[] levelStartLedOffest = {
    64 * 0, // A
    64 * 2, // B
    64 * 5, // C
  };

  int SPECIAL = 512 * 4;

  float centerX = width / 2;
  float centerY = height / 2;

  // Mo faces NE
  Mo.placeLeds(opc, SPECIAL, centerX, centerY, radians(315));

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

  // levels
  for (int i = 0; i < sideStartLed.length; i++) {
    for (int j = 0; j < Pyramid.levelLedsWidth.length; j++) {
      int[] ss = Pyramid.ledStartSigns[i];
      int ledsWidth = Pyramid.levelLedsWidth[j];
      float halfLedsWidth = ledsWidth / 2.0;
      int stripStartLed = sideStartLed[i] + levelStartLedOffest[j];
      float x1 = centerX + ss[0] * halfLedsWidth;
      float y1 = centerY + ss[1] * halfLedsWidth;
      float x2 = centerX + ss[1] * halfLedsWidth;
      float y2 = centerY - ss[0] * halfLedsWidth;
      ledStripByEndpoints(opc, stripStartLed, ledsWidth, x1, y1, x2, y2, false);
    }
  }
}

