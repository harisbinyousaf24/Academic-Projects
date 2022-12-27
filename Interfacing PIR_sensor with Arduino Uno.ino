int led = 13;
int sensor = 2;

int value = 0;
int State = LOW;

void setup() {
  pinMode(led, OUTPUT);
  pinMode(sensor, INPUT);
  Serial.begin(9600);
}

void loop() {

  value = digitalRead(sensor);

  if (value == HIGH) {
    digitalWrite(led, HIGH);

    if (State == LOW) {
      Serial.println("Motion Detected!");
      State = HIGH;
    }
  }else{
    digitalWrite(led, LOW);

    if(State == HIGH){
      Serial.println("Motion Ended!");
      State = LOW;
      }
    }
}
