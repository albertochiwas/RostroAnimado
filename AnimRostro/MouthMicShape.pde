import ddf.minim.*;   //.96 Sonido

public class MouthMicShape extends MouthDShape { //.96 mic input controlled mouth class

  AudioInput mic; //.96 microphone
  float gain; //.97 amplitude multiplier factor

  public MouthMicShape(int x, int y, int w, int h, int ang) {
    super(x,y,w,h,ang);
    mic = null; //.96
    gain = 1.0; //.97
  }
  
  public void setInput(AudioInput m) { //.96.97 audio signal object
      mic = m;
  }

  public void setGain(float m) { //.97 Mic sensivity
      gain = m;
  }

  public void update(int mx, int y, int times) { //.96 
    if ( mic != null ) { //.96 mic on?
      int bsz = mic.bufferSize() - 1; // Mic input 
      for (int i=0; i < bsz; i++) { //.5.97 Draw mic signal
        stroke(0);
        line( i, 350 + mic.mix.get(i)*50, i+1, 350 + mic.mix.get(i+1)*50 ); //.97
      }
      tall = map( mic.mix.level() * gain,0.0,1.0,0,1.2*BH); //.5.97 RMS value
//      println(tall);
    } else { //.96 mic off
      tall = map(y,0,height,0,1.2*BH); //.7
    }
    super._update(mx,y,times);  // cont'd update original  
  }
  
} // class


