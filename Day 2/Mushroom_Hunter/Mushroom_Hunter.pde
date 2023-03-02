int screensizeX=300;
int screensizeY=300;
int size_of_mushroom=30;
int size_of_circle=50;
int score=0;
int temp=0;
int level=1;
int random_color;

int x_mushroom=int(random(screensizeX));
int y_mushroom=0;

int x_user=screensizeX/2;
int y_user=screensizeY-size_of_circle;

int yumyum;

void settings() {
  size(screensizeX, screensizeY);
}

void setup() {
  colorMode(HSB, 360, 100, 100);
  rectMode(CENTER);
  ellipseMode(CENTER);
  noStroke();
  fill(20, 50, 100); //initial color
  textSize(20);
  textMode(CENTER);
}


void draw() {

  background(0, 0, 100);

  // the mushroom
  fill(40, 50, 100);
  rect(x_mushroom, y_mushroom, size_of_mushroom, size_of_mushroom);
  fill(0, 80, 100);
  arc(x_mushroom, y_mushroom-5, size_of_mushroom+20, size_of_mushroom+20, PI, 2*PI, CHORD);
  fill(0, 0, 100);
  ellipse(x_mushroom-2, y_mushroom-20, (size_of_mushroom*0.3), (size_of_mushroom*0.3));
  ellipse(x_mushroom+8, y_mushroom-16, (size_of_mushroom*0.2), (size_of_mushroom*0.2));
  ellipse(x_mushroom-12, y_mushroom-19, (size_of_mushroom*0.2), (size_of_mushroom*0.2));

  // the user
  fill(random_color, 50, 100);
  ellipse(x_user, y_user, size_of_circle, size_of_circle);

  if (yumyum>0) { //if a mushroom is eaten
    yumyum--;
    fill(0, 0, 0, yumyum*10); /// the opacity of text will decrease by time so it will disappear smoothly
    textAlign(CENTER);
    text("Yummy!", x_user, y_user+45);

    fill(0, 0, 0); //happy eyes
    noFill();
    stroke(0, 0, 0);
    strokeWeight(3);
    arc(x_user-10, y_user-5, size_of_circle*0.2, size_of_circle*0.2, PI, 2*PI);
    arc(x_user+10, y_user-5, size_of_circle*0.2, size_of_circle*0.2, PI, 2*PI);
    noStroke();
  } else { //eyes open
    fill(0, 0, 0);
    ellipse(x_user-10, y_user-5, size_of_circle*0.2, size_of_circle*0.2);
    ellipse(x_user+10, y_user-5, size_of_circle*0.2, size_of_circle*0.2);

    fill(0, 0, 100);
    ellipse(x_user-10, y_user-7, size_of_circle*0.07, size_of_circle*0.07);
    ellipse(x_user+10, y_user-7, size_of_circle*0.07, size_of_circle*0.07);
  }

  //move the mushroom and creates new mushrooms when they reach the end
  if (y_mushroom<screensizeY) {
    y_mushroom+=level; //the higher the level, the faster the mushroom goes
  } else {
    y_mushroom=0;
    x_mushroom=int(random(screensizeX));
    temp=0;
  }

  //finds out when the mushroom and user collide
  if (x_user-size_of_circle<x_mushroom && x_mushroom<x_user+size_of_circle && y_user-size_of_circle<y_mushroom && y_mushroom<y_user+size_of_circle && temp==0 )
  {
    score++;
    level++;
    temp=1;
    println(score);
    random_color=int(random(360)); // change the color after each collide
    yumyum=30;
  }
}

void keyPressed() { //movement of he circle
  if (key =='a')
  {
    x_user-=20;
  }
  if (key =='d')
  {
    x_user+=20;
  }
  if (key =='w')
  {
    y_user-=20;
  }
  if (key =='s')
  {
    y_user+=20;
  }
}
