import processing.sound.*;

// For soundBar
Amplitude amplitude;
AudioIn in;
int bands = 1024;
float[] spectrum = new float[bands];

void setupAudio(PApplet parent) {
  amplitude = new Amplitude(parent);
  // Grab audio in from soundcard (microphone)
  in = new AudioIn(parent, 0);
  in.start();
  amplitude.input(in);
}

class BeatDetector {
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

  boolean detect() {
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
}

class SoundBarEffect extends PyramidEffect {
  int SOUND_BAR_HISTORY = 180; // ~3s
  float[] soundBarPrevLevels;
  int soundBarCyclicIndex = 0;
  float soundBarNormalizedMax = 1;

  void setup(PApplet parent) {
    soundBarPrevLevels = new float[SOUND_BAR_HISTORY];
  }

  void start(PGraphics g) {
    g.noStroke();
    g.colorMode(HSB, 255);
    for (int i = 0; i < soundBarPrevLevels.length; i++) {
      soundBarPrevLevels[i] = 0.0;
    }
  }

  void draw(PGraphics g) {
    float level = amplitude.analyze();

    g.background(0, 0);

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

    g.fill(hueValue, 255, 255, 255);

    g.rect(0, height/2 - h / 2, width, h);
    g.rect(width/2 - h / 2, 0, h, width);

    if (recentMax > 0.01 && recentMax < soundBarNormalizedMax / 2) {
      soundBarNormalizedMax *= 0.95;
      print("Dropping normalizedMax to", soundBarNormalizedMax, "\n");
    } else if (recentMax > soundBarNormalizedMax * 1.4) {
      soundBarNormalizedMax *= 1.05;
      print("Upping normalizedMax to", soundBarNormalizedMax, "\n");
    }
  }
}
