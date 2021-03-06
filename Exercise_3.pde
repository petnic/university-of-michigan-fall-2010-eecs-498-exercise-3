//EECS 498 - 007
//September 30th, 2010
//Exercise 3
//Dylan Box
//Nicholas Peters
//Joshua Winters

//Write Variables
int color = 0;
int flexRead = 0;
int flexWrite = 0;
int brightnessWrite = 0;
int redWrite = 0;
int greenWrite = 0;
int blueWrite = 0;
int dimRedWrite = 0;
int dimGreenWrite = 0;
int dimBlueWrite = 0;

void setup() {
  Serial.begin(9600);
  
  pinMode(6, OUTPUT); //Speaker
  pinMode(9, OUTPUT); //Red
  pinMode(10, OUTPUT); //Green
  pinMode(11, OUTPUT); //Blue
}

void loop()
{
    //Read Variables
    int buttonRead = 0;
    int colorRead = 0;
    int colorWrite = 0;
    int speakerWrite = 0;
    
    //Read Value of Push Button
    buttonRead = analogRead(2);
    
    //Read Value of Potentiometer
    colorRead = analogRead(0);
    
    //Map Read Value to Write Value
    //analogRead values go from 0 to 1023, analogWrite values from 0 to 255
    colorWrite = map(colorRead, 0, 1023, 0, 255);
    
    //Advance Selected Color via Read Value of Push Button
    if(buttonRead == LOW) {
       color = color + 1;
       if(color > 2) {
         color = 0; 
       }
       buttonRead = analogRead(2);
       while(buttonRead == LOW) {
         buttonRead = analogRead(2);
       }
    }
    
    //Determine Which Color to Update
    switch(color) {
      case 0:
        redWrite = colorWrite;
        break;
      case 1:
        greenWrite = colorWrite;
        break;
      case 2:
        blueWrite = colorWrite;
        break;
      default:
        redWrite = colorWrite;
        break;  
    }
    
    //Dim Brightness via Flex Sensor
    flexRead = analogRead(3);
    flexWrite = map(flexRead, 100, 350, 0, 100);
    dimRedWrite = ((flexWrite * redWrite) / 100);
    dimGreenWrite = ((flexWrite * greenWrite) / 100);
    dimBlueWrite = ((flexWrite * blueWrite) / 100);
    
    //Write Color
    analogWrite(9, dimRedWrite);
    analogWrite(10, dimGreenWrite);
    analogWrite(11, dimBlueWrite);
    
    //Brightness to Sound
    brightnessWrite = map((dimRedWrite + dimBlueWrite + dimGreenWrite), 0, (255 * 3), 0, 255);
    analogWrite(6, brightnessWrite);
}

