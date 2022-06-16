PImage background,bell;
float W, H, W2, H2;
float bellrotate=0, brchange=0.005;

void swsetup(){
  size(849,729,P2D);
  W=width; H=height; W2=W/2; H2=H/2;
  background=loadImage(Path+"image/"+"1-background.png");  
  bell=loadImage(Path+"image/"+"1-bell.png");
  bell.resize(width,height);
  background.resize(width,height);
  }
void swdraw(){
  ////---------background---------////
  image(background,0,0);
  if (bellrotate>0.15 || bellrotate<-0.15) brchange=-brchange;
  bellrotate+=brchange;
  //println(bellrotate);//check
  push();
    translate(W2-10,H2-180);
    rotate(bellrotate);
    imageMode(CENTER);
    image(bell,10,180);
    //circle(0,0,10);//check
    rotate(-bellrotate);
    translate(-(W2-10),-(H2-180));
  pop();
  if(frameCount<fadetime){
    fadein(copy()); return;
  }
  ////---------text---------////
  push();
  fill(255,200);
  noStroke();
  rectMode(CORNER);
  rect(0,H2,min(W,(frameCount-20-fadetime)*10),80);
  pop();
  push();
  fill(0,min(200,(frameCount-70-fadetime)*1.5));
  textAlign(CENTER,CENTER);
  textSize(50);
  text("OUTSIDE THE WINDOW", W2,H/1.8);
  pop();
  ////---------playbutton---------////
  push();
  translate(W2,H/1.4);
  fill(0,min(210,(frameCount-130-fadetime)));
  noStroke(); 
  //strokeWeight(2.2);
  //circle(0,0,110);//check
  if (frameCount-130-fadetime>50 && dist(mouseX,mouseY,W2,H/1.4)<55) {
    fill(255,210);
    if (mousePressed){
      state=1;
      reset();
    }
  }
  beginShape();
  curveVertex(-25,  50);
  curveVertex(50,  0);
  curveVertex(-25,  -50);
  curveVertex(-25,  50);
  curveVertex(50,  0);
  curveVertex(-25, -50);
  endShape();
  pop();
  
}
