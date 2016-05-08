import processing.serial.*;
import processing.video.*;
import java.util.Random;

Serial myPort;
String val;
int w;

boolean animation, suma, resta;
int res, num1, num2, contador=0,
    v=height, foto=1,
    figura1x,figura1y,figura2x,figura2y,figura3x,figura3y,figura4x,figura4y,figura5x,figura5y,
    figura1a,figura1g,figura2a,figura2g,figura3a,figura3g,figura4a,figura4g,figura5a,figura5g;
float i, j;
PImage fondo, figura1,figura2,figura3,figura4, figura5;

Capture video;
Random aleatorio = new Random();


void setup(){
  
String portName = Serial.list()[1];
myPort = new Serial(this, portName, 9600); 
fullScreen();
frameRate(500); background(255, 204, 0); noStroke(); rectMode(CENTER);
  video=new Capture(this,640,480,30); //video=new Capture(this,640,480,30);
  reset(); resetFondo();
}

void draw(){
  if ( myPort.available() > 0){
    val = myPort.readStringUntil('\n');
    try{ 
      if (val.contains("1")){  
         println("Cambio en sensor 1");
         suma=true; //println("SUMA");
          if(num1+num2==res){
            animation=true; reset();
          }
      }
      else if(val.contains("2")){
        println("Cambio en sensor 2");
         resta=true; //println("RESTA");
          if(num1-num2==res){
            animation=true; reset();
          }
      }
    }
      catch(NullPointerException npe){
    }
  }
  
  noStroke();
  if(animation){
    for(int i=0;i<1000;i++){
      float x=random(width), y=random(height);
      color c=fondo.get(int(x*1.4),int(y*1.4));
      fill(c); ellipse(x,y,16,16);
      contador++;
    }
    if(contador>15000){
      //println("hola, contador");
      video.start(); video.read();
      //tint(80,80,220);
      image(video,0,0,displayWidth,displayHeight);
      image(figura1,figura1x,figura1y,figura1a,figura1g);
      image(figura2,figura2x,figura2y,figura2a,figura2g);
      image(figura3,figura3x,figura3y,figura3a,figura3g);
      image(figura4,figura4x,figura4y,figura4a,figura4g);
      image(figura5,figura5x,figura5y,figura5a,figura5g);
      v--;
        ellipse(50,v,15,15);
        ellipse(200,v,15,15);
        ellipse(30,v,15,15);
        ellipse(160,v,15,15);
        ellipse(100,v,15,15);
    }
    else{
    animation=false;
    }
  }
  else{
    int i=width/2, j=height/2;
    fill(100, 204); rect(width/2, height/2, i-j*1.3, i-j*1.3); fill(255, 204); rect(width/2, height/2, i-j, i-j);
    stroke(80); line(width/2-width/25,width/2-width/6,width/2+width/25,width/2-width/6);
    fill(51); textSize(height/15);
    text(num1,width/2-width/65,height/2-height/24);
    text(num2,width/2-width/65,height/2+height/42);
    text(res,width/2-width/65,height/2+height/10);
  }
}

void mousePressed(){
     if(contador<16000){
       if(mouseButton==LEFT){
          suma=true; //println("SUMA");
          if(num1+num2==res){
            animation=true; reset();
          }
        }
     
        if(mouseButton==RIGHT){
          resta=true; //println("RESTA");
          if(num1-num2==res){
            animation=true; reset();
          }
        }
     }
     else{
       if(mouseButton==LEFT){
          saveFrame("foto"+foto+".jpeg"); foto++;
       }
       if(mouseButton==RIGHT){
         contador=0; resetFondo();
       }
     }
     
}

void reset(){
  num1=aleatorio.nextInt(7)+1; num2=aleatorio.nextInt(7)+1;
  int op=aleatorio.nextInt(2)+1;
  
  while(num2>num1){
    num2=aleatorio.nextInt(5)+1;
  }
  
  if(op==1){
    res=num1+num2;
  }
  else if(op==2){
    res=num1-num2;
  }
}

void resetFondo(){
    int juego=aleatorio.nextInt(3)+1;
    
    if(juego==1){
      fondo=loadImage("mar.jpg");        
      figura1=loadImage("shark.png");    figura1x=50; figura1y=100;    figura1a=300; figura1g=500;
      figura2=loadImage("dolphin.png");  figura2x=900; figura2y=200;   figura2a=400; figura2g=400;
      figura3=loadImage("fish.png");     figura3x=500; figura3y=450;   figura3a=450; figura3g=330;
      figura4=loadImage("coral1.png");   figura4x=10; figura4y=390;    figura4a=180; figura4g=400;
      figura5=loadImage("coral2.png");   figura5x=1160; figura5y=390;  figura5a=210; figura5g=400;
    }
    else if(juego==2){
      fondo=loadImage("jungle.jpg");
      figura1=loadImage("elephant.png");    figura1x=-40; figura1y=300;    figura1a=620; figura1g=500;
      figura2=loadImage("lion.png");     figura2x=610; figura2y=150;   figura2a=1200; figura2g=900;
      figura3=loadImage("bird.png");     figura3x=800; figura3y=100;   figura3a=200; figura3g=170;
      figura4=loadImage("trees1.png");   figura4x=-22; figura4y=580;   figura4a=800; figura4g=220;
      figura5=loadImage("trees2.png");   figura5x=660; figura5y=390;   figura5a=810; figura5g=400;
    }
    else if(juego==3){
      fondo=loadImage("desert.jpg");
      figura1=loadImage("snake.png");    figura1x=-40; figura1y=80;    figura1a=420; figura1g=300;
      figura2=loadImage("camel.png");     figura2x=790; figura2y=90;   figura2a=700; figura2g=500;
      figura3=loadImage("cactus3.png");     figura3x=150; figura3y=680;   figura3a=520; figura3g=120;
      figura4=loadImage("cactus1.png");   figura4x=-22; figura4y=425;   figura4a=300; figura4g=360;
      figura5=loadImage("cactus2.png");   figura5x=660; figura5y=390;   figura5a=810; figura5g=400;
    }
}
