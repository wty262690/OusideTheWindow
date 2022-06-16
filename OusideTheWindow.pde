import processing.sound.*;
import java.util.* ;
int state=0;
boolean video=false, comic=!video;
float mousewheel=0, startmcvolume=0.001, fadevolume=0.005;
PImage back;
String Path="https://raw.githubusercontent.com/wty262690/OusideTheWindow/main/";
int fadetime=300, wheelspeed=20;
SoundFile startmusic;

void setup(){
  size(849,729,P2D);
  W=width; H=height; W2=W/2; H2=H/2;
  swsetup();
  comicset();
  //testset();
  back= new PImage(width,height);
  back.copy();
  
  
  /*
  println("System Font list :");
  printArray(PFont.list());
  */
  textFont(createFont(PFont.list()[143],200));
  startmusic = new SoundFile(OusideTheWindow.this, "/sound/Keys of Moon - Cozy Place cut.wav");
  startmusic.amp(startmcvolume);
  reset();  
  }
  
  
void draw(){
  if (video)  mousewheel+=wheelspeed/10;
  startmusic.amp(startmcvolume);//println(startmcvolume);
  if (!startmusic.isPlaying()){startmusic.loop();}
  if(frameCount<150) fadeout(back);
  else {
    switch(state){
      case(0): swdraw(); break;
      case(1): comicdraw();break;
      case(2): testdraw();break;
    }
  }
}

void mouseWheel(MouseEvent event){
  if (comic)  mousewheel+=(event.getCount()*wheelspeed);
}
void reset(){
  back=copy();
  mousewheel=-H2;
  video=false;
  comic=true;
  frameCount=0;
}

void fadeout(PImage back){
  startmcvolume=max(0.001,startmcvolume-fadevolume);
  background(back);
  push();
    fill(0,frameCount*2);
    rect(0,0,W,H);
  pop();
}

void fadein(PImage back){
  startmcvolume=min(0.4,startmcvolume+fadevolume);
  push();
    background(0);
    tint(255,(frameCount-200)*3);
    image(back,0,0);
  pop();
}
