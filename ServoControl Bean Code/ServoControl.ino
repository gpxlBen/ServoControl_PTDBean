// ServoContrl
// by Ben Harraway - http://www.gourmetpixel.com
// A simple demonsration for the LightBlue Bean by Punch Through Design
// This sketch looks for input into the scratch and moves a servo based on the scratch value
// This example code is in the public domain.

#include <Servo.h> 
 
Servo myservo;  // create servo object to control a servo 
  
void setup() 
{ 
  myservo.attach(3);  // attaches the servo on pin 9 to the servo object 
} 
 
 
void loop() 
{   
    uint16_t number = Bean.readScratchNumber(1);
    myservo.write(number);    
    Bean.sleep(100);
}
