//Naomi Hiebert
//October 2017

//-----------------------------Configuration------------------------------------

//Constants for colors
final color CTrue =  #00FF00; //"True" block color
final color CFalse = #000000; //"False" block color
final color CBar =   #888888; //Progress bar color
final color CWarn =  #FF0000; //Progress bar color if colors will change soon

//Chance of a block being colored CTrue is oddsNumerator/oddsDenominator.
//Otherwise, it will be colored CFalse. For proper performance, assign
//values such that oddsDenominator > oddsNumerator > 0
final int oddsNumerator =   1;
final int oddsDenominator = 4;

//Framerate, and frames to re-randomize the colors. Progress bar is updated
//according to fRate, and changes color from CBar to CWarn when 1 second
//remains until colors will be re-randomized.
//Seconds per update = fReRandomize/fRate
final int fRate = 30;
final int fReRandomize = 300;

//----------------------------------Code-----------------------------------------

//globals for holding state
int fCounter; //counts frames since color update
color C1;
color C2;
color C3;
color C4;

void setup()
{  
 //Processing-specific setup
 fullScreen();
 noStroke();
 frameRate(fRate);
 rectMode(CORNER);
 
 //Initialize global variables to falsy values because good practices
 C1 = CFalse;
 C2 = CFalse;
 C3 = CFalse;
 C4 = CFalse;
 
 //will randomize on first frame; avoids having to duplicate code
 fCounter = fReRandomize; 
}

void draw()
{  
 //Choose new random colors if necessary
 if(fCounter >= fReRandomize)
 {
   C1 = myRandomColor();
   C2 = myRandomColor();
   C3 = myRandomColor();
   C4 = myRandomColor();
   fCounter = 0;
 }

 //Draw the randomly-colored blocks
 fill(C1);
 rect(0, 0, width/2, height/2);
 fill(C2);
 rect(width/2, 0, width/2, height/2);
 fill(C3);
 rect(0, height/2, width/2, height/2);
 fill(C4);
 rect(width/2, height/2, width/2, height/2);
 
 //Color the progress bar differently if colors will change soon
 if(fCounter + fRate >= fReRandomize)
 {
  fill(CWarn);
 }
 else
 {
  fill(CBar); 
 }
 //Draw the progress bar
 rect(0, 9*(height/20), (fCounter*width)/(fReRandomize -1), height/10);
 
 //increment the counter
 fCounter++;
 
}

//returns CTrue with probability oddsNumerator/oddsDenominator
//otherwise returns CFalse
color myRandomColor()
{
  return (int(random(oddsDenominator)) < oddsNumerator)? CTrue : CFalse;
}