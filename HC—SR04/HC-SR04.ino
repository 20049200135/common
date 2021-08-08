#define Trig 8
#define Echo 9
float cm;
float temp;


void setup() {
  Serial.begin(9600);
  pinMode(Trig,OUTPUT);
  pinMode(Echo,INPUT);// put your setup code here, to run once:
  
}

void loop() {
  digitalWrite(Trig,LOW);
  delay(2);
  digitalWrite(Trig,HIGH);
  delay(10);
  digitalWrite(Trig,LOW);
  temp = float(pulseIn(Echo,HIGH));
  cm = (temp*17)/1000;
  Serial.print(temp );
  Serial.print( cm);
  Serial.println("cm");// put your main code here, to run repeatedly:
  delay(100);
}
