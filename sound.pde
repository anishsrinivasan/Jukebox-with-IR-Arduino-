import processing.serial.*;
Serial myPort;  // Create object from Serial class
String inBuffer;// Data received from the serial port
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