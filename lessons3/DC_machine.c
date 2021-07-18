//w表示前
//a表示左
//d表示右
//s表示后
int x;
void setup() {
 Serial.begin(9600); 
 Serial.println("Booting");
 pinMode(12,OUTPUT);
 pinMode(8,OUTPUT);
 pinMode(4,OUTPUT);
 pinMode(2,OUTPUT);
// put your setup code here, to run once:

}

void loop() {
 if(Serial.available())
 {
      x = Serial.read();
      Serial.println(x);
      switch(x)
      {
          case 'w':digitalWrite(4,HIGH);
                 digitalWrite(8,LOW);
                 digitalWrite(2,HIGH);
                 digitalWrite(12,LOW);
                 break;
          case 's':digitalWrite(4,LOW);
                 digitalWrite(8,HIGH);
                 digitalWrite(2,LOW);
                 digitalWrite(12,HIGH);
                 break;
          case 'a':digitalWrite(4,HIGH);
                 digitalWrite(8,LOW);
                 digitalWrite(2,LOW);
                 digitalWrite(12,HIGH);
                 break;
          case 'd':digitalWrite(4,LOW);
                 digitalWrite(8,HIGH);
                 digitalWrite(2,HIGH);
                 digitalWrite(12,LOW);
                 break;
      }
  }// put your main code here, to run repeatedly:

}