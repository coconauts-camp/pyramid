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
    PImage images[];
    String imageNameTemplate = "butterfly/%d.png";

    public RippleEffect(float width, float height) {
        this.cols = (int) width;
        this.rows = (int) height;

        current = new float[cols][rows];
        previous = new float[cols][rows];
    }
    void setup(PApplet parent) {
        images = new PImage[IMAGE_COUNT];
        for (int cnt = 1; cnt <= IMAGE_COUNT; cnt++) {
            images[cnt - 1] = parent.loadImage(String.format(imageNameTemplate, cnt));
        }
        topLevel = parent.createGraphics(cols, rows, g.getClass().getName());

        cols = images[0].width;
        rows = images[0].height;

        current = new float[cols][rows];
        previous = new float[cols][rows];
    }

    void draw(PGraphics g) {
        final int frame = (int) ((millis() / (1000.0 / fps)) % IMAGE_COUNT);
        g.image(images[frame], 0, 0, cols, rows);
        if (frame != previousFrame) {
            previousFrame = frame;
            topLevel.beginDraw();
            drawRipple(topLevel);
            topLevel.endDraw();
        }
        g.image(topLevel, 0, 0);
    }

    void drawRipple(PGraphics g) {
        g.background(0, 10);
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

                g.pixels[index] = color(current[i][j] * 300, 60);
                // g.pixels[index] = color(255, current[i][j] * 180);
            }
        }
        g.updatePixels();
        swapBuffers();
    }


    void setRippleCenter() {
        if (refreshRate % 40 == 0) {
            refreshRate = 0;
            current[(int) random(lowerBound(cols), upperBound(cols))][(int) random(lowerBound(rows), upperBound(rows))] = 255;
        }
        ++refreshRate;
    }

    int upperBound(int value) {
        return (value / 2) + (value / 6);
    }

    int lowerBound(int value) {
        return value / 4;
    }

    void swapBuffers() {
        float[][] temp = previous;
        previous = current;
        current = temp;
    }
}
