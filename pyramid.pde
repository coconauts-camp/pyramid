import java.util.Map;
// import javafx.util.Pair;

BeatDetector beatDetector;

PyramidEffect[] effects;

void setupEffects(PApplet parent) {
  effects = new PyramidEffect[] {
    // new TestSpinEffect(),
     //new HSBColorwheelEffect(),
    // new RGBColorwheelEffect(),
    // new HSBColorfadeEffect(),
    // new SoundBarEffect(),
    //new ZoomImageEffect(loadImage("mandelbrot_bioluminescence.png")),
    //new ZoomImageEffect(loadImage("mandelbrot_indian_wedding.png")),
    //new ZoomImageEffect(loadImage("mandelbrot_saturday_confetti.png")),
    //new ZoomImageEffect(loadImage("mandelbrot_inner_current.png")),
    //new ZoomImageEffect(loadImage("mandelbrot_coral_swim.png")),
    //new RippleEffect(width, height),
    new ColorBarSpinnerEffect(),
    // new MovieEffect("Fractal-zoom-1-15-rupture.ogv", 17000),
    // new MovieEffect("Plasma_globe_360p.webm"),
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

int MAX_DURATION = 30 * 1000;
int effectIndex = -1;
PyramidEffect currentEffect;
int currentDuration = 0;
int millisOfLastEffectChange = -1;

void draw() {
  if (effects.length == 0) throw new RuntimeException("No effects found");
  if (millisOfLastEffectChange + currentDuration < millis()) {
    millisOfLastEffectChange = millis();
    effectIndex = (effectIndex + 1) % effects.length;
    if (currentEffect != null) currentEffect.stop(g);
    currentEffect = effects[effectIndex];
    currentEffect.start(g);
    currentDuration = currentEffect.duration();
    if (currentDuration > MAX_DURATION) currentDuration = MAX_DURATION;
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
