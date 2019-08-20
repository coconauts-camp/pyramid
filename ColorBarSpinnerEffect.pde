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
        g.background(0);
    }

    void draw(PGraphics g) {
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
            if (frameCount % 8 == 0) {
                g.fill(frameCount * 3 % 255, frameCount * 5 % 255,
                frameCount * 7 % 255);
                g.pushMatrix();
                g.translate(width/2, height/2);


                float rad = radians((frameCount * seed) % 360);
                g.rotate(rad);

                g.rect(0, 0, 150, 8);
                g.popMatrix();
            }
        }
    }
}
