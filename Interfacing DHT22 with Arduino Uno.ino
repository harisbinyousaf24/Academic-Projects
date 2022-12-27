#include "DHT.h"


#define DHTPIN 8
#define DHTTYPE DHT22

DHT dht(DHTPIN, DHTTYPE); 

int FAN=7;

void setup()
{
    Serial.begin(9600);
    pinMode(FAN, OUTPUT);
}

void loop()
{
  
 float h = dht.readHumidity();
 Serial.println(h);
  
  if(h>=75)
  {
    digitalWrite(FAN,HIGH);
  }
  else
  {
    digitalWrite(FAN,LOW);
  }
  
  delay(500);
}
