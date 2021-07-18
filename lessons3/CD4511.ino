int x;
void setup() {
  Serial.begin(9600);
  pinMode(10,OUTPUT);
  pinMode(11,OUTPUT);
  pinMode(12,OUTPUT);
  pinMode(13,OUTPUT);// put your setup code here, to run once:

}

void loop() {
  if(Serial.available())
  {
    x=Serial.read();
    x = x-'0';
    digitalWrite(10,x & 0x01);
    digitalWrite(11,(x>>1) & 0x01);
    digitalWrite(12,(x>>2) & 0x01);
    digitalWrite(13,(x>>3) & 0x01);
    delay(100);
    }// put your main code here, to run repeatedly:

}
