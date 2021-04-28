
const int trigPin = 7;
const int echoPin = 8;

void setup() {
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT); 

}

void loop() {

  long duration,distance,spd;
  
  
  digitalWrite(trigPin,LOW);
  delayMicroseconds(5);
  
  digitalWrite(trigPin,HIGH);
  delayMicroseconds(10);  
  digitalWrite(trigPin,LOW);

  //calculate duration  
  duration=pulseIn(echoPin,HIGH);
  
  //calculate distance 
  distance=calcualteDistance(duration);

  //calculate spd 
  spd= calcluateSpd(duration,distance);

}


long calcualteDistance(long duration)
{
  return duration/58;
}


long calcluateSpd(long  duration , long distance )
{
  return distance / duration ;
}
