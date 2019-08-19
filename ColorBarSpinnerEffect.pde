import java.util.List;

class ColorBarSpinnerEffect extends PyramidEffect {
    List<SpinningColorBar> bars = new ArrayList();
   
    public ColorBarSpinnerEffect() {
        bars.add(new SpinningColorBar(0.1));
        bars.add(new SpinningColorBar(0.3));
        bars.add(new SpinningColorBar(0.6));
        bars.add(new SpinningColorBar(1));
        bars.add(new SpinningColorBar(-1));
        bars.add(new SpinningColorBar(-0.6));
        bars.add(new SpinningColorBar(-0.3));
        bars.add(new SpinningColorBar(-0.1));
    }
    
    void setup(PApplet parent) {
      
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
        
        void draw(PGraphics graphics){
        if (frameCount % 8 == 0) {
            graphics.fill(frameCount * 3 % 255, frameCount * 5 % 255,
            frameCount * 7 % 255);
            graphics.pushMatrix();
            g.translate(width/2, height/2);
            
                
            float rad = radians((frameCount * seed) % 360);
            graphics.rotate(rad);
            
            graphics.rect(0, 0, 150, 8);
            graphics.popMatrix();
        }
    }
  }
}
