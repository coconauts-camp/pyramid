BeatDetector beatDetector;

PyramidEffect[] effects = {
  new HSB1ColorwheelEffect(),
  new HSB2ColorwheelEffect(),
  new RGBColorwheelEffect(),
  new HSB1ColorfadeEffect(),
  new HSB2ColorfadeEffect(),
  new SoundBarEffect(),
};

void setup() {
  size(300, 300);
  noStroke();

  setupLedMapping(this);

  // For soundBar
  setupAudio(this);
  beatDetector = new BeatDetector();

  for (PyramidEffect effect: effects) {
    effect.setup(this);
  }
  // SOME OTHER STUFF
}

int MILLIS_PER_EFFECT = 15 * 1000;
int effectIndex = -1;
PyramidEffect currentEffect;
int millisOfLastEffectChange = -1 - MILLIS_PER_EFFECT;

void draw() {
  if (millisOfLastEffectChange + MILLIS_PER_EFFECT < millis()) {
    millisOfLastEffectChange = millis();
    effectIndex = (effectIndex + 1) % effects.length;
    currentEffect = effects[effectIndex];
    currentEffect.reset(this);
  }

  pushMatrix();

  boolean onBeat = beatDetector.detect();
  currentEffect.draw(onBeat);

  popMatrix();

  if (onBeat) {
    print("Beat\n");
    fill(255);
  } else {
    fill(0);
  }
  rect(10, 10, 20, 20);
}
