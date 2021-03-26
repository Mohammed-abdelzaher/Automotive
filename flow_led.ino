int lednum=9;//number of Leds
int ledpin[]={2,3,4,5,6,7,8,9,10};      // PINS of leds
int delayTime=100;

void setup() {
  // put your setup code here, to run once:
 for (int x = 0; x < lednum; x++) {      // setting all LEDs as OUTPUT 
   pinMode(ledpin[x], OUTPUT);
  }
}
void loop() {
  ledtoggle();                          //TOGGLE ALL LEDs
  delay(1000);                          //time inverval
  led_right_indicator();                //Left to Right
  delay(1000);                          //time inverval
  led_left_indicator();                 //Right to Left
}
//Left to Right
void led_right_indicator() {
  for (int i = lednum; i >= 0; i--) {
    digitalWrite(ledpin[i], HIGH);      //turn on LEDs
    delay(delayTime);                   //time inverval
  }
  for (int i = lednum; i >= 0; i--) {
    digitalWrite(ledpin[i], LOW);       //turn off leds
    delay(delayTime);
  }
}
//Right to Left
void led_left_indicator() {
  for (int i = 0; i < lednum; i++) {
    digitalWrite(ledpin[i], HIGH);      //turn on LEDs
    delay(delayTime);                   //time inverval
  }
  for (int i = 0; i < lednum; i++) {
    digitalWrite(ledpin[i], LOW);       //turn off leds
    delay(delayTime);                   //time inverval
  }
}

//TURN ON ALL LEDs
void ledonn() {
  for (int i = 0; i < lednum; i++) {
    digitalWrite(ledpin[i], HIGH);      //turn on LEDs
  }
}

//TURN OFF ALL LEDs
void ledoff() {
  for (int i = 0; i < lednum; i++) {
    digitalWrite(ledpin[i], LOW);       //turn off leds
  }
}
//TOGGLE ALL LEDs
void ledtoggle(){             
  delay(500);                          //time inverval
  ledonn();                            //turn on LEDs
  delay(500);                          //time inverval
  ledoff();                            //turn off leds
}
