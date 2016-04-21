/*
  MouthDShape.pde - Variation of DynShape (mouth)
  0.9 13/04/16 Agregar dientes y lengua a la boca  
*/

import geomerative.*; //.8 http://www.ricardmarxer.com/geomerative/

public class MouthDShape extends DynShape { //.9

    RPolygon dientes; //.9
    RPolygon lengua;  //.9
    int blanco = color(255); //.9 color dientes
    int rojo = color(200,120,10); //.9 color lengua    

  public MouthDShape(int x, int y, int w, int h, int ang) {
    super(x,y,w,h,ang);
    dientes = null; //.9
    lengua = null; //.9
  }

  public void update(int mx, int y, int times) { //.9
    float x = map(mx,0,width,V1D1,V1D2); //.5
    tall = map(y,0,height,0,1.2*BH); //.7
    init(); //.6
    float x0 = vert[0].x; //.9 FIX 
    vert[0].x = x; //.1
    vert[0].y = V4Y - tall; //.1.8 Apertura de la boca
//    vert[2].x = x; //.94 BUG
    vert[2].y = V4Y + tall; //.3.8
    x = map(tall,0,BH,0,BW*0.5); // open mouth effect: higher y, lower x
    vert[1].x = V2X - x; //.2  
    vert[3].x = V4X + x; //.4
    dientes = null; //.9
    lengua = null;  //.9
    float offset = map(tall,0,BH,0.0,1.25*BH/2.0); //.9 Calcula parte visible
    if (offset < 4.5) { //.9 Dentadura no es visible?
      offset = 0.0; // eliminar dientes
    } else { //.9 Dentadura visible
      dientes = new RPolygon(new RPoint[] { //.9 Dentadura como polígono
        new RPoint(vert[3].x-BW/16.0, vert[3].y-BH/8.0), // extremo der
        new RPoint(vert[0].x, vert[0].y-BH/8.0),
        new RPoint(vert[1].x+BW/16.0, vert[1].y-BH/8.0), // extremo izq
        new RPoint(x0+BW/6.0, vert[0].y+offset),
        new RPoint(x0-BW/6.0, vert[0].y+offset) });
      if (offset > 8.0) { //.9 activar lengua?
        float cy = vert[2].y - map(offset,0.1,BH,-2.5*offset,1.8*offset);
        RPolygon p = RShape.createEllipse(vert[2].x-BW*0.15,cy,BW*0.45,BH).toPolygon();
        RPolygon q = RShape.createEllipse(vert[2].x+BW*0.15,cy,BW*0.45,BH).toPolygon();
        lengua = p.union(q);
      }
    }
    subdivide( vert, times ); //.6 Boca: rombo a poligono
  }

  public void draw() {
     pushMatrix(); //.5 GIRO BOCA
      translate(V4X,V4Y);
      rotate(BANG); // angulo de giro
      translate(-V4X,-V4Y);
      fill(filler);
      stroke(0);
      shape.draw(); //.8 Dibuja labios boca
      if (dientes!=null && swDiente) { //.9.95 OPT: Dentadura visible?
        RPolygon dentadura = dientes.intersection(shape); //.9 Parte visible de dentadura
        fill(blanco);
        noStroke();
        dentadura.draw(); //.9
//        dientes.draw(); // DEBUG
      }
      if (lengua!=null && swLengua) { //.9.95 lengua visible?
          RPolygon tongue = lengua.intersection(shape);
//          if (tongue != null) { //.9
            fill(rojo);
            noStroke();
            tongue.draw(); //.9
//              lengua.draw(); // DEBUG
//          }
      }
    popMatrix();
  } 
} // class
