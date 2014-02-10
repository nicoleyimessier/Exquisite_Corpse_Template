import spacebrew.*;

// Spacebrew stuff
String server = "sandbox.spacebrew.cc";
String name   = "ExquisiteJoselyn";
String desc   = "Some stuff!";

Spacebrew sb;
// App Size: you should decide on a width and height
// for your group
int appWidth  = 1280;
int appHeight = 720;

// EC stuff
//turn these back to false - and change your time jos!!
int corpseStarted   = 0;
boolean bDrawing    = false;
boolean bNeedToClear = false;

//Joselyn's stuff
int numFrames = 13;  // The number of frames in the animation
int frame = 0;
PImage[] images = new PImage[numFrames];
PImage star, star4, fonzie, mouth, donuts; 
float x,x2; 
float y,y2; 
int i = 1;
int rotate;
float offset = 0;
float easing = 0.05;

//end Joselyn's stuff

  // image variables timmy
  PImage cloud_one;
  PImage cloud_two;
  PImage cloud_three;
  PImage timmy;

  //starting cloud co-ordinates
  int yPos_one = 0;
  float xPos_one;
  int yPos_two = 300;
  float xPos_two;
  int yPos_three =200;
  float xPos_three;
  int yPos_four =400;
  float xPos_four;

  //starting timmy co-ordinates
  int timmy_pos;
  int timmy_input_speed = -1;


void setup(){
  bDrawing = true;
  size( appWidth, appHeight );
  
  sb = new Spacebrew(this);
  sb.addPublish("doneExquisite", "boolean", false);
  sb.addSubscribe("startExquisite", "boolean");

  // add any of your own subscribers here!
  sb.addSubscribe( "remote_speed_timmy", "boolean" );
  sb.addSubscribe("pressButtonYes", "boolean");
  
  sb.connect( server, name, desc );

  
  //Joselyn's stuff
  frameRate(10);
  x = random(850, 900);
  y = random(-30, 300); 
 star4 = loadImage("star3.jpg"); 
  star = loadImage("star.jpg"); 
 fonzie = loadImage("fonzie.jpg"); 
 int g = 1; 
  images[0]  = loadImage("donut1.png");
  images[1]  = loadImage("donut2.png"); 
  images[2]  = loadImage("donut6.png");
  images[3]  = loadImage("donut3.png"); 
  images[4]  = loadImage("donut5.png");
  images[5]  = loadImage("donut1.png"); 
  images[6]  = loadImage("donut4.png");
  images[7]  = loadImage("donut3.png"); 
  images[8]  = loadImage("donut2.png");
  images[9]  = loadImage("donut5.png"); 
  images[10] = loadImage("donut1.png");
  images[11] = loadImage("donut5.png"); 
  images[12] = loadImage("donut6.png");
  donuts = loadImage("donuts.gif"); 

    //timmy init position
    timmy_pos = height;
  
    //starting cloud x positions
    xPos_one = width/3.0;
    xPos_two = width/3.0 + 200;
    xPos_three = width/3.0 + 100;
    xPos_four = width/3.0 + 250;
  
    // load images
    cloud_one = loadImage("clouds_03.png");
    cloud_two = loadImage("clouds_06.png");
    cloud_three = loadImage("clouds_10.png");
    timmy = loadImage("Timmy_sized.png");
}

void draw(){
  // this will make it only render to screen when in EC draw mode
  if (!bDrawing) return;
  // blank out your background once
  if ( bNeedToClear ){
    bNeedToClear = false;
  }
  
  // ---- start person 1 ---- //
  if ( millis() - corpseStarted < 10000 ){
    println(corpseStarted);
    //noFill();
    stroke(255);
    rect(0,0, width / 3.0, height );
    fill(255);
  
  // ---- start person 2 ---- //
  } else if ( millis() - corpseStarted < 20000 ){
    println("made it to second person");
    stroke(255);
    fill(93,196,232);
    rect(width / 3.0,0, width / 3.0, height );
    //load cloud images
    image(cloud_one, xPos_one,yPos_one, 121, 81);
    image(cloud_two, xPos_two ,yPos_two);
    image(cloud_three, xPos_three,yPos_three);
    image(cloud_two, xPos_four,yPos_four);
    image(timmy, width/3.0+30, timmy_pos);
  
  //timmy's movement
  if(timmy_pos > -400) {
     timmy_pos -=  timmy_input_speed;
  }
  
  //movement of clouds and speed
  if(yPos_one <= height || yPos_two <= height || yPos_three <= height || yPos_four <= height ) {
    yPos_one += 5;
    yPos_two += 5;
    yPos_three += 5;
    yPos_four += 5;
  }
  
  //randomisations of where clouds next turn up
  if (yPos_one == height) {
    yPos_one = 0;
    xPos_one = random(width/3.0, (width/3.0+width/3.0-132));
  }
  if (yPos_two == height) {
    yPos_two = 0;
    xPos_two = random(width/3.0, (width/3.0+width/3.0-132));
  }
  if (yPos_three == height) {
    yPos_three = 0;
    xPos_three = random(width/3.0, (width/3.0+width/3.0-132));
  }
  if (yPos_four == height) {
    yPos_four = 0;
    xPos_four = random(width/3.0, (width/3.0+width/3.0-132));
  }
  
  // ---- start p erson 3 ---- //
  } else if (millis() - corpseStarted < 30000 ){
 image(star, width*2.0/3.0, 0, width/3.0, height);
  println(x); 
   image(images[int(random(i))], random(850, 1000), random(-20, 300)); 
   if (rotate==1){
     i+=1; 
     if (i >= 12){
    i = int(random(1, 12)); 
   } 
     //image(star4, width*2.0/3.0, 0, width/3.0, height);
    float dx = (mouseX-star4.width/2) - offset;   
    tint(255, 127);
    image(star4,width*2.0/3.0, 0, width/3.0, height); 
   }
   }
 //end Joselyn's stuff 
 
  // ---- we're done! ---- //
  else {
    sb.send("doneExquisite", true);
    bDrawing = false;
  }
  }

void onBooleanMessage( String name, boolean value ){
  if ( name.equals("startExquisite") ){
    //start the exquisite corpse process!
    bDrawing = true;
    corpseStarted = millis();
    bNeedToClear = true;

  if (name.equals("pressButtonYes") && value == true){
    rotate = 1; 
    println(value); 
  }
  
  //Timmy's input
  if (name.equals("remote_speed_timmy")) {
    if(timmy_pos > -400) {
        if(value == true) {
            timmy_input_speed = 9;
        } 
        if(value == false) {
            timmy_input_speed = -1;
    }
  }
  
}
}
  }
  

void onRangeMessage( String name, int value ){
  
}

void onStringMessage( String name, String value ){
}


