/*
This program creates a simple interface used to control the speed of two 
dc motors which are hooked up to an arduino. values are sent to the arduino
via bluetooth connection throught the serial ports on the pc and arduino
*/
import processing.serial.*;
Serial myPort;

int driveMode = 0; //wheel direction variable
int lSlide = 200;//y-coordinates of the sliders
int mSlide = 200;
int rSlide = 200; 

int lSpeed = 0; //left speed variable
int rSpeed = 0; //right speed variable

boolean rF = true; //is right going forward
boolean lF = true; //is left going forward

void setup(){
  printArray(Serial.list()); //print the available serial ports to the console
  myPort = new Serial(this, "COM15", 9600); //establish connection with the bluetooth chip
  
  size(600, 400); //size of the gui
  frameRate(60);  //frame rate(how fast the draw method will run in frames per second)
  rectMode(RADIUS); //set rectangle mode to radius
}

/*this method is similar to the loop() method in the arduino language, it continuously loops
  unless specified to exit or if the program is stopped by the user.
*/
void draw(){
  drawBackground(); 
  drawSliders();
  setValues();
  sendValues();
    
}

//this method runs if the program is stopped by the user
void stop(){
  rSpeed = 0;
  lSpeed = 0;
  driveMode = 0;
  sendValues();
}

//prepare the values for being sent to the arduino
void setValues(){
  if(lSlide <= 200){ //if you want left forward
   lF = true;
   lSpeed = 200 - lSlide;
  }else{  //left is backwards
   lF = false;
   lSpeed = lSlide - 200;
  }
  
  if(rSlide < 200){ //right is going forwards
    rF = true;
    rSpeed = 200 - rSlide;
  }else{   //right is backwards
    rF = false;
    rSpeed = rSlide - 200;
  }
  
  if(rF && lF){ //both forward
   driveMode = 1; 
  } 
  else if(rF && !lF){ //right forward left back
   driveMode = 2; 
  }
  else if(lF && !rF){ //left forward right back
   driveMode = 3;
  }else{ //both back
    driveMode = 4;
  }
}

void drawBackground(){
  background(0,0,255);  //make background solid blue
  stroke(0,255,200);    //left and right boundary rect color
  strokeWeight(8);      //rect line thickness
  fill(0,0);            //make rectangles opaque
  rect(100,200,96,196);
  rect(500,200,96,196); //right boundary rectangle
  stroke(0,255,120);    //middle rectangle color
  rect(300,200,96,196); //middle boundary rectangle
  stroke(255,0,0);      //middle line color
  line(0,200,600,200);  //middle line
}

void drawSliders(){
  fill(255,255);    //make them white 
  strokeWeight(1);  //make their outline thin
  stroke(0,0,0);    //make their outline black
  rect(100,lSlide,92,30); //draw the sliders at their specified positions
  rect(300,mSlide,92,30);
  rect(500,rSlide,92,30);
}

void sendValues(){
  if(myPort.available()>0){    //if there is data available to read from the arduino
    if(myPort.read() == 7){    //if the arduino has said it is ready to recieve values
      myPort.write(driveMode); //wheel direction value
      myPort.write(rSpeed);    //right wheel speed
      myPort.write(lSpeed);    //left wheel speed 
      delay(10);
    }
  }
  println("m:"+driveMode+" l:"+lSpeed+" r:"+rSpeed);//print data to console
}

void mousePressed(){ //this method immediately runs if one of the mouse buttons is pressed
   if(mouseX < 200){       //if mouse is in the left slider area
       lSlide = mouseY; 
    }
    else if(mouseX < 400){ // if the mouse is in the middle slider area
      lSlide = mouseY; 
      mSlide = mouseY;
      rSlide = mouseY;
    }
    else{                  //the mouse is in the right slider area
       rSlide = mouseY;
    }
}