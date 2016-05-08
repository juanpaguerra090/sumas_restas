Sumas o Restas
===================


*Sumas o Restas* es un proyecto desarrollado para fomentar el aprendizaje de matemáticas básicas en niños pequeños.

----------
Introducción
-------------

Sumas y Restas es un proyecto que, por medio de sensores, apoya el aprendizaje matemático de los niños. El objetivo de este dispositivo es que los usuarios sean capaces de distinguir entre sumas y restas. 

El dispositivo funciona en conjunto con *Processing* y *Arduino*. En la pantalla, el usuario verá operaciones matemáticas básicas sin signo. Es decir, el jugador tendrá que completar la operación poniendo el signo correspondiente.  Para colocar el signo de la operación, el usuario pasará un "carrito" sobre el carril correspondiente. Un carril es destinado a sumas, y el otro para restas.  

----------

Desarrollo & Bitácora
-------------------

#### Lista de componentes

 - Arduino UNO
 - Protoboard
 - Dos Leds
 - Sensores fotovoltaicos
 - Cables de red
 - Kit de Lego
 - Resistencias
 
####Código fuente para Arduino
``` java
int pinLed1 = 2;
int pinLed2 = 3;
int pinLDR = 0;f
int pinLDR2 = 1;
int valorLDR = 0;
int valorLDR2= 0;
 
boolean s1;
boolean s2;

void setup() 
{
  pinMode(pinLed1, OUTPUT);
  pinMode(pinLed2, OUTPUT);

Serial.begin(9600);
}

void loop()
{
  
  digitalWrite(pinLed1, LOW);
  digitalWrite(pinLed2, LOW);
  
  valorLDR= analogRead(pinLDR);
  valorLDR2 = analogRead(pinLDR2);


  if(valorLDR < 10)
    {
      s1 = true;
      digitalWrite(pinLed1, HIGH);
    }
  else{
    s1 = false;
  }
 if(valorLDR2 < 10)
    {
      s2= true;
      digitalWrite(pinLed2, HIGH);
    }
  else {
    s2 = false;
  }

if(s1==true){
  Serial.println("1");
}

if(s2==true){
  Serial.println("2");
}

delay(700);
}
```

#### Código fuente de Processing
``` java
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
```

#### Blog de Avance
[En esta liga se podrá encontrar un blog referente a todos los avances que se realizaron para la realización de este proyecto.](sumasorestas.weebly.com)


Publication
-------------

Once you are happy with your document, you can publish it on different websites directly from StackEdit. As for now, StackEdit can publish on **Blogger**, **Dropbox**, **Gist**, **GitHub**, **Google Drive**, **Tumblr**, **WordPress** and on any SSH server.

#### <i class="icon-upload"></i> Publish a document

You can publish your document by opening the <i class="icon-upload"></i> **Publish** sub-menu and by choosing a website. In the dialog box, you can choose the publication format:

- Markdown, to publish the Markdown text on a website that can interpret it (**GitHub** for instance),
- HTML, to publish the document converted into HTML (on a blog for example),
- Template, to have a full control of the output.

> **Note:** The default template is a simple webpage wrapping your document in HTML format. You can customize it in the **Advanced** tab of the <i class="icon-cog"></i> **Settings** dialog.

#### <i class="icon-upload"></i> Update a publication

After publishing, StackEdit will keep your document linked to that publication which makes it easy for you to update it. Once you have modified your document and you want to update your publication, click on the <i class="icon-upload"></i> button in the navigation bar.

> **Note:** The <i class="icon-upload"></i> button is disabled when your document has not been published yet.

#### <i class="icon-upload"></i> Manage document publication

Since one document can be published on multiple locations, you can list and manage publish locations by clicking <i class="icon-upload"></i> **Manage publication** in the <i class="icon-provider-stackedit"></i> menu panel. This will let you remove publication locations that are associated to your document.

> **Note:** If the file has been removed from the website or the blog, the document will no longer be published on that location.

----------


Markdown Extra
--------------------

StackEdit supports **Markdown Extra**, which extends **Markdown** syntax with some nice features.

> **Tip:** You can disable any **Markdown Extra** feature in the **Extensions** tab of the <i class="icon-cog"></i> **Settings** dialog.

> **Note:** You can find more information about **Markdown** syntax [here][2] and **Markdown Extra** extension [here][3].


### Tables

**Markdown Extra** has a special syntax for tables:

Item     | Value
-------- | ---
Computer | $1600
Phone    | $12
Pipe     | $1

You can specify column alignment with one or two colons:

| Item     | Value | Qty   |
| :------- | ----: | :---: |
| Computer | $1600 |  5    |
| Phone    | $12   |  12   |
| Pipe     | $1    |  234  |


### Definition Lists

**Markdown Extra** has a special syntax for definition lists too:

Term 1
Term 2
:   Definition A
:   Definition B

Term 3

:   Definition C

:   Definition D

	> part of definition D


### Fenced code blocks

GitHub's fenced code blocks are also supported with **Highlight.js** syntax highlighting:

```
// Foo
var bar = 0;
```

> **Tip:** To use **Prettify** instead of **Highlight.js**, just configure the **Markdown Extra** extension in the <i class="icon-cog"></i> **Settings** dialog.

> **Note:** You can find more information:

> - about **Prettify** syntax highlighting [here][5],
> - about **Highlight.js** syntax highlighting [here][6].


### Footnotes

You can create footnotes like this[^footnote].

  [^footnote]: Here is the *text* of the **footnote**.


### SmartyPants

SmartyPants converts ASCII punctuation characters into "smart" typographic punctuation HTML entities. For example:

|                  | ASCII                        | HTML              |
 ----------------- | ---------------------------- | ------------------
| Single backticks | `'Isn't this fun?'`            | 'Isn't this fun?' |
| Quotes           | `"Isn't this fun?"`            | "Isn't this fun?" |
| Dashes           | `-- is en-dash, --- is em-dash` | -- is en-dash, --- is em-dash |


### Table of contents

You can insert a table of contents using the marker `[TOC]`:

[TOC]


### MathJax

You can render *LaTeX* mathematical expressions using **MathJax**, as on [math.stackexchange.com][1]:

The *Gamma function* satisfying $\Gamma(n) = (n-1)!\quad\forall n\in\mathbb N$ is via the Euler integral

$$
\Gamma(z) = \int_0^\infty t^{z-1}e^{-t}dt\,.
$$

> **Tip:** To make sure mathematical expressions are rendered properly on your website, include **MathJax** into your template:

```
<script type="text/javascript" src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML"></script>
```

> **Note:** You can find more information about **LaTeX** mathematical expressions [here][4].


### UML diagrams

You can also render sequence diagrams like this:

```sequence
Alice->Bob: Hello Bob, how are you?
Note right of Bob: Bob thinks
Bob-->Alice: I am good thanks!
```

And flow charts like this:

```flow
st=>start: Start
e=>end
op=>operation: My Operation
cond=>condition: Yes or No?

st->op->cond
cond(yes)->e
cond(no)->op
```

> **Note:** You can find more information:

> - about **Sequence diagrams** syntax [here][7],
> - about **Flow charts** syntax [here][8].

### Support StackEdit

[![](https://cdn.monetizejs.com/resources/button-32.png)](https://monetizejs.com/authorize?client_id=ESTHdCYOi18iLhhO&summary=true)

  [^stackedit]: [StackEdit](https://stackedit.io/) is a full-featured, open-source Markdown editor based on PageDown, the Markdown library used by Stack Overflow and the other Stack Exchange sites.


  [1]: http://math.stackexchange.com/
  [2]: http://daringfireball.net/projects/markdown/syntax "Markdown"
  [3]: https://github.com/jmcmanus/pagedown-extra "Pagedown Extra"
  [4]: http://meta.math.stackexchange.com/questions/5020/mathjax-basic-tutorial-and-quick-reference
  [5]: https://code.google.com/p/google-code-prettify/
  [6]: http://highlightjs.org/
  [7]: http://bramp.github.io/js-sequence-diagrams/
  [8]: http://adrai.github.io/flowchart.js/
