/*
  MouthDShape.pde - Variation of DynShape (mouth)
  0.9 13/04/16 Agregar dientes y lengua a la boca  
*/

import geomerative.*; //.8 http://www.ricardmarxer.com/geomerative/

public class MouthDShape extends DynShape { //.9

    RPolygon dientes;
    int tam;
    int white = color(255);    

  public MouthDShape(int x, int y, int w, int h, int ang) {
    super(x,y,w,h,ang);
    dientes = new RPolygon(vert);
    tam = h;
  }

  public void update(int mx, int y, int times) { //.9
    tall = map(y,0,height,0,BH); //.7
    init(); //.6(BUG) Regenerate shape
    vert[0].y = V4Y - tall; //.1.8 Apertura de la boca
    vert[2].y = V4Y + tall; //.3.8
    dientes = new RPolygon(new RPoint[] {
        vert[3], new RPoint(vert[0].x, vert[0].y-tam/8),
        vert[1], new RPoint(vert[0].x, vert[0].y+tam/2) });
    subdivide( vert, times ); //.6 Rombo a poligono
  }

  public void draw() {
     pushMatrix(); //.5 GIRO BOCA
      translate(V4X,V4Y);
      rotate(BANG); // angulo de giro
      translate(-V4X,-V4Y);
      fill(filler);
      shape.draw(); //.8
      fill(white); //.9 dientes
//      dientes.draw(); //.9
//      RPolygon circle = RShape.createCircle(eyeX, V4Y, radius).toPolygon(); //.8
//      circle = circle.intersection(shape); //.8
      RPolygon dentadura = dientes.intersection(shape); //.9
      fill(white); //.9 dientes
      dentadura.draw();
    popMatrix();
  } 
} // class
