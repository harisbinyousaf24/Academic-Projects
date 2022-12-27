#include<Servo.h>
Servo motor;
int potentiometer=0;
int value;
void setup() {
  motor.attach(9);

}

void loop() {
 value=analogRead(potentiometer);
 value=map(value,0,1023,0,180);
 motor.write(val);
 delay(5);

}
