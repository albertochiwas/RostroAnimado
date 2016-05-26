/*
  EyeDShape.pde - Variation of DynShape (eyes)
  0.8 31/03/16 geomerative lib: RPoint & RPolygon; RPolygon.intersection(RPolygon)  
*/

import geomerative.*; //.8 http://www.ricardmarxer.com/geomerative/

public class EyeDShape extends DynShape { //.6

  float eyeX;
  color col;
  int   radius;
  
  int   eyeLid; //.986 Altura del parpado antes de cerrar el ojo (coord. mouse)
  int   coordY; //.986 Almacena valor anterior del mouseY en cada update()
  float propY;  //.987 Fracción entre 0 y 1.0, grado abre/cierra parpado

  public EyeDShape(int x, int y, int w, int h, int ang) {
    super(x,y,w,h,ang);
    eyeX = V4X;
    filler = color(255,255,255);
    col = color(100,200,250);
    radius = h;
    eyeLid = 0; //.986
    propY = 1.0; //.987
  }

  public void setColor(color c) { col = c; } //.6  
  
  public void blink_close(boolean first) { //.986
     if (first) { //.987 valor inicial de cierre
         propY = 1.0;
         this.eyeLid = this.coordY; // save apertura parpado
     }
     this.update(round(this.eyeX),round(this.eyeLid*this.propY),3); // cerrar parpado
     this.propY -= 0.25;
     if (this.propY < 0.0) {
       this.propY = 0.0;
     }
  }
  
  public void blink_open(boolean first) { //.986
     if (first) { //.987 valor inicial de apertura
         propY = 0.0;
     }
     this.update(round(this.eyeX),round(this.eyeLid*this.propY),3); // cerrar parpado
     this.propY += 0.25;
     if (this.propY > 1.0) {
       this.propY = 1.0;
     }
     println(this.propY);
  }
  
  public void update(int mx, int y, int times) { //.6 move eye
    coordY = y; //.986
    eyeX = map(mx,0,width,V1D1,V1D2);
    tall = map(y,0,height,0,BH); //.7
    init(); //.6(BUG) Regenerate shape
    vert[0].y = V4Y - tall; //.1.8 
    vert[2].y = V4Y + tall; //.3.8
    subdivide( vert, times ); //.6
  }

  public void draw() {
     pushMatrix(); //.5 GIRO
      translate(V4X,V4Y);
      rotate(BANG); // angulo de giro
      translate(-V4X,-V4Y);
      fill(filler);
      stroke(0); //.9
      shape.draw(); //.8 Parpados
      RPolygon circle = RShape.createCircle(eyeX, V4Y, radius).toPolygon(); //.8
      circle = circle.intersection(shape); //.8
      fill(col);
      noStroke(); //.9
      circle.draw(); //.8 Iris & pupila
      float r = radius / 3.0;
      if (tall < r) { //.7
        r = tall;
      }
      fill(0);
      ellipse(eyeX,V4Y,r,r);
    popMatrix();
  } 
} // class
