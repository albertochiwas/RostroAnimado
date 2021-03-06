/*
  AnimRostro.pde
  
  Pixar's inspired mouth smooth curve from a basic polygon (array to shape vertex)
  By Alberto Pacheco (alberto@acm.org) @beto0303
  01/Dic/2014 - 30/03/2016
  
  0.5 03/12/14 Parametric values V4X/V4Y/BW/BH; Giro-boca
  0.6 30/03/16 DynShape class
  
  Inspiration: http://ed.ted.com/lessons/pixar-the-math-behind-the-movies-tony-derose
  
  Directions: move mouse cursor around drawing and box deformation produces a smooth ellipse inside
  
  To Do: 
  - SVG Image pivots
  - Cejas
  - Parpadeo
*/

import geomerative.*; //.8 Polígonos
import ddf.minim.*;   //.96 Sonido

int clicks = 1; // subdivision loop counter
int avg; //.6.97 avg frame rate
boolean swLengua = true; //.95 on/off lengua
boolean swDiente = true; //.95 on/off dentadura

PImage alien; //.5 Imagen
MouthMicShape boca;  //.6.96 Mouth
EyeDShape eye1, eye2, eye3;  //.6 Eyes

Minim minim = null; //.96 library
AudioInput mic; //.96 microphone
boolean swSonido = false; //.96 on/off mic
int FlickClose = 0; //.986 Parpadeo
int FlickOpen = 0; //.986 Parpadeo
int FLICK_RATE = 2000; //.986 Frecuencia Parpadeo
int FLICK_DELAY = 80; //.986 Parpadeo (latency)


void setup()
{
  size(400,400,P2D);
//  smooth();
//  frameRate(30);
  RG.init(this); //.8
  alien = loadImage("greenAlien.jpg"); //.5  
  boca  = new MouthMicShape(100, 155, 90, 30, 3); //.6.96
  eye1  = new EyeDShape(104, 124, 32, 18, -25); //.6
  eye2  = new EyeDShape(164, 104, 32, 18,   0); //.6
  eye3  = new EyeDShape(226, 102, 32, 18,  27); //.6
  //.96 Inic sonido
  minim = new Minim(this); //.96
  mic = minim.getLineIn();  //.96
  boca.setGain(2.0); //.97 adjust mic sensitivity here
  FlickClose = FLICK_RATE; //.986
  FlickOpen  = FlickClose + FLICK_DELAY; //.986
  avg = round(frameRate); //.97
}

void draw()
{
  image(alien,0,0); //.5
  boca.update(mouseX, mouseY, clicks); //.7.96
  int tms = millis(); //.986
  if ( tms >= FlickClose ) {//.986 Cerrar ojos
    boolean startClose = (tms == FlickClose); //.987
    eye1.blink_close(startClose);
    eye2.blink_close(startClose);
    eye3.blink_close(startClose);
//    if (startClose) {
      FlickClose += FLICK_RATE;
//    }
  } else if ( tms >= FlickOpen ) { //.986 Abrir ojos
    boolean startOpen = (tms == FlickOpen); //.987
    eye1.blink_open(startOpen);
    eye2.blink_open(startOpen);
    eye3.blink_open(startOpen);
//    if (startOpen) {
      FlickOpen += FLICK_RATE;
//    }
  }
  if ( mouseX!=pmouseX || mouseY!=pmouseY ) { // OPT
    eye1.update(mouseX, mouseY, clicks);
    eye2.update(mouseX, mouseY, clicks);
    eye3.update(mouseX, mouseY, clicks);
  }
  text(clicks,320,40);
  int fr = round(frameRate);
  text(fr,350,40); //.5 frames per second
  if (abs(avg-fr)>2) { //.97 stabilize avg range
    avg = floor(float(avg + fr)/2.0); //.97 average frame rate
  }
  text(avg,350,60);
  boca.draw(); //.6
  eye1.draw(); //.6
  eye2.draw(); //.6
  eye3.draw(); //.6
  if (swSonido) { //.96 record icon
    fill(200,0,0);  
    ellipse(324,55,12,12);
  }
}

void mouseClicked() //.5
{
  if (clicks < 4) {
    ++clicks;
    avg = round(frameRate);
  }
}

void keyPressed()
{
  switch (key) { //.9 verif tecla
    case 'L': case 'l': //.95 on/off lengua
      swLengua = !swLengua; // toggle
      break;
    case 'D': case 'd': //.95 on/off dientes
      swDiente = !swDiente; // toggle
      break;
    case 'S': case 's': case 'M': case 'm':  //.96 on/off mic
      swSonido = !swSonido; // toggle
      boca.setInput(swSonido? mic : null); //.96.97
      break;
    case 'R': case 'r': //.98 report voice data
      boca.report(); // toggle
      break;
  }
}

