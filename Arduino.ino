int pinLed1 = 2;
int pinLed2 = 3;
int pinLDR = 0;
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

