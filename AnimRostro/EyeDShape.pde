/*
  EyeDShape.pde - Variation of DynShape (eyes)
  0.8 31/03/16 geomerative lib: RPoint & RPolygon; RPolygon.intersection(RPolygon)  
*/

import geomerative.*; //.8 http://www.ricardmarxer.com/geomerative/

public class EyeDShape extends DynShape { //.6

  float eyeX;
  color col;
  int radius;

  public EyeDShape(int x, int y, int w, int h, int ang) {
    super(x,y,w,h,ang);
    eyeX = V4X;
    filler = color(255,255,255);
    col = color(100,200,250);
    radius = h;
  }

  public void setColor(color c) { col = c; } //.6  
  
  public void update(int mx, int y, int times) { //.6 move eye
    eyeX = map(mx,0,width,V1D1,V1D2);
    tall = map(y,0,height,0,BH); //.7
    init(); //.6(BUG) Regenerate shape
    vert[0].y = V4Y - tall; //.1.8 
    vert[2].y = V4Y + tall; //.3.8
    subdivide( vert, times ); //.6
  }

  public void draw() {
     pushMatrix(); //.5 GIRO BOCA
      translate(V4X,V4Y);
      rotate(BANG); // angulo de giro
      translate(-V4X,-V4Y);
      fill(filler);
      shape.draw(); //.8
      RPolygon circle = RShape.createCircle(eyeX, V4Y, radius).toPolygon(); //.8
      circle = circle.intersection(shape); //.8
      fill(col);
      circle.draw(); //.8
      float r = radius / 3.0;
      if (tall < r) { //.7
        r = tall;
      }
      fill(0);
      ellipse(eyeX,V4Y,r,r);
    popMatrix();
  } 
} // class
