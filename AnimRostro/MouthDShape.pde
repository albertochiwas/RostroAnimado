/*
  MouthDShape.pde - Variation of DynShape (mouth)
  0.9 13/04/16 Agregar dientes y lengua a la boca  
*/

import geomerative.*; //.8 http://www.ricardmarxer.com/geomerative/

public class MouthDShape extends DynShape { //.9

    RPolygon   rombo; //.9   

  public MouthDShape(int x, int y, int w, int h, int ang) {
    super(x,y,w,h,ang);
    rombo = new RPolygon(vert); //.9
  }

  public void update(int mx, int y, int times) { //.9
    tall = map(y,0,height,0,BH); //.7
    init(); //.6(BUG) Regenerate shape
    vert[0].y = V4Y - tall; //.1.8 Apertura de la boca
    vert[2].y = V4Y + tall; //.3.8
    rombo = new RPolygon(vert); //.9
    subdivide( vert, times ); //.6 Rombo a poligono
  }

  public void draw() {
     pushMatrix(); //.5 GIRO BOCA
      translate(V4X,V4Y);
      rotate(BANG); // angulo de giro
      translate(-V4X,-V4Y);
      noFill(); //.9
      rombo.draw(); //.9
      fill(filler);
      shape.draw(); //.8
//      RPolygon circle = RShape.createCircle(eyeX, V4Y, radius).toPolygon(); //.8
//      circle = circle.intersection(shape); //.8
    popMatrix();
  } 
} // class
