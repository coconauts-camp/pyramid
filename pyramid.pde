BeatDetector beatDetector;

PyramidEffect[] effects;

void setupEffects(PApplet parent) {
  effects = new PyramidEffect[] {
    new HSBColorwheelEffect(),
    new RGBColorwheelEffect(),
    new HSBColorfadeEffect(),
    // new SoundBarEffect(),
    // new MaskLevelEffect(new PyramidEffect[] {
    //   new HSBColorwheelEffect(),
    //   new HSBColorfadeEffect(),
    //   new SoundBarEffect(),
    // }),
    // new MaskSideEffect(new PyramidEffect[] {
    //   new MaskLevelEffect(new PyramidEffect[] {
    //     new HSBColorwheelEffect(),
    //     new HSBColorfadeEffect(),
    //     new SoundBarEffect(),
    //   }),
    //   new MaskLevelEffect(new PyramidEffect[] {
    //     new HSBColorfadeEffect(),
    //     new SoundBarEffect(),
    //     new HSBColorwheelEffect(),
    //   }),
    //   new MaskLevelEffect(new PyramidEffect[] {
    //     new SoundBarEffect(),
    //     new HSBColorwheelEffect(),
    //     new HSBColorfadeEffect(),
    //   }),
    //   new MaskLevelEffect(new PyramidEffect[] {
    //     new HSBColorfadeEffect(-60),
    //     new HSBColorwheelEffect(-60),
    //     new HSBColorfadeEffect(-60),
    //   }),
    // }),
  };

  for (PyramidEffect effect: effects) {
    effect.setup(this);
  }
}

void setup() {
  size(300, 300);
  noStroke();

  setupLedMapping(this);
  setupMasks(this);

  // For soundBar
  setupAudio(this);
  beatDetector = new BeatDetector();

  // SOME OTHER STUFF

  setupEffects(this);
}

int MILLIS_PER_EFFECT = 15 * 1000;
int effectIndex = -1;
PyramidEffect currentEffect;
int millisOfLastEffectChange = -1 - MILLIS_PER_EFFECT;

void draw() {
  if (millisOfLastEffectChange + MILLIS_PER_EFFECT < millis()) {
    millisOfLastEffectChange = millis();
    effectIndex = (effectIndex + 1) % effects.length;
    if (currentEffect != null) currentEffect.stop(g);
    currentEffect = effects[effectIndex];
    currentEffect.start(g);
  }

  pushMatrix();
  currentEffect.draw(g);
  popMatrix();

  // doBeat(g);
}

void doBeat(PGraphics g) {
  if (beatDetector.detect()) {
    print("Beat\n");
    g.fill(255);
  } else {
    g.fill(0);
  }
  g.rect(10, 10, 20, 20);
}
