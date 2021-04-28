
#include <Ultrasonic.h>
Ultrasonic ultrasonic_front(40,41),ultrasonic_back(38,39),utlrasonic_LF(36,37),ultrasonic_LB(34,35);
//ultrasonic is not defined 

// Motor A connections
#define ena 5
#define in1 3
#define in2 4
// Motor B connections
#define enb 6
#define in3 7
#define in4 8


byte forward =0;
byte backward = 1;
byte left =2;
byte right =3;

#define minimum_limit 15    // car length 
#define minimum_limit1 8   // car width 

byte park_status=0;

void setup() {
  
   // Set all the motor control pins to outputs
  pinMode(in1,OUTPUT);   
  pinMode(in2,OUTPUT);
  pinMode(in3,OUTPUT);
  pinMode(in4,OUTPUT);
  pinMode(ena,OUTPUT);
  pinMode(enb,OUTPUT);
}

//movement function
void robot_movement(byte motor,byte spd)
{
  if(motor==forward)
  {
      analogWrite(ena, spd);
      analogWrite(enb, spd);
      digitalWrite(in1, LOW);
      digitalWrite(in2, HIGH);
      digitalWrite(in3, LOW);
      digitalWrite(in4, HIGH);
  }

  if(motor==backward)
  {
     analogWrite(ena, spd);
     analogWrite(enb, spd);
     digitalWrite(in1, HIGH);
     digitalWrite(in2, LOW);
     digitalWrite(in3, HIGH);
     digitalWrite(in4, LOW);
  }

  if(motor==left)
  {
    
      analogWrite(ena, spd);
      analogWrite(enb, spd);
      digitalWrite(in1,LOW);
      digitalWrite(in2,HIGH);
      digitalWrite(in3,LOW);
      digitalWrite(in4,HIGH);
  }
  
  if(motor==right)
  {
    
      analogWrite(ena, spd);
      analogWrite(enb, spd);
      digitalWrite(in1,HIGH);
      digitalWrite(in2,LOW);
      digitalWrite(in3,LOW);
      digitalWrite(in4,HIGH);
  }
}

// robot stop 

void robot_stop(){

      analogWrite(ena, 0);
      analogWrite(enb, 0);
      digitalWrite(in1,LOW);
      digitalWrite(in2,LOW);
      digitalWrite(in3,LOW);
      digitalWrite(in4,LOW);
  }




//parking place search 

bool park_place_search()
{
  long forward_sensor= ultrasonic_front.read(CM);
  long lf_sensor=  utlrasonic_LF.read(CM);
  long lb_sensor= ultrasonic_LB.read(CM);

  // case 1 : no available park areas 
  if( (lf_sensor <= minimum_limit) && (lb_sensor <=minimum_limit) && (park_status==0))
  {
 
    robot_movement(forward,100);
    park_status=1; 
   
  }

  // case 2 : available parriel park area 
  if( (lf_sensor > minimum_limit) &&( lf_sensor  < minimum_limit1) && ( lb_sensor > minimum_limit) && ( lb_sensor < minimum_limit1) && (park_status==1) )
  {
    robot_movement(forward,100);
    park_status=2;
    
  } 

  // case 3 :  available vertical parking found 
  if( ( lf_sensor  > minimum_limit) &&( lb_sensor > minimum_limit) && (park_status==1) )
  {
     robot_stop();
     delay(500);
     park_status=10;
  }
  
  //case 4 : after case 2 and activating parriel parking 

  if( (lf_sensor <= minimum_limit) && (lb_sensor <=minimum_limit) && (park_status==2) )
  {
    park_status=3; 
    
  }

  return park_status;
 
}

void park()
{
  park_place_search();

  if(park_status==3)
  {
    robot_stop();
    delay(200);
    park_status=4;
  }

  if(park_status==4)
  {
    robot_movement(backward,120);
    delay(100);
    robot_stop();
    robot_movement(right,150);
    delay(100);
    robot_stop();
    delay(500);
    park_status=5;
    
  }

  if( park_status==5)
  {
    robot_movement(backward,120);
    long back_sensor=ultrasonic_back.read(CM);

    if(back_sensor <=13)
    {
      robot_stop();
      delay(500);
      park_status=6;
    }
    
  }

  if( park_status==6)
  {
    robot_movement(left,150);
    long lf_sensor=utlrasonic_LF.read(CM);
    long lb_sensor=ultrasonic_LB.read(CM);

    if( lf_sensor == lb_sensor) 
    {
      robot_stop();
      park_status =7 ; 
    }
  }

  if(park_status==7)
  {
    long forward_sensor =ultrasonic_front.read(CM);

    if(forward_sensor <=6) 
    {
      robot_stop();
      park_status=8;
    }
    else
    {
      robot_movement(forward,120);  
    }
  }

// vertical parking 
  if( park_status==10)
  {
    robot_movement(left,180);
    delay(500);
    robot_stop();
    park_status=7;
  }
}




void loop() {
  park();
}
