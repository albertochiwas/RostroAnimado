/*
  Boca2.pde
  
  Pixar's inspired mouth smooth curve from a basic polygon (array to shape vertex)
  By Alberto Pacheco (alberto@acm.org) @beto0303
  01/Dic/2014 - 30/03/2016
  
  0.5 03/12/14 Parametric values V4X/V4Y/BW/BH; Giro-boca
  0.6 30/03/16 DynShape class
  
  Inspiration: http://ed.ted.com/lessons/pixar-the-math-behind-the-movies-tony-derose
  
  Directions: move mouse cursor around drawing and box deformation produces a smooth ellipse inside
  
  Pdte: 
  - SVG Image pivots
  - Parametrizar secciones y tamaño de la boca
*/

import geomerative.*;

int clicks = 1;
int lowest = 100; //.6

PImage   alien; //.5 Imagen
DynShape boca;  //.6 Mouth
EyeDShape eye1, eye2, eye3;  //.6 Eyes


void setup() {
  size(400,400,P2D);
//  smooth();
//  frameRate(30);
  RG.init(this); //.8
  alien = loadImage("greenAlien.jpg"); //.5  
  boca  = new DynShape( 100, 155, 90, 30,   3); //.6
  eye1  = new EyeDShape( 99, 128, 36, 18, -25); //.6
  eye2  = new EyeDShape(157, 104, 36, 18,   0); //.6
  eye3  = new EyeDShape(220, 100, 36, 18,  27); //.6
}


void draw() {
  image(alien,0,0); //.5 //<>//
  if ( mouseX!=pmouseX || mouseY!=pmouseY) {
    boca.update(mouseX, mouseY, clicks);
    eye1.update(mouseX, mouseY, clicks);
    eye2.update(mouseX, mouseY, clicks);
    eye3.update(mouseX, mouseY, clicks);
  }
  text(clicks,320,40);
  int fr = round(frameRate);
  text(fr,350,40); //.5 frames per second
  if (frameCount>60 && fr<lowest) { //.6 report lower framerate
    lowest = fr;
  }
  text(lowest,350,60);
  boca.draw(); //.6
  eye1.draw(); //.6
  eye2.draw(); //.6
  eye3.draw(); //.6
}


void mouseClicked() { //.5
  if (clicks < 4) {
    ++clicks;
    lowest = round(frameRate);
  }
}
