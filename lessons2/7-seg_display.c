 int x;
 void setup() {
 

  Serial.begin(9600);
  pinMode(4,OUTPUT);
  pinMode(5,OUTPUT);
  pinMode(6,OUTPUT);
  pinMode(7,OUTPUT);
  pinMode(8,OUTPUT);
  pinMode(9,OUTPUT);
  pinMode(10,OUTPUT);
  pinMode(11,OUTPUT);
  pinMode(12,OUTPUT);
  pinMode(13,OUTPUT);

// put your setup code here, to run once:

}


void loop()
{
  if(Serial.available()>0)
  {
    x=Serial.read();
    x=x-'0';
    Serial.println(x,DEC);
             digitalWrite(13,LOW);
             digitalWrite(12,LOW);
             digitalWrite(10,LOW);
             digitalWrite(9,LOW);
             digitalWrite(4,LOW);
             digitalWrite(6,LOW);
             digitalWrite(7,LOW);
    delay(400);
    switch(x)
    {
      case 0 :
                          
             digitalWrite(12,HIGH);
             digitalWrite(13,HIGH);
             digitalWrite(10,HIGH);
             digitalWrite(4,HIGH);
             digitalWrite(6,HIGH);
             digitalWrite(7,HIGH);
      break;
      case 1 :
      
             digitalWrite(13,HIGH);
             digitalWrite(4,HIGH);
      break;
      case 2 :
     
             digitalWrite(13,HIGH);
             digitalWrite(12,HIGH);
             digitalWrite(9,HIGH);
             digitalWrite(6,HIGH);
             digitalWrite(7,HIGH);
      break;
      case 3 :
      
             digitalWrite(13,HIGH);
             digitalWrite(12,HIGH);
             digitalWrite(9,HIGH);
             digitalWrite(6,HIGH);
             digitalWrite(4,HIGH);
      break;
      case 4 :
      
             digitalWrite(13,HIGH);
             digitalWrite(4,HIGH);
             digitalWrite(9,HIGH);
             digitalWrite(10,HIGH);
      break;
      case 5 :
             digitalWrite(9,HIGH);
             digitalWrite(12,HIGH);
             digitalWrite(10,HIGH);
             digitalWrite(6,HIGH);
             digitalWrite(4,HIGH);
      break;
      case 6 :
      
             digitalWrite(9,HIGH);
             digitalWrite(12,HIGH);
             digitalWrite(4,HIGH);
             digitalWrite(6,HIGH);
             digitalWrite(10,HIGH);
             digitalWrite(7,HIGH);
      break;
      case 7 :
                          
             digitalWrite(13,HIGH);
             digitalWrite(12,HIGH);
             digitalWrite(4,HIGH);
             
      break;
      case 8 :
      
             digitalWrite(13,HIGH);
             digitalWrite(12,HIGH);
             digitalWrite(10,HIGH);
             digitalWrite(9,HIGH);
             digitalWrite(4,HIGH);
             digitalWrite(6,HIGH);
             digitalWrite(7,HIGH);
      break;
      case 9 : 
             digitalWrite(13,HIGH);
             digitalWrite(12,HIGH);
             digitalWrite(10,HIGH);
             digitalWrite(9,HIGH);
             digitalWrite(4,HIGH);
             digitalWrite(6,HIGH);
    }
  }
} 
