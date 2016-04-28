import ddf.minim.*;   //.96 Sonido

public class MouthMicShape extends MouthDShape { //.96 +mic

  AudioInput mic; //.96 microphone

  public MouthMicShape(int x, int y, int w, int h, int ang) {
    super(x,y,w,h,ang);
    mic = null; //.96
  }
  
  public void entrada(AudioInput m) { //.96
      mic = m;
  }

  public void update(int mx, int y, int times) { //.96 
    if ( mic != null ) { //.96 mic on?
      int bsz = mic.bufferSize(); // Mic input 
      FloatList niv = new FloatList(bsz);
      for (int i=0; i < bsz; i++) { //.5
        niv.append((abs(mic.left.get(i)) + abs(mic.right.get(i))) / 2.0); // OPT  
      }
      float sn = niv.max(); // TO DO: Improve. Mayor amplitud sensada
      tall = map(sn,0.0,1.0,0,1.2*BH)*10.0; //.5
      println(tall);
    } else { //.96 mic off
      tall = map(y,0,height,0,1.2*BH); //.7
    }
    super._update(mx,y,times);  // cont'd update original  
  }
  
}


