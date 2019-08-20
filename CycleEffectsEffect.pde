class CycleEffectsEffect extends PyramidEffect {
  PyramidEffect[] effects;
  int maxDuration;
  int effectIndex = -1;
  PyramidEffect currentEffect;
  int currentDuration = 0;
  int millisOfLastEffectChange = -1;


  CycleEffectsEffect(PyramidEffect[] effects, int maxDuration) {
    if (effects.length == 0) throw new RuntimeException("No effects found");
    this.effects = effects;
    this.maxDuration = maxDuration;
  }

  void setup(PApplet parent) {
    for (PyramidEffect effect: effects) {
      effect.setup(parent);
    }
    changeEffectBy(1);
  }

  void changeEffectBy(int change) {
    millisOfLastEffectChange = millis();
    effectIndex = (effectIndex + change) % effects.length;
    if (effectIndex < 0) effectIndex += effects.length;
    if (currentEffect != null) currentEffect.stop(g);
    currentEffect = effects[effectIndex];
    currentEffect.start(g);
    currentDuration = currentEffect.duration();
    if (maxDuration >= 0 && currentDuration > maxDuration) {
      currentDuration = maxDuration;
    }
    if (currentDuration < 0) currentDuration = maxDuration;
  }

  void draw(PGraphics g) {
    if (currentDuration >= 0 && millisOfLastEffectChange + currentDuration < millis()) {

      print("duration ", currentDuration, " millisOfLastEffectChange ", millisOfLastEffectChange, "\n");
      changeEffectBy(1);
    }

    g.pushMatrix();
    currentEffect.draw(g);
    g.popMatrix();
  }
}
