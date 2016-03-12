/*
These methods are used to send the appropriate signals to the 
L298n motor driver. The driver can control 2 DC motors, and 
each one has 3 correspoding control pins on the driver. Two of 
the pins are used to control the direction of the motor, while
one controls the speed of the motor using an analog voltage.
*/
int pin1 = 3; //right motor control 1
int pin2 = 4; //right motor control 2
int pin3 = 5; //left motor control 1
int pin4 = 6; //left motor control 2
int pwmL = 7;//pwm pins used to create an analog voltage for 
int pwmR = 2;//speed control

void motorSetup() {
  pinMode(pin1, OUTPUT); //motor driver pin initialization
  pinMode(pin2, OUTPUT);
  pinMode(pin3, OUTPUT);
  pinMode(pin4, OUTPUT);
  pinMode(pwmR, OUTPUT);
  pinMode(pwmL, OUTPUT);
}

void stopL(){//setting both left control pins low makes it stop
 digitalWrite(pin3, LOW);
 digitalWrite(pin4, LOW); 
}

void stopR(){//setting both right control pins low makes it stop
 digitalWrite(pin1, LOW);
 digitalWrite(pin2, LOW); 
}

void stopA(){
 stopL();
 stopR(); 
}

void forwardR(int spd){
  digitalWrite(pin1, LOW);
  digitalWrite(pin2, HIGH);
  analogWrite(pwmR, spd); 
}

void forwardL(int spd){
 digitalWrite(pin3, LOW);
 digitalWrite(pin4, HIGH);
 analogWrite(pwmL, spd); 
}

void forward(int spd){
 forwardR(spd);
 forwardL(spd); 
}

void reverseR(int spd){
  digitalWrite(pin1, HIGH);
  digitalWrite(pin2, LOW);
  analogWrite(pwmR, spd);
}

void reverseL(int spd){
  digitalWrite(pin3, HIGH);
  digitalWrite(pin4, LOW);
  analogWrite(pwmL, spd); 
}

void reverse(int spd){
  reverseR(spd);
  reverseL(spd); 
}
