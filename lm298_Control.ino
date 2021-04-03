
// Motor A connections
#define ena 5
#define in1 3
#define in2 4
// Motor B connections
#define enb 6
#define in3 7
#define in4 8

void setup() 
{
  // Set all the motor control pins to outputs
  pinMode(in1,OUTPUT);   
  pinMode(in2,OUTPUT);
  pinMode(in3,OUTPUT);
  pinMode(in4,OUTPUT);
  pinMode(ena,OUTPUT);
  pinMode(enb,OUTPUT);

}
void forward()
{
  // Set motors to maximum speed
  // For PWM maximum possible values are 0 to 255
  analogWrite(enA, 255);
  analogWrite(enB, 255);
  digitalWrite(in1, LOW);
  digitalWrite(in2, HIGH);
  digitalWrite(in3, LOW);
  digitalWrite(in4, HIGH);
}

void reverse()
{
  analogWrite(enA, 255);
  analogWrite(enB, 255);
 digitalWrite(in1, HIGH);
 digitalWrite(in2, LOW);
 digitalWrite(in3, HIGH);
 digitalWrite(in4, LOW);
}

void Tleft()
{
  analogWrite(enA, 255);
  analogWrite(enB, 255);
  digitalWrite(in1,LOW);
  digitalWrite(in2,HIGH);
  digitalWrite(in3,LOW);
  digitalWrite(in4,HIGH);
}

void Tright()
{
  analogWrite(enA, 255);
  analogWrite(enB, 255);
  digitalWrite(in1,HIGH);
  digitalWrite(in2,LOW);
  digitalWrite(in3,LOW);
  digitalWrite(in4,HIGH);
}

void off()
{
  digitalWrite(in1,LOW);
  digitalWrite(in2,LOW);
  digitalWrite(in3,LOW);
  digitalWrite(in4,LOW);
}

void loop()
{
  forward();
}
