import processing.video.*;
import processing.sound.*;

OPC opc;

// For soundBar
Amplitude amplitude;
AudioIn in;
int bands = 1024;
float[] spectrum = new float[bands];

void setup() {
  size(300, 300);

  opc = new OPC(this, "127.0.0.1", 7890);
  noStroke();
  setupMapping();

  // For soundBar
  amplitude = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amplitude.input(in);

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

int TIME_PER_EFFECT = 15 * 1000; // in millis
int NUMBER_OF_EFFECTS = 2;
int currentEffect = -1;
int timeOfLastEffectChange = 0 - TIME_PER_EFFECT;

void draw() {
  boolean shouldSetup = false;
  if (timeOfLastEffectChange + TIME_PER_EFFECT < millis()) {
    timeOfLastEffectChange = millis();
    currentEffect = (currentEffect + 1) % NUMBER_OF_EFFECTS;
    shouldSetup = true;
  }

  pushMatrix();

  boolean onBeat = detectBeat();

  switch (currentEffect % NUMBER_OF_EFFECTS) {
    case 0:
      colorWheel(shouldSetup, onBeat);
      break;
    case 1:
      soundBar(shouldSetup, onBeat);
      break;
    /**
      == TO ADD A NEW EFFECT ==
      - Add a new entry to this switch statement
      - Increment NUMBER_OF_EFFECTS appropriately
      - If you have any only-once-ever setup do it in setup()
      - If you have any reset-for-this-run setup do it in your effect method via if(shouldSetup)
    **/
  }

  popMatrix();

  if (onBeat) {
    print("Beat\n");
    fill(255);
  } else {
    fill(0);
  }
  rect(10, 10, 20, 20);

}



// :: Beat Detect Variables
// how many draw loop frames before the beatCutoff starts to decay
// so that another beat can be triggered.
// frameRate() is usually around 60 frames per second,
// so 20 fps = 3 beats per second, meaning if the song is over 180 BPM,
// we wont respond to every beat.
int beatHoldFrames = 20;

// what amplitude level can trigger a beat?
float beatThreshold = 0.01;

// When we have a beat, beatCutoff will be reset to 1.1*beatThreshold, and then decay
// Level must be greater than beatThreshold and beatCutoff before the next beat can trigger.
float beatCutoff = 0;
float beatDecayRate = 0.98; // how fast does beat cutoff decay?
int framesSinceLastBeat = 0; // once this equals beatHoldFrames, beatCutoff starts to decay.

boolean detectBeat() {
  float level = amplitude.analyze();

  if (level  > beatCutoff && level > beatThreshold) {
    beatCutoff = level * 1.2;
    framesSinceLastBeat = 0;
    return true;
  } else {
    if (framesSinceLastBeat <= beatHoldFrames){
      framesSinceLastBeat++;
    }
    else{
      beatCutoff *= beatDecayRate;
      beatCutoff = max(beatCutoff, beatThreshold);
    }
  }
  return false;
}

int COLOR_WHEEL_SLICE_SIZE = 3;
int COLOR_WHEEL_ROTATION_RATE = 2;
int colorWheelRotationAngle = 0;
int colorWheelSlicesPerThird = 120 / COLOR_WHEEL_SLICE_SIZE;
int colorWheelColorChangePerSlice = 256 / colorWheelSlicesPerThird;
int[][] colorWheelRGBStages = {{-1, +1, 0}, {0, -1, +1}, {+1, 0, -1}};

void colorWheel(boolean shouldSetup, boolean onBeat) {
  if (shouldSetup) {
    colorWheelRotationAngle = 0;
    background(0);
    colorMode(RGB, 255);
  }

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


int SOUND_BAR_HISTORY = 180; // ~3s
float[] soundBarPrevLevels = new float[SOUND_BAR_HISTORY];
int soundBarCyclicIndex = 0;
float soundBarNormalizedMax = 1;

void soundBar(boolean shouldSetup, boolean onBeat) {
  if (shouldSetup) {
    colorMode(HSB, 255);
    for (int i = 0; i < SOUND_BAR_HISTORY; i++) {
      soundBarPrevLevels[i] = 0.0;
    }
  }

  float level = amplitude.analyze();

  background(0, 0);

  int spacing = 3;
  int w = width / (SOUND_BAR_HISTORY * spacing);
  int minHeight = 5;

  soundBarPrevLevels[soundBarCyclicIndex++ % SOUND_BAR_HISTORY] = level;

  float recentMax = 0;
  for (float prevLevel : soundBarPrevLevels) {
    recentMax = max(recentMax, prevLevel);
  }

  float h = map(level, 0, soundBarNormalizedMax, minHeight, height);

  float hueValue = map(h, minHeight, height, 0, 255);

  fill(hueValue, 255, 255, 255);

  rect(0, height/2 - h / 2, width, h);
  rect(width/2 - h / 2, 0, h, width);

  if (recentMax > 0.01 && recentMax < soundBarNormalizedMax / 2) {
    soundBarNormalizedMax *= 0.95;
    print("Dropping normalizedMax to", soundBarNormalizedMax, "\n");
  } else if (recentMax > soundBarNormalizedMax * 1.4) {
    soundBarNormalizedMax *= 1.05;
    print("Upping normalizedMax to", soundBarNormalizedMax, "\n");
  }
}
