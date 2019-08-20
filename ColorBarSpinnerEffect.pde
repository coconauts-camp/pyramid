import java.util.List;

class ColorBarSpinnerEffect extends PyramidEffect {
    SpinningColorBar[] bars;

    public ColorBarSpinnerEffect() {
        bars = new SpinningColorBar[] {
          new SpinningColorBar(0.1),
          new SpinningColorBar(0.3),
          new SpinningColorBar(0.6),
          new SpinningColorBar(1),
          new SpinningColorBar(-1),
          new SpinningColorBar(-0.6),
          new SpinningColorBar(-0.3),
          new SpinningColorBar(-0.1),
        };
    }

    void start(PGraphics g) {
        g.colorMode(HSB);
    }

    void draw(PGraphics g) {
        g.background(0);
        for (SpinningColorBar bar : bars) {
            bar.draw(g);
        }
    }

    class SpinningColorBar {
        float seed;
        PGraphics graphics;

        public SpinningColorBar(float seed) {
          this.seed = seed;
        }

        void draw(PGraphics g) {
            int frameCount = (int) (millis() / (1000/60));
            g.fill(
                (float) (frameCount * Math.pow(10, seed) * 3 % 255),
                255,
                255,
                128
            );
            g.pushMatrix();
            g.translate(width/2, height/2);


            float rad = radians((frameCount * seed) % 360);
            g.rotate(rad);

            g.rect(0, -4, 150, 8);
            g.popMatrix();
        }
    }
}
