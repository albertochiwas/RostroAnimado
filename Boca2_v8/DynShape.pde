/*
  DynShape.pde
  
  Pixar's inspired mouth smooth curve from a basic polygon (array to shape vertex)
  By Alberto Pacheco (alberto@acm.org) @beto0303
  01/Dic/2014 - 30/03/2016
  
  0.5 03/12/14 Parametric values V4X/V4Y/BW/BH; Giro-boca
  0.6 30/03/16 DynShape class; Parametric values as class attributes
  0.7 31/03/16 toxiclibs: Vec2D, Polygon intersection
  0.8 31/03/16 geomerative lib: RPoint & RPolygon; RPolygon.intersection(RPolygon)
  
  Inspiration: 
    http://ed.ted.com/lessons/pixar-the-math-behind-the-movies-tony-derose
    https://forum.processing.org/one/topic/clipping-circle-with-polygon.html
    http://printingcode.runemadsen.com/geomerative/
  
 ROMBO: 
         V1
        /  \
      V4    V2
        \  /
         V3
*/

import geomerative.*; //.8 http://www.ricardmarxer.com/geomerative/documentation/

public class DynShape { //.6

  float    V4X, V4Y; // position
  float    BW, BH;   // size
  float    BANG;     // orientation
  float    V1X;      // top-x value
  float    V1Y;      // top-y value 
  float    V2X;
  float    V3Y;
  float    V1D1, V1D2; // Deformation range (mouseX)
  float    tall;      //.7 height

  RPoint   V1, V2, V3, V4; //.5.8
  RPoint   vert[];    //.5.8 Shape Vertices
  RPolygon shape;     //.5.8
  
  color    filler;    //.6
  color    border;    //.6
  
  public DynShape(int x, int y, int w, int h, int ang) {
    V4X  = x; // position //<>//
    V4Y  = y;
    BW   = w; // size
    BH   = h;
    BANG = radians(ang); //.5
    filler = color(0);   //.6
    border = color(0);   //.6
    init();
  }
  
  protected void init() {  //.6
    V1X = V4X + BW;        //.5
    V1Y = V4Y - BH;        //.5 V1 top-y value 
    V2X = V4X + 2*BW;      //.5
    V3Y = V4Y + BH;        //.5
    V1 = new RPoint(V1X, V1Y); //.5
    V2 = new RPoint(V2X, V4Y); //.5
    V3 = new RPoint(V1X, V3Y); //.5
    V4 = new RPoint(V4X, V4Y); //.5
    //.5 V1 deformation range (mouseX)
    V1D1 = V1X - BW/4;
    V1D2 = V1X + BW/4;
    reshape(new RPoint[] { V1, V2, V3, V4 });
  }

  public void setColor(color c) { filler = c; } //.6
  
  public void setBorder(color c) { border = c; } //.6
   
  public void update(int mx, int y, int times) { //.6 move (x,y) rigging values
    float x = map(mx,0,width,V1D1,V1D2); //<>//
    tall = map(y,0,height,0,1.2*BH); //.7
    init(); //.6(BUG) Regenerate shape
    vert[0].x = x; // V1
    vert[0].y = V4Y - tall;  
    x = map(tall,0,BH,0,BW/4); // open mouth effect: higher y, lower x
    vert[1].x = V2X - x; // V2  
    vert[2].y = V4Y + tall; // V3
    vert[3].x = V4X + x; // V4
    subdivide(vert, times); //.6
  }

  protected void reshape( RPoint v[] ) {
    vert = v; //.8
    shape = new RPolygon(vert); //.8
  }
  
  protected void subdivide( RPoint v1[], int loop ) { // El reto es pasar version recursiva a iterativa
    if ( loop<1 || loop>4 ) { //<>//
      reshape(v1);
      return;
    }
    --loop;
    RPoint [] v2 = new RPoint[v1.length*2];
    int n = v1.length;
    for ( int i=0, j=0; i<n; i++ ) {
       int k = (i+1) % n;
       PVector a = new PVector(v1[i].x,v1[i].y); //.8
       PVector b = new PVector(v1[k].x,v1[k].y); //.8
       PVector c = PVector.lerp(a, b, 0.25);
       PVector d = PVector.lerp(a, b, 0.75);
       v2[ j++ ] = new RPoint(c.x,c.y); //.8
       v2[ j++ ] = new RPoint(d.x,d.y); //.8
    }
    subdivide(v2, loop);
  }

  public void draw() {
     pushMatrix(); //.5 GIRO BOCA
      translate(V4X,V4Y);
      rotate(BANG); // angulo de giro
      translate(-V4X,-V4Y);
    shape.draw(); //.8
    popMatrix();
  }
} // class
