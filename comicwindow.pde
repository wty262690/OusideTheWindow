BP PAGE;
float buttonr;
SoundFile schoolbell, birdsound;
boolean playschoolbell=false, playbirdsound=false;
void comicset(){
  PAGE=new BP();
  birdsound = new SoundFile(OusideTheWindow.this, "/sound/robin_brid_sound.wav");
  birdsound.amp(1);
  schoolbell = new SoundFile(OusideTheWindow.this, "/sound/schoolbell.wav");
  schoolbell.amp(0.05);
  buttonr=min(W,H)/15;
}
void comicdraw(){
  //background(255);
  PAGE.bpdraw();
  if(frameCount<fadetime) fadein();
  ////--------- schoolbell ring ---------////
  if (mousewheel>=-H2-wheelspeed*2 && mousewheel<=-H2+wheelspeed*2){
    if (!schoolbell.isPlaying() && !playschoolbell) {
      schoolbell.play();
      playschoolbell=true;
    }
  }
  else playschoolbell=false;
  ////--------- birdsing ---------////
  if (mousewheel>=PAGE.pageh*5-wheelspeed*2 && mousewheel<=PAGE.pageh*5+wheelspeed*2){
    if (!birdsound.isPlaying() && !playbirdsound) {
      birdsound.play();
      playbirdsound=true;
    }
  }
  else playbirdsound=false;
  
  ////--------- play type button ---------////
  push();
    noStroke();
    blendMode(SCREEN);
    fill(255,100);
    if (dist(mouseX,mouseY,W-buttonr*1.5,H-buttonr*1.5)<buttonr) {fill(0,200);}
    circle(W-buttonr*1.5,H-buttonr*1.5,buttonr); 
  pop();
}

void mouseClicked(){
  if (state==1 && dist(mouseX,mouseY,W-buttonr*1.5,H-buttonr*1.5)<buttonr) {
    video=!video;
    comic=!comic;
  }
}
