PImage leaf;
PVector leaflocation;
void testset(){
  leaf=loadImage(Path+"10-leaf.png");
  leaf.resize(width,height*(leaf.width/width));
  mousewheel=10*leaf.height;
  leaflocation=new PVector(-W2-150,-H2+80);
}
void testdraw(){
  background(0);
    float dis=(mousewheel-(10*leaf.height));
    push();
    translate(W2,H2);
      //translate(W/3+map(dis,0,leaf.height,0,10),H2);
      circle(0,0,20);
      rotate(-dis*0.001-0.1);
      leaflocation.x-=map(dis,0,leaf.height,0,200);
      leaflocation.y-=map(dis,0,leaf.height,0,100);
      println(leaflocation.x,leaflocation.y);
      image(leaf,leaflocation.x, leaflocation.y);
    pop();
}
