import processing.serial.*;
Serial myPort;  
String val="";

class Module 
{
  int a,b,c,d;
  Module(int p, int q, int r, int s) 
  {
    a=p;
    b=q;
    c=r;
    d=s;
  }
  void display()
  {
    fill(255);
    stroke(255);
    rect(a,b,c,d);
  }
}

Module[] maze;

void setup()
{
size(500,500);
background(0);
maze=new Module[42];
maze[0]=new Module(0,0,400,5);
maze[1]=new Module(450,0,50,5);
maze[2]=new Module(50,0,5,75);
maze[3]=new Module(100,0,5,50);
maze[4]=new Module(250,0,5,50);
maze[5]=new Module(50,100,5,60);
maze[6]=new Module(100,160,5,60);
maze[7]=new Module(50,75,50,5);
maze[8]=new Module(50,160,50,5);
maze[9]=new Module(0,100,50,5);
maze[10]=new Module(50,225,5,100);
maze[11]=new Module(50,275,100,5);
maze[12]=new Module(100,350,100,5);
maze[13]=new Module(100,350,5,50);
maze[14]=new Module(150,45,100,5);
maze[15]=new Module(150,50,5,50);
maze[16]=new Module(150,100,50,5);
maze[17]=new Module(150,75,150,5);
maze[18]=new Module(100,125,100,5);
maze[19]=new Module(200,125,5,100);
maze[20]=new Module(300,50,5,75);
maze[21]=new Module(250,100,5,50);
maze[22]=new Module(250,225,5,125);
maze[23]=new Module(250,350,50,5);
maze[24]=new Module(300,50,100,5);
maze[25]=new Module(400,50,5,25);
maze[26]=new Module(445,50,5,150);
maze[27]=new Module(445,200,50,5);
maze[28]=new Module(495,0,5,400);
maze[29]=new Module(100,395,400,5);
maze[30]=new Module(450,300,50,5);
maze[31]=new Module(445,225,5,50);
maze[32]=new Module(400,105,5,195);
maze[33]=new Module(400,330,5,75);
maze[34]=new Module(400,225,50,5);
maze[35]=new Module(200,220,100,5);
maze[36]=new Module(300,325,150,5);
maze[37]=new Module(300,300,105,5);
maze[38]=new Module(300,150,5,75);
maze[39]=new Module(300,150,100,5);
maze[40]=new Module(0,395,50,5);
maze[41]=new Module(0,0,5,400);
myPort = new Serial(this,"COM3", 4800);
}

int j=0;
int k=0;
int x=250;
int y=450;
int Jx=0;
int Jy=493;
int a=0,b=0,Vx=0,Vy=0;
int x1=250;
int y1=450;
int Jx1=0;
int Jy1=493;
int a1=0,b1=0,Vx1=0,Vy1=0;
int x2=250;
int y2=450;
int Jx2=0;
int Jy2=493;
int a2=0,b2=0,Vx2=0,Vy2=0;

void draw()
{
    if(k==0)
    {
    fill(0,0,255);
    stroke(0,0,255);
    rect(10,200,190,100);
    fill(0,0,255);
    stroke(0,0,255);
    rect(300,200,190,100);
    fill(255);
    stroke(255);
    textMode(SHAPE);
    textSize(25);
    text("Single Player",30,250);
    textMode(SHAPE);
    textSize(25);
    text("Multi Player",320,250);
    }
    if(myPort.available()>0)
  {
  val= myPort.readStringUntil('\n');
  }
    if(val!=null)
  {
  String str1[] = {"","","","",""};
  str1=splitTokens(val,",");
    if(str1.length==5)
  {
  str1[1]=str1[1].trim();
  str1[2]=str1[2].trim();
  str1[3]=str1[3].trim();
  str1[4]=str1[4].replace("\n","");
  str1[4]=str1[4].trim();
  Jx1=int(str1[0]);
  Jy1=int(str1[1]);
  Jx2=int(str1[2]);
  Jy2=int(str1[3]); 
  if(Jx1<=1023 && Jx2<=1023)
  {
    if (j==0)
    {
  if(Jx1==0 | Jx2==0)
  {
    fill(0,255,0);
    stroke(0,255,0);
    rect(290,190,210,120);
    j=2;
  }
  if(Jx1==1023 | Jx2==1023)
  {
    fill(0,255,0);
    stroke(0,255,0);
    rect(0,190,210,120);
    j=1;
  }
    }
  }
  if(int(str1[4])==1)
  {
    k=1; 
  }
  if(j==1 && k==1)
  {
      //print(x1,",",y1,"\n");
      background(0);
      for(Module mod : maze) 
      {
         mod.display();
      }
      fill(255,0,0);
      stroke(255,0,0);
      ellipse(x,y,10,10);
      if(myPort.available()>0)
      {
      val= myPort.readStringUntil('\n');
      }
      if(val!=null)
      {
      Jx=int(str1[0]);
      Jy=int(str1[1]);
      if(Jx<=1023 && Jy<=1023)
      {
      a=513-Jx;
      b=493-Jy;
      Vx=int((4*a)/511);
      Vy=int((4*b)/511);
      for(int count=0; count<42; count++) 
      {
         //print(count);
         if(x>maze[count].a && x<(maze[count].a+maze[count].c) && y>maze[count].b && y<(maze[count].b+maze[count].d))
         {
           myPort.write(2);
           //println("no");
           background(0);
           fill(255,0,0);
           stroke(255,0,0);
           textMode(SHAPE);
           textSize(80);
           text("GAME OVER",20,250);
           noLoop();
         }
      }
      if(y<=0 && y>=-5 && x>400 && x<450)
      {
        myPort.write(2);
        //println("yes");
        background(0);
        fill(0,255,0);
        stroke(0,255,0);
        textMode(SHAPE);
        textSize(105);
        text("YOU WIN",20,250);
        noLoop();
      }
      myPort.write(0);
      x+=Vx;
      y+=Vy;
      }
      }
      else
      {
        val="";
      }
      }
  }
  if(j==2 && k==1)
  {
      //print(x1,",",y1,"\n");
      background(0);
      for(Module mod : maze) 
      {
         mod.display();
      }
      fill(255,0,0);
      stroke(255,0,0);
      ellipse(x1,y1,10,10);
      fill(0,255,0);
      stroke(0,255,0);
      ellipse(x2,y2,10,10);
      if(myPort.available()>0)
      {
      val= myPort.readStringUntil('\n');
      }
      if(val!=null)
      {
      Jx1=int(str1[0]);
      Jy1=int(str1[1]);
      Jx2=int(str1[2]);
      Jy2=int(str1[3]);
      if(Jx1<=1023 && Jy1<=1023 && Jx2<=1023 && Jy2<=1023)
      {
      a1=513-Jx1;
      b1=493-Jy1;
      a2=513-Jx2;
      b2=493-Jy2;
      Vx1=int((4*a1)/511);
      Vy1=int((4*b1)/511);
      Vx2=int((4*a2)/511);
      Vy2=int((4*b2)/511);
      for(int count=0; count<42; count++) 
      {
         //print(count);
         if(x1>maze[count].a && x1<(maze[count].a+maze[count].c) && y1>maze[count].b && y1<(maze[count].b+maze[count].d))
         {
           myPort.write(1);
           //println("no");
           background(0);
           fill(255,0,0);
           stroke(255,0,0);
           textMode(SHAPE);
           textSize(70);
           text("Player 2 Wins",20,250);
           noLoop();
         }
          if(x2>maze[count].a && x2<(maze[count].a+maze[count].c) && y2>maze[count].b && y2<(maze[count].b+maze[count].d))
         {
           myPort.write(2);
           //println("no");
           background(0);
           fill(255,0,0);
           stroke(255,0,0);
           textMode(SHAPE);
           textSize(70);
           text("Player 1 Wins",20,250);
           noLoop();
         }
      }
      if(y1<=0 && y1>=-5 && x1>400 && x1<450)
      {
        myPort.write(2);
        //println("yes");
        background(0);
        fill(0,255,0);
        stroke(0,255,0);
        textMode(SHAPE);
        textSize(105);
        text("Player 1 Wins",20,250);
        noLoop();
      }
      if(y2<=0 && y2>=-5 && x2>400 && x2<450)
      {
        myPort.write(1);
        //println("yes");
        background(0);
        fill(0,255,0);
        stroke(0,255,0);
        textMode(SHAPE);
        textSize(70);
        text("Player 2 Wins",20,250);
        noLoop();
      }
      myPort.write(0);
      x1+=Vx1;
      y1+=Vy1;
      x2+=Vx2;
      y2+=Vy2;
      }
      }
      else{
        val="";
      }
      }
  }
  }
