BeatDetector beatDetector;

PyramidEffect[] effects;

void setupEffects(PApplet parent) {
  effects = new PyramidEffect[] {
    // new HSB1ColorwheelEffect(),
    // new HSB2ColorwheelEffect(),
    // new RGBColorwheelEffect(),
    // new HSB1ColorfadeEffect(),
    // new HSB2ColorfadeEffect(),
    // new SoundBarEffect(),
    // new MaskLevelEffect(new PyramidEffect[] {
    //   new HSB2ColorwheelEffect(),
    //   new HSB2ColorfadeEffect(),
    //   new SoundBarEffect(),
    // }),
    new MaskSideEffect(new PyramidEffect[] {
      new MaskLevelEffect(new PyramidEffect[] {
        new HSB2ColorwheelEffect(),
        new HSB2ColorfadeEffect(),
        new SoundBarEffect(),
      }),
      new MaskLevelEffect(new PyramidEffect[] {
        new HSB2ColorfadeEffect(),
        new SoundBarEffect(),
        new HSB2ColorwheelEffect(),
      }),
      new MaskLevelEffect(new PyramidEffect[] {
        new SoundBarEffect(),
        new HSB2ColorwheelEffect(),
        new HSB2ColorfadeEffect(),
      }),
      new MaskLevelEffect(new PyramidEffect[] {
        new HSB2ColorfadeEffect(-60),
        new HSB2ColorwheelEffect(-60),
        new HSB2ColorfadeEffect(-60),
      }),
    }),
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
    currentEffect = effects[effectIndex];
    currentEffect.reset(g);
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
