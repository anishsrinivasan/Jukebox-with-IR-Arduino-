# **Jukebox-with-IR-Arduino-**
An Arduino with a jukebox functionality where you can play sounds/music with an IR remote. The signals received from the remote is processed by the IR Remote and decoded by the Arduino which displays in the Serial Monitor is captured by Processing Software and play sounds in the PC.

**Requirements**

 - Arduino 
 - Breadboard 
 - 16X2 LCD Display 
 - Jumpwires 
 - PC with Arduino and Processing Softwares

**Prerequisites**

You might need to download Minim Libraries for Processing to play sounds. Google is your friend. 

To find the IR Signal Codes for your remote

 - Download IR Libraries from Arduino 
 - Place them in the Arduino/Libraries/
 - Open Arduino and File->Examples->IRRemote->IR Demo
 - Upload it to Arduino and run
 - Open Serial Monitor and start pressing the keys in your remote.
 - Signals from the remote will be diplayed in the Serial Monitor and replace these codes in the main program. 

**Setup** 

 - Connect the Circuit with LCD Display and IR Receiver.
 - Download the files and open *jukebox.ino* with Arduino.  
 - Upload the file to your board.
 - Make sure you create a folder named *Data* in the same folder as *sound.pde* and copy the sound files to the *Data* directory.  
 - Open *sound.pde* using Processing and click run.
 - Voila.

**Source Code - Arduino** :

```
#include "IRremote.h"
int receiver = 9;
#include <LiquidCrystal.h>
char ch;
int Contrast=15;
// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);
/*-----( Declare Constants )-----*/
 // pin 1 of IR receiver to Arduino digital pin 11

/*-----( Declare objects )-----*/
IRrecv irrecv(receiver);           // create instance of 'irrecv'
decode_results results;            // create instance of 'decode_results'
/*-----( Declare Variables )-----*/


void setup()   /*----( SETUP: RUNS ONCE )----*/
{
  analogWrite(6,Contrast);
  // set up the LCD's number of columns and rows: 
  lcd.begin(16, 2);
  lcd.print("Juke BOX");
  analogWrite(9,28836);
  Serial.begin(9600);
  Serial.println("IR Receiver Raw Data + Button Decode Test");
  irrecv.enableIRIn(); // Start the receiver

}/*--(end setup )---*/


void loop()   /*----( LOOP: RUNS CONSTANTLY )----*/
{
  if (irrecv.decode(&results)) // have we received an IR signal?

  {
//    Serial.println(results.value, HEX);  UN Comment to see raw values
    translateIR(); 
    irrecv.resume(); // receive the next value
  }  
}/* --(end main loop )-- */

/*-----( Declare User-written Functions )-----*/
void translateIR() // takes action based on IR code received

// describing Car MP3 IR codes 

{

  switch(results.value)

  {

  case 0x1FE48B:  
  lcd.setCursor(0,1);
      lcd.print("Power ON        "); 
    break;

  case 0x1FEE01F:  
    lcd.setCursor(0,1);
      lcd.print("Waaazzzzzzzzuup?");
Serial.write(1);
    break;

  case 0x1FE50AF:  
    lcd.setCursor(0,1);
      lcd.print("How you doin?   ");
      Serial.write(2);
    break;

  case 0x1FED827:  
  lcd.setCursor(0,1);
      lcd.print("Knock Knock     ");
      Serial.write(3);
    break;

  case 0x1FEF807:  
    lcd.setCursor(0,1);
      lcd.print("Challenge Accepted");
      Serial.write(4);
    break;


  default: 
    Serial.println(" other button   ");

  }

  delay(500);


} //END translateIR



/* ( THE END ) */

```
**Source Code - Processing** : 

```
import processing.serial.*;
Serial myPort;  // Create object from Serial class
import ddf.minim.*;
 int val1=0;
Minim minim;
AudioPlayer song1;
AudioPlayer song2;
AudioPlayer song3;
AudioPlayer song4;
void setup()
{
  // I know that the first port in the serial list on my mac
  // is Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  size(100, 100);
 
  minim = new Minim(this);
 
  // this loads mysong.wav from the data folder
  song1 = minim.loadFile("1.mp3");
  song2 = minim.loadFile("2.mp3");
  song3 = minim.loadFile("3.mp3");
  song4 = minim.loadFile("4.mp3");
  
 
}

void serialEvent (Serial myPort) {
  // get the byte:
  int inByte = myPort.read();
  // print it:
  println(inByte);
  val1=inByte;
}
void draw()
{println(val1);
 if(val1==1)
 { song2.pause();
   song3.pause();
   song4.pause();
   song2.rewind();
   song3.rewind();
   song4.rewind();
   song1.play();
}
 if(val1==2)
 { song1.pause();
   song3.pause();
   song4.pause();
   song1.rewind();
   song3.rewind();
   song4.rewind();
   song2.play();
}
 if(val1==3)
 { song1.pause();
   song2.pause();
   song4.pause();
   song2.rewind();
   song4.rewind();
  song1.rewind();
   song3.play();
}
if(val1==4)
 { song1.pause();
   song2.pause();
   song3.pause();
   song2.rewind();
  song1.rewind();
  song3.rewind();
   song4.play();
}
}

```
----------


Sources 

http://engineeringlearning.blogspot.in/2013/10/interfacing-lcd-without-potentiometer.html
