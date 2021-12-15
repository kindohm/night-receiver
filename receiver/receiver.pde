
import java.util.Iterator;
import oscP5.*;
import netP5.*;

OscP5 osc;
PFont font;
Pad[] pads = new Pad[12];

void setup() {
  frameRate(30);
  surface.setTitle("night");
  smooth();
  size(1024, 680);
  textSize(40);
  osc = new OscP5(this, 5150);
  font = loadFont("Inconsolata-48.vlw");
  textFont(font,48);
  
  for (int i = 0; i < 12; i++){
     pads[i] = new Pad(getRandomNumber(30,255), getRandomNumber(0,255), getRandomNumber(0,255)); 
  }
  
  
}

int getRandomNumber(int min, int max) {
    return (int) ((Math.random() * (max - min)) + min);
}


void draw() {
  background(0);
  
  textSize(50);
  fill(0, 208, 612);
  
  String result, resultWithPadding;
  
  for (int i = 0; i < 12; i++){
    result = Integer.toBinaryString(pads[i].count);  
    resultWithPadding = String.format("%16s", result).replaceAll(" ", "0");  // 16-bit Integer
    fill(pads[i].red);
    text(resultWithPadding, 40, 50 * i + 50); 
  }
  
}

void oscEvent(OscMessage m) {
  
  int i;
  int chan = -1;
  String s = "";
  float ccn = -1;
  

  for(i = 0; i < m.typetag().length(); ++i) {
    String name = m.get(i).stringValue();
    switch(name) {
      case "midichan":
        chan = Math.round(m.get(i+1).floatValue());
        break;
      case "s":
        s = m.get(i+1).stringValue();
        break;
      case "ccn":
        ccn = m.get(i+1).floatValue();
         break;
    }
    ++i;
  }
  
 
  if (ccn == -1 && s.equals("rytm")) {
    pads[chan].count++;
  }
  
}

public class Pad {
    public int count;
    public int red;
    public int green;
    public int blue;
   Pad(int red, int green, int blue) {
      this.count = 0;
      this.red = red;
      this.green = green;
      this.blue = blue;
   }
}
