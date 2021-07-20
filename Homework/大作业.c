#include <MsTimer2.h>
static int tick1,tick2,i;
void onTimer()
{
   
   tick1++;
   if(tick1>9)
   {
      tick1=0;
      tick2++;
    }
    if(tick1 == 9 && tick2 == 9)
    {
       tick1=0;
       tick2=0;
       i++;
       Serial.print(i);
       Serial.println("times");
   
    }
  if(!(digitalRead(1)))
  {
       delay(10);
       tick1=0;
       tick2=0;
  }
  digitalWrite(2,tick1 & 0x01);
  digitalWrite(3,(tick1>>1) & 0x01);
  digitalWrite(4,(tick1>>2) & 0x01);
  digitalWrite(5,(tick1>>3) & 0x01);
  digitalWrite(9,tick2 & 0x01);
  digitalWrite(13,(tick2>>1) & 0x01);
  digitalWrite(12,(tick2>>2) & 0x01);
  digitalWrite(10,(tick2>>3) & 0x01);
  }




void setup() {
  Serial.begin(9600);
  pinMode(1,OUTPUT);
  pinMode(2,OUTPUT);
  pinMode(3,OUTPUT);
  pinMode(4,OUTPUT);
  pinMode(5,OUTPUT);
  pinMode(9,OUTPUT);
  pinMode(10,OUTPUT);
  pinMode(12,OUTPUT);
  pinMode(13,OUTPUT);
  MsTimer2::set(1000,onTimer);
  MsTimer2::start();
 // put your setup code here, to run once:

}

void loop() {
  // put your main code here, to run repeatedly:

}