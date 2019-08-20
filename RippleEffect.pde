class RippleEffect extends PyramidEffect {
    int cols;
    int rows;
    float[][] current;
    float[][] previous;

    int fps = 30;
    int previousFrame = -1;
    float dampening = 0.98;
    int refreshRate;
    int IMAGE_COUNT = 60;

    PGraphics topLevel;

    public RippleEffect(float width, float height) {
        this.cols = (int) width;
        this.rows = (int) height;

        current = new float[cols][rows];
        previous = new float[cols][rows];
    }

    void setup(PApplet parent) {
        topLevel = parent.createGraphics(cols, rows, g.getClass().getName());
        current = new float[cols][rows];
        previous = new float[cols][rows];
    }

    void start(PGraphics g) {
      g.imageMode(CORNER);
      g.colorMode(RGB);
    }

    void draw(PGraphics g) {
        final int frame = (int) ((millis() / (1000.0 / fps)) % IMAGE_COUNT);
        g.background(0);
        if (frame != previousFrame) {
            previousFrame = frame;
            topLevel.beginDraw();
            drawRipple(topLevel);
            topLevel.endDraw();
        }
        g.image(topLevel, 0, 0);
    }

    void drawRipple(PGraphics g) {
        g.loadPixels();
        setRippleCenter();

        for (int i = 1; i < cols - 1; i++) {
            for (int j = 1; j < rows - 1; j++) {
                int index = i + j * cols;

                current[i][j] = (
                    previous[i - 1][j] +
                    previous[i + 1][j] +
                    previous[i][j - 1] +
                    previous[i][j + 1]) / 2 - current[i][j];

                current[i][j] = current[i][j] * dampening;

                g.pixels[index] = color(0, 0, 255, current[i][j] + 128);
            }
        }
        g.updatePixels();
        swapBuffers();
    }


    void setRippleCenter() {
        refreshRate = 0;
        current[(int) random(lowerBound(cols), upperBound(cols))][(int) random(lowerBound(rows), upperBound(rows))] = 256;
        ++refreshRate;
    }

    int upperBound(int value) {
        return 5 * value / 6;
    }

    int lowerBound(int value) {
        return value / 6;
    }

    void swapBuffers() {
        float[][] temp = previous;
        previous = current;
        current = temp;
    }
}
