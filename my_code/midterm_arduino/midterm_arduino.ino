int mode = 0;   //values coming from processing sketch
int rSpeed = 0;
int lSpeed = 0;

void setup() {
  Serial.begin(9600); //start serial
  motorSetup();       //initialize motor driver pins
}

void loop() {
  Serial.write(7); //let processing know you are ready to recieve values
  delay(10); 
  if(Serial.available() > 6){ //If we have at least 6 bytes(only really need three)
     mode = Serial.read();    //first byte read is the drive mode(direction of the motors)
     rSpeed = Serial.read();  //second byte read is the right motor speed
     lSpeed = Serial.read();  //third byte read is the left motor speed
  }
  setMotors();  
}

/*
This method takes the data read from the processing sketch, and uses sends the appropriate
signals to the motor driver using the motor driver methods
*/
void setMotors(){ 
 if(mode == 1){//both motors forwards
  forwardR(rSpeed);
  forwardL(lSpeed);
 } 
 else if(mode == 2){//right forward left reverse
  forwardR(rSpeed);
  reverseL(lSpeed); 
 }
 else if(mode == 3){//left forward right reverse
  forwardL(lSpeed);
  reverseR(rSpeed); 
 }
 else if(mode == 4){//both motors going reverse
  reverseR(rSpeed);
  reverseL(lSpeed); 
 } else{ //stop both motors
   stopL();
   stopR(); 
 }
  
}
