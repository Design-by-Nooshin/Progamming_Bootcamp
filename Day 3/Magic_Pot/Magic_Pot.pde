int screensizeX=600;
int screensizeY=600;

void settings() {
  size(screensizeX, screensizeY);
}

void setup() {
  colorMode(HSB, 360, 100, 100);
  background(0, 0, 100);
  rectMode(CENTER);
  drawTheGlass(); //Just draws the blue glass
}


void drawTheGlass()
{
  fill(196, 14, 93);
  noStroke();
  rect(screensizeX/2, screensizeY/2+100, 400, 400);
  arc(screensizeX/2, screensizeY/2-100, 400, 350, PI, 2*PI, CHORD);
}


void draw() {
  magicPot(screensizeX/2, screensizeY, 400, 100); //execute the magic pot
}


void drawFlower(int x_flower, int y_flower, int w_petal, int h_petal)  //This function will draw the flowers
{
  noFill();
  strokeWeight(4);
  stroke(int(random(80, 160)), 50, 90);
  bezier(screensizeX/2, screensizeY, screensizeX/2, screensizeY-150, x_flower, y_flower, x_flower, y_flower); //This is the stem of the flowers

  if (y_flower<screensizeY/4) //Here I defined the zones which will result in different color for flowers in different zones
  {
    fill(int(random(120, 160)), 70, 100);
    println("green");
  } else if (screensizeY/4<y_flower && screensizeY/2>y_flower)
  {
    fill(int(random(80, 120)), 70, 100);
    println("yellow");
  } else if (screensizeY/2<y_flower && 3*screensizeY/4>y_flower)
  {
    fill(int(random(40, 80)), 70, 100);
    println("orange");
  } else
  {
    fill(int(random(40)), 70, 100);
    println("red");
  }

  ellipse(x_flower, y_flower, w_petal, h_petal);  //the flower is drawn
}

void magicPot(int x_center, int y_center, int x_dim, int y_dim) //This function draws the magic pot
{
  //stroke(int(random(20,50)), 50, 100);
  for (int x=x_center-x_dim/2; x<x_center+x_dim/2; x++)
  {
    for (int y=y_center-y_dim/2; y<y_center+y_dim/2; y++)
    {
      stroke(int(random(10, 60)), 50, 90);  // I confined the hue to brownish colors
      point(x, y); // The pot consists of points with different colors
    }
  }
}

void mousePressed() {
  drawFlower(mouseX, mouseY, 50, 50);  //If the user clicks, draw a flower
}
