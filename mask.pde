static class Masks {
  static PImage[] levelMasks; // ABC
  static PImage[] sideMasks; // NESW
  static PImage Mo;
  static PImage MoEyeLeft;
  static PImage MoEyeRight;

  abstract static class MaskMaker {
    abstract void draw(PGraphics g);
    PImage createMask(PApplet parent) {
      PGraphics g = parent.createGraphics(parent.width, parent.height);
      g.beginDraw();
      g.noStroke();
      g.blendMode(REPLACE);
      g.rectMode(CENTER);
      g.background(0,0,0,0);
      g.fill(255);
      draw(g);
      g.endDraw();
      return g;
    }
  }

  static PImage createLevelMask(PApplet parent, final float size) {
    final float centerX = parent.width/2;
    final float centerY = parent.height/2;
    return (new MaskMaker() { public void draw(PGraphics g) {
      g.rect(centerX, centerY, size + 10, size + 10);
      g.fill(0,0,0,0);
      g.rect(centerX, centerY, size - 10, size - 10);
    }}).createMask(parent);
  }

  static PImage createSideMask(PApplet parent, final float x, final float y) {
    final float halfX = parent.width/2;
    final float halfY = parent.height/2;
    return (new MaskMaker() { public void draw(PGraphics g) {
      print("triangle",
        halfX, halfY,
        halfX + x * halfX, halfY + y * halfY,
        halfX + y * halfX, halfY - x * halfY,
        "\n"
      );
      g.triangle(
        halfX, halfY,
        halfX + x * halfX, halfY + y * halfY,
        halfX + y * halfX, halfY - x * halfY
      );
      g.fill(0,0,0,0);
      int levelASize = Pyramid.levelLedsWidth[0];
      g.rect(halfX, halfY, levelASize - 12, levelASize - 12);
    }}).createMask(parent);
  }

  static void setup(PApplet parent) {
    if (levelMasks != null) return;
    levelMasks = new PImage[Pyramid.levelLedsWidth.length];
    for (int i = 0; i < levelMasks.length; i++) {
      int width = Pyramid.levelLedsWidth[i];
      levelMasks[i] = createLevelMask(parent, width);
    }
    sideMasks = new PImage[Pyramid.ledStartSigns.length];
    for (int i = 0; i < sideMasks.length; i++) {
      int[] ss = Pyramid.ledStartSigns[i];
      sideMasks[i] = createSideMask(parent, ss[0], ss[1]);
    }
  }
}

void setupMasks(PApplet parent) {
  Masks.setup(parent);
}

class MaskEffectsEffect extends PyramidEffect {

  PyramidEffect[] effects;
  PImage[] masks;
  PGraphics[] gs;

  MaskEffectsEffect(PyramidEffect[] effects, PImage[] masks) {
    if (effects.length != masks.length) {
      throw new RuntimeException(String.format("Got %d effects and %d masks, they need to match.", effects.length, masks.length));
    }
    this.effects = effects;
    this.masks = masks;
  }

  void setup(PApplet parent) {
    gs = new PGraphics[masks.length];
    for (int i = 0; i < masks.length; i++) {
      gs[i] = parent.createGraphics(parent.width, parent.height);
    }
    for (PyramidEffect e: effects) {
      if (e == null) continue;
      e.setup(parent);
    }
  }

  void reset(PGraphics g) {
    for (int i = 0; i < masks.length; i++) {
      PyramidEffect e = effects[i];
      if (e == null) continue;
      e.reset(gs[i]);
    }
  }

  void drawMaskedEffect(PGraphics g, PyramidEffect e, PImage mask) {
    if (e == null) return;
    g.noStroke();
    g.beginDraw();
    e.draw(g);
    g.mask(mask);
    g.endDraw();
  }

  void draw(PGraphics g) {
    for (int i=0; i < gs.length; i++) {
      drawMaskedEffect(gs[i], effects[i], masks[i]);
    }
    for (int i=0; i < gs.length; i++) {
      g.image(gs[i], 0, 0);
    }
  }
}

class MaskLevelEffect extends MaskEffectsEffect {
  MaskLevelEffect(PyramidEffect[] effects) {
    super(effects, Masks.levelMasks);
  }
}

class MaskSideEffect extends MaskEffectsEffect {
  MaskSideEffect(PyramidEffect[] effects) {
    super(effects, Masks.sideMasks);
  }
}
