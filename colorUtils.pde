// from https://github.com/FastLED/FastLED/blob/dcbf39933f51a2a0e4dfa0a2b3af4f50040df5c9/lib8tion/scale8.h

//  scale one byte by a second one, which is treated as
//  the numerator of a fraction whose denominator is 256
//  In other words, it computes i * (scale / 256)
byte scale8(byte i, byte scale) {
  return (byte) (((i & 0xFF) * (1+(scale & 0xFF))) >> 8);
}

byte scale8(byte i, int scale) {
  return scale8(i, (byte) scale);
}

//  The "video" version of scale8 guarantees that the output will
//  be only be zero if one or both of the inputs are zero.  If both
//  inputs are non-zero, the output is guaranteed to be non-zero.
//  This makes for better 'video'/LED dimming, at the cost of
//  several additional cycles.
byte scale8_video(byte i, byte scale) {
  return (byte) (scale8(i, scale) + ((i == 0 && scale == 0) ? 1 : 0));
}

// from https://github.com/FastLED/FastLED/blob/dcbf39933f51a2a0e4dfa0a2b3af4f50040df5c9/hsv2rgb.cpp
static final byte K255 = (byte) 255;
static final byte K171 = (byte) 171;
static final byte K170 = (byte) 170;
static final byte K85  = (byte) 85;

class CRGB {
  public int r;
  public int g;
  public int b;
}

void hsv2rgb_rainbow( int h, int s, int v, CRGB rgb)
{
  // Yellow has a higher inherent brightness than
  // any other color; 'pure' yellow is perceived to
  // be 93% as bright as white.  In order to make
  // yellow appear the correct relative brightness,
  // it has to be rendered brighter than all other
  // colors.
  // Level Y1 is a moderate boost, the default.
  // Level Y2 is a strong boost.
  final byte Y1 = 1;
  final byte Y2 = 0;

  // G2: Whether to divide all greens by two.
  // Depends GREATLY on your particular LEDs
  final byte G2 = 0;

  // Gscale: what to scale green down by.
  // Depends GREATLY on your particular LEDs
  final byte Gscale = 0;


  byte hue = (byte) h;
  byte sat = (byte) s;
  byte val = (byte) v;

  byte offset = (byte) (hue & 0x1F); // 0..31

  // offset8 = offset * 8
  byte offset8 = offset;
  offset8 <<= 3;

  byte third = scale8( offset8, (256 / 3)); // max = 85

  byte r, g, b;

  if( (hue & 0x80) == 0 ) {
    // 0XX
    if( (hue & 0x40) == 0 ) {
      // 00X
      //section 0-1
      if( (hue & 0x20) == 0 ) {
        // 000
        //case 0: // R -> O
        r = (byte) (K255 - third);
        g = third;
        b = 0;
      } else {
        // 001
        //case 1: // O -> Y
        if( Y1 != 0 ) {
          r = K171;
          g = (byte) (K85 + third);
          b = 0;
        }
        if( Y2 != 0 ) {
          r = (byte) (K170 + third);
          //byte twothirds = (third << 1);
          byte twothirds = scale8( offset8, ((256 * 2) / 3)); // max=170
          g = (byte) (K85 + twothirds);
          b = 0;
        }
      }
    } else {
      //01X
      // section 2-3
      if( (hue & 0x20) == 0 ) {
        // 010
        //case 2: // Y -> G
        if( Y1 != 0 ) {
          //byte twothirds = (third << 1);
          byte twothirds = scale8( offset8, ((256 * 2) / 3)); // max=170
          r = (byte) (K171 - twothirds);
          g = (byte) (K170 + third);
          b = 0;
        }
        if( Y2 != 0 ) {
          r = (byte) (K255 - offset8);
          g = K255;
          b = 0;
        }
      } else {
        // 011
        // case 3: // G -> A
        r = 0;
        g = (byte) (K255 - third);
        b = third;
      }
    }
  } else {
    // section 4-7
    // 1XX
    if( (hue & 0x40) == 0 ) {
      // 10X
      if( ( hue & 0x20) == 0 ) {
        // 100
        //case 4: // A -> B
        r = 0;
        //byte twothirds = (third << 1);
        byte twothirds = scale8( offset8, ((256 * 2) / 3)); // max=170
        g = (byte) (K171 - twothirds); //K170?
        b = (byte) (K85  + twothirds);

      } else {
        // 101
        //case 5: // B -> P
        r = third;
        g = 0;
        b = (byte) (K255 - third);

      }
    } else {
      if( (hue & 0x20) == 0 ) {
        // 110
        //case 6: // P -- K
        r = (byte) (K85 + third);
        g = 0;
        b = (byte) (K171 - third);

      } else {
        // 111
        //case 7: // K -> R
        r = (byte) (K170 + third);
        g = 0;
        b = (byte) (K85 - third);

      }
    }
  }

  // This is one of the good places to scale the green down,
  // although the client can scale green down as well.
  if( G2 != 0 ) g = (byte) (g >> 1);
  if( Gscale != 0 ) g = scale8_video( g, Gscale);

  // Scale down colors if we're desaturated at all
  // and add the brightness_floor to r, g, and b.
  if( sat != 255 ) {
    if( sat == 0) {
      r = (byte) 255; b = (byte) 255; g = (byte) 255;
    } else {
      //nscale8x3_video( r, g, b, sat);
      if( r != 0 ) r = scale8( r, sat);
      if( g != 0 ) g = scale8( g, sat);
      if( b != 0 ) b = scale8( b, sat);

      byte desat = (byte) (255 - sat);
      desat = scale8( desat, desat);

      byte brightness_floor = desat;
      r += brightness_floor;
      g += brightness_floor;
      b += brightness_floor;
    }
  }

  // Now scale everything down if we're at value < 255.
  if( val != 255 ) {

    val = scale8_video( val, val);
    if( val == 0 ) {
      r=0; g=0; b=0;
    } else {
      // nscale8x3_video( r, g, b, val);
      if( r != 0 ) r = scale8( r, val);
      if( g != 0 ) g = scale8( g, val);
      if( b != 0 ) b = scale8( b, val);
    }
  }

  // Here we have the old AVR "missing std X+n" problem again
  // It turns out that fixing it winds up costing more than
  // not fixing it.
  // To paraphrase Dr Bronner, profile! profile! profile!
  //asm volatile(  ""  :  :  : "r26", "r27" );
  //asm volatile (" movw r30, r26 \n" : : : "r30", "r31");
  rgb.r = r & 0xFF;
  rgb.g = g & 0xFF;
  rgb.b = b & 0xFF;
}
