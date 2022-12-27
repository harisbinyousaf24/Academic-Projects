int ledPin = 13;
int sensorPin = 6;

void setup() {
  pinMode(13,OUTPUT);
  pinMode(6,INPUT);

}

void loop() {
  int value = digitalRead(6);
  Serial.println(value);
  if(value == 0)
  {
    digitalWrite(13,HIGH);
    Serial.println("Motion Detected"); 
  }
  else
  {
    digitalWrite(13,LOW);
    Serial.println("Motion Not Detected");
    
  }
  delay(100);

}
