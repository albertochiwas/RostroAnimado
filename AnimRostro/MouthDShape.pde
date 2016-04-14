/*
  MouthDShape.pde - Variation of DynShape (mouth)
  0.9 13/04/16 Agregar dientes y lengua a la boca  
*/

import geomerative.*; //.8 http://www.ricardmarxer.com/geomerative/

public class MouthDShape extends DynShape { //.9

    RPolygon dientes;
    int white = color(255);    

  public MouthDShape(int x, int y, int w, int h, int ang) {
    super(x,y,w,h,ang);
    dientes = null; //.9
  }

  public void update(int mx, int y, int times) { //.9
    tall = map(y,0,height,0,BH); //.7
    init(); //.6
    vert[0].y = V4Y - tall; //.1.8 Apertura de la boca
    vert[2].y = V4Y + tall; //.3.8
    float lower = map(tall,0,BH,0.0,1.25*BH/2.0); //.9 Calcula parte inferior de dentadura superior
    if (lower < 4.0) { //.9 Dentadura no es visible?
      lower = 0.0;
      dientes = null;
    } else { //.9 Dentadura visible
      //lower = round(lower+1.5);
      dientes = new RPolygon(new RPoint[] {
        new RPoint(vert[3].x+BW/12.0, vert[3].y-BH/8.0),
        new RPoint(vert[0].x, vert[0].y-BH/8.0),
        new RPoint(vert[1].x-BW/12.0, vert[1].y-BH/8.0),
        new RPoint(vert[0].x+BW/4.0, vert[0].y+lower),
        new RPoint(vert[0].x-BW/4.0, vert[0].y+lower) });
    }
    subdivide( vert, times ); //.6 Rombo a poligono
  }

  public void draw() {
     pushMatrix(); //.5 GIRO BOCA
      translate(V4X,V4Y);
      rotate(BANG); // angulo de giro
      translate(-V4X,-V4Y);
      fill(filler);
      shape.draw(); //.8 Dibuja labios boca
      if (dientes != null) { //.9 OPT: Dentadura visible?
        RPolygon dentadura = dientes.intersection(shape); //.9 Parte visible de dentadura
        fill(white);
        dentadura.draw(); //.9
      }
    popMatrix();
  } 
} // class
