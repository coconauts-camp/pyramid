import java.util.Map;
// import javafx.util.Pair;

BeatDetector beatDetector;

PyramidEffect[] effects;
KeyHandler[] keyHandlers;

class KeyHandler {
  void keyPressed(char key) {}
}

final char KEY_UP = 'w';
final char KEY_LEFT = 'a';
final char KEY_DOWN = 's';
final char KEY_RIGHT = 'd';

void setupEffects(PApplet parent) {
  final CycleEffectsEffect mainCycle = new CycleEffectsEffect(new PyramidEffect[] {
    new HSBColorwheelEffect(),
    new ZoomImageEffect(loadImage("mandelbrot_bioluminescence.png")),
    new HSBColorfadeEffect(),
    new ZoomImageEffect(loadImage("mandelbrot_saturday_confetti.png")),
    new ButterflyRippleEffect(width, height),
    new ZoomImageEffect(loadImage("mandelbrot_coral_swim.png")),
    new MovieEffect("Plasma_globe_360p.webm"),
  }, 30000);
  final CycleEffectsEffect testCycle = new CycleEffectsEffect(new PyramidEffect[] {
    new TestSpinEffect(),
    new TestFadeEffect(),
  }, -1);
  final CycleEffectsEffect trippyCycle = new CycleEffectsEffect(new PyramidEffect[] {
    new MovieEffect("trippy.mp4"),
  }, -1);
  final CycleEffectsEffect rejectsCycle = new CycleEffectsEffect(new PyramidEffect[] {
    new ColorBarSpinnerEffect(),
    new MovieEffect("Fractal-zoom-1-15-rupture.ogv", 17000),
    new RippleEffect(width, height),
    new ZoomImageEffect(loadImage("mandelbrot_indian_wedding.png")),
    new RGBColorwheelEffect(),
    new ZoomImageEffect(loadImage("mandelbrot_inner_current.png")),
  }, 30000);

  effects = new PyramidEffect[] {
    mainCycle,
    testCycle,
    new SoundBarEffect(),
    trippyCycle,
    rejectsCycle,
  };

  keyHandlers = new KeyHandler[] {
    new KeyHandler() { public void keyPressed(char key) {
        switch (key) {
        case KEY_RIGHT: mainCycle.changeEffectBy(1); break;
        case KEY_LEFT: mainCycle.changeEffectBy(-1); break;
        }
    }},
    new KeyHandler() { public void keyPressed(char key) {
        switch (key) {
        case KEY_RIGHT: testCycle.changeEffectBy(1); break;
        case KEY_LEFT: testCycle.changeEffectBy(-1); break;
        }
    }},
    new KeyHandler(),
    new KeyHandler() { public void keyPressed(char key) {
        switch (key) {
        case KEY_RIGHT: trippyCycle.changeEffectBy(1); break;
        case KEY_LEFT: trippyCycle.changeEffectBy(-1); break;
        }
    }},
    new KeyHandler() { public void keyPressed(char key) {
        switch (key) {
        case KEY_RIGHT: rejectsCycle.changeEffectBy(1); break;
        case KEY_LEFT: rejectsCycle.changeEffectBy(-1); break;
        }
    }},
  };


  for (PyramidEffect effect: effects) {
    effect.setup(this);
  }
  changeEffectBy(1);
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

int effectIndex = -1;
PyramidEffect currentEffect;

void changeEffectBy(int change) {
  effectIndex = (effectIndex + change) % effects.length;
  if (effectIndex < 0) effectIndex += effects.length;
  if (currentEffect != null) currentEffect.stop(g);
  currentEffect = effects[effectIndex];
  currentEffect.start(g);
}

void draw() {
  if (effects.length == 0) throw new RuntimeException("No effects found");
  if (effects.length != keyHandlers.length) {
    throw new RuntimeException("Need same number of keyHandlers as effects");
  }

  pushMatrix();
  currentEffect.draw(g);
  popMatrix();

  // doBeat(g);
}

void keyPressed() {
  switch (key) {
    case KEY_DOWN:
      changeEffectBy(1);
    break;
    case KEY_UP:
      changeEffectBy(-1);
    break;
    default:
      if (effectIndex >= 0) keyHandlers[effectIndex].keyPressed(key);
    break;
  }
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

// int BUTTON_X = 1;
// int BUTTON_Y = 2;
// int BUTTON_A = 3;
// int BUTTON_B = 4;
// int BUTTON_START = 5;
// int BUTTON_SELECT = 6;
// int BUTTON_TOGGLE_LEFT = 7;
// int BUTTON_TOGGLE_RIGHT = 8;
// int BUTTON_LEFT = 9;
// int BUTTON_RIGHT = 10;
// int BUTTON_UP = 11;
// int BUTTON_DOWN = 12;

// Map<Character, Pair<Integer, Integer>> controllerMap = new HashMap<Character, Pair<Integer, Integer>>();

// controllerMap.put('x', new Pair(BUTTON_X, 0));
// controllerMap.put('y', new Pair(BUTTON_Y, 0));
// controllerMap.put('a', new Pair(BUTTON_A, 0));
// controllerMap.put('b', new Pair(BUTTON_B, 0));
// controllerMap.put(',', new Pair(BUTTON_SELECT, 0));
// controllerMap.put('.', new Pair(BUTTON_START, 0));
// controllerMap.put('[', new Pair(BUTTON_TOGGLE_LEFT, 0));
// controllerMap.put(']', new Pair(BUTTON_TOGGLE_RIGHT, 0));
// controllerMap.put('1', new Pair(BUTTON_LEFT, 0));
// controllerMap.put('2', new Pair(BUTTON_RIGHT, 0));
// controllerMap.put('3', new Pair(BUTTON_UP, 0));
// controllerMap.put('4', new Pair(BUTTON_DOWN, 0));

// controllerMap.put('v', new Pair(BUTTON_X, 1));
// controllerMap.put('w', new Pair(BUTTON_Y, 1));
// controllerMap.put('c', new Pair(BUTTON_A, 1));
// controllerMap.put('d', new Pair(BUTTON_B, 1));
// controllerMap.put(';', new Pair(BUTTON_SELECT, 1));
// controllerMap.put('\'', new Pair(BUTTON_START, 1));
// controllerMap.put('-', new Pair(BUTTON_TOGGLE_LEFT, 1));
// controllerMap.put('=', new Pair(BUTTON_TOGGLE_RIGHT, 1));
// controllerMap.put('5', new Pair(BUTTON_LEFT, 1));
// controllerMap.put('6', new Pair(BUTTON_RIGHT, 1));
// controllerMap.put('7', new Pair(BUTTON_UP, 1));
// controllerMap.put('8', new Pair(BUTTON_DOWN, 1));

// void keyPressed() {
//   if (controllerMap.containsKey(new Character(key))) {
//     Pair<Integer, Integer> mapping = controllerMap.get(new Character(key));
//     println("Controller %i", mapping.getValue());
//   }
// }
