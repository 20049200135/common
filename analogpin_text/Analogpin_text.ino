int potpin = 0;
int ledpin = 13;
float val = 0;
float v;
void setup() {
  pinMode(ledpin,OUTPUT);
  Serial.begin(9600);
  // put your setup code here, to run once:

}

void loop() {
    digitalWrite(ledpin,HIGH);
    delay(50);
    digitalWrite(ledpin,LOW);
    delay(50);
    val=analogRead(potpin);// put your main code here, to run repeatedly:
    v=(val*5)/1023;
    Serial.println(val);
    Serial.println(v);
}
