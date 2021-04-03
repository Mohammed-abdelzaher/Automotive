#define in1 3
#define in2 4
#define in3 7
#define in4 8
#define ena 5
#define enb 6

void setup() 
{
  pinMode(in1,OUTPUT);   
  pinMode(in2,OUTPUT);
  pinMode(in3,OUTPUT);
  pinMode(in4,OUTPUT);
  pinMode(ena,OUTPUT);
  pinMode(enb,OUTPUT);

}
void forward()
{
  digitalWrite(in1,0);
  digitalWrite(in2,150);
  digitalWrite(in3,0);
  digitalWrite(in4,150);
}

void reverse()
{
  digitalWrite(in1,150);
  digitalWrite(in2,0);
  digitalWrite(in3,150);
  digitalWrite(in4,0);
}

void Tleft()
{
  digitalWrite(in1,0);
  digitalWrite(in2,150);
  digitalWrite(in3,0);
  digitalWrite(in4,150);
}

void Tright()
{
  digitalWrite(in1,150);
  digitalWrite(in2,0);
  digitalWrite(in3,0);
  digitalWrite(in4,150);
}

void off()
{
  digitalWrite(in1,0);
  digitalWrite(in2,0);
  digitalWrite(in3,0);
  digitalWrite(in4,0);
}

void loop()
{
  forward();
}
