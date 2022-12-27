int val = 0;
int raw = 0;

void setup() {

pinMode(LED_BUILTIN, OUTPUT);

Serial.begin(9600);
}

void loop() {
raw=analogRead(inputPin);
val = map(raw, 0, 1023, 0, 21); function will convert analog value to digital value in the range of 0 to 1024
Serial.println("--");
Serial.print("Battery Value smooth:=");Serial.print(val);
Serial.println("--");
delay(500);
}
