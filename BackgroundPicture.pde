class BP{
  String[] pagename = new String[10];
  String[] smallpagename = new String[10];
  PImage[] page= new PImage[pagename.length];
  int [] SamllPageNum={0,0,0,3,0,1,0,0,2,0};
  ArrayList<SP> smallpage ;
  
  float pageh;
  BP(){
    smallpage = new ArrayList<SP>();
    for(int i=0; i<page.length; i++){
      pagename[i]=str(i+2);
      page[i]=loadImage(Path+pagename[i]+".png");
      page[i].resize(width,height*(page[i].width/width));
      smallpage.add(new SP(i+2,SamllPageNum[i]));
    }
    pageh=page[0].height;
  }
  void bpdraw(){
    ////---------background---------////
    int pindex=min(9,int(mousewheel/pageh));
    if (pindex>=0 && pindex<page.length){
      copy(page[pindex],0,int(mousewheel-(pindex*pageh)),page[pindex].width,height,0,0,width,height);
      if (pindex+1<page.length)  copy(page[pindex+1],0,0,page[pindex].width,height,0,int(((pindex+1)*pageh)-mousewheel),width,height);
    }
    else {
      mousewheel=pageh*pindex;
    }
    
    ////---------window---------////
    SP p;
    p = smallpage.get(pindex);
    switch(pindex+2){
      case(5):  p.spdraw(pindex, pageh,1,H/8,250, new PVector(0,100));  break;
      case(7):  p.spdraw(pindex, pageh,2,H/1.5,0, new PVector(-100,0));  break;
      case(10):  p.spdraw(pindex, pageh,1,H/8,300,new PVector(0,100));  p.leafdraw(pindex,pageh); break;
      case(11):  p.leafdraw(pindex-1,pageh); break;
      default: break;
    }
  }
}

class SP{
  PImage[] page;
  PImage leaf;
  PVector[] pageloca;
  float alpha=0;
  SP(int path, int num){
    page=new PImage[num];
    pageloca= new PVector[num];
    for (int i=0; i<num; i++){
      page[i]=loadImage(Path+path+"-"+str(i+1)+".png");
      page[i].resize(width,height*(page[i].width/width));
      pageloca[i]=new PVector(0,0);
      ////---------change (0,0,0,0) into (255,0,0,0) ---------////
      /*/////////////////////////////////////////////////////////
      page[i].loadPixels();
       for(int j=0;j<page[i].pixels.length;j++) {
           color c =  page[i].pixels[j]; 
           if(red(c)==0 && green(c)==0 && blue(c)==0 && alpha(c)==0)  page[i].pixels[j] = color(255,0,0,0);
       }
      page[i].updatePixels();
      /////////////////////////////////////////////////////////*/
    }
    leaf=loadImage(Path+"10-leaf.png");
    leaf.resize(width,height*(leaf.width/width));
  }
  
  void spdraw(int pindex, float pageh, float speed , float fadeh, float fadegap,PVector move){
    alpha=mousewheel-(pindex*pageh)-fadeh;//println(alpha);
    for (int i=0; i<page.length; i++){
      /*/////////////////////////////////////////////////////////
      page[i].loadPixels();
       for(int j=0;j<page[i].pixels.length;j++) {
           color c =  page[i].pixels[j]; 
           if(c==color(255,0,0,0)) continue;
           page[i].pixels[j] = color(red(c),green(c),blue(c),min(alpha-i*150,300));
       }
      page[i].updatePixels();
      /////////////////////////////////////////////////////////*/
      push();
        tint(255, min(alpha-i*fadegap,300));// this is better 
        if (alpha<0){
          pageloca[i].x=move.x;
          pageloca[i].y=move.y;
        }
        float movex=map(alpha-i*fadegap,0,200,move.x,0);
        float movey=map(alpha-i*fadegap,0,200,move.y,0);
        
        pageloca[i].x= min(movex,0);
        pageloca[i].y=-int(mousewheel-(pindex*pageh))+max(movey,0);
        
        image(page[i],pageloca[i].x,pageloca[i].y);
      pop();
    }
  }
  
  void leafdraw(int pindex, float pageh){
    push();
      translate(W/4,H2);
      circle(0,0,20);
      rotate((mousewheel-(pindex*pageh))*0.001- 0.2);
      image(leaf,-W/4,-H2);
    pop();
  }
  
}
