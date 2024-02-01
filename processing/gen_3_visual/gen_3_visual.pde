import oscP5.*;  
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
float speed;
int direction, drum;
int w = 600, h = 900;


void setup() {
  size(600, 900);
  

  oscP5 = new OscP5(this, 12000);   //listening
  myRemoteLocation = new NetAddress("127.0.0.1", 57120);  //  speak to
  
  // The method plug take 3 arguments. Wait for the <keyword>
  oscP5.plug(this, "varName", "keyword");
}

void draw() {
  background(round((speed - 0.4) * 2550));
  
  noStroke();
  float sn = (speed - 0.4) * 10;
  fill(255 - sn * 255);
  rectMode(CENTER);
  square(w/2, h/2, sn * 600);
  
  fill(round(drum * 25.5), round((drum/100) * 2550), drum + random(-100, 100));
  circle(drum*6, drum*12 + random(3)*drum, drum * 10 + 50);
  
  
}

void oscEvent(OscMessage msg) {
  println("### received an osc message with addrpattern "+msg.addrPattern()+" and typetag "+msg.typetag());
  if(msg.checkAddrPattern("/drum")) drum = msg.get(0).intValue();
  if(msg.checkAddrPattern("/direction")) direction = msg.get(0).intValue();
  if(msg.checkAddrPattern("/speed")) speed = msg.get(0).floatValue();
}
