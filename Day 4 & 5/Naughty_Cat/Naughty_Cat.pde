// Tip: you need to install the sound library
// Go to sketch -> import library -> manage libraries -> search "sound" -> install the one whose author is "the processing foundation"


int screensizeX=400;
int screensizeY=400;
int new_plant_is_placed=0;
int number_of_plants=200;
int[] x_plant     = new int[number_of_plants];
int[] y_plant     = new int[number_of_plants];
int[] plant_state = new int[number_of_plants];
int x_cat=screensizeX/2;
int y_cat=screensizeY/2;
int score_farmer=0;
int score_cat=0;
int game_state = 0;
int start_playing_song=0;
int winner_score=10;

import processing.sound.*;
SoundFile doop;
SoundFile cat_eating;
SoundFile water;
SoundFile score;
SoundFile start_music;

void settings() {
  size(screensizeX, screensizeY);
}

void setup() {
  colorMode(HSB, 360, 100, 100);
  background_farm();
  rectMode(CENTER);
  doop = new SoundFile(this, "ball_tap.wav");
  cat_eating = new SoundFile(this, "cat_eating.wav");
  water = new SoundFile(this, "water.wav");
  score = new SoundFile(this, "score.wav");
  start_music = new SoundFile(this, "start_music.mp3");
}

void draw()
{
  switch(game_state) {
  case 0:
    start_page();
    break;
  case 1:
    play_game();
    break;
  case 2:
    cat_wins();
    break;
  case 3:
    farmer_wins();
    break;
  }
}


void start_page()
{
  background(102, 41, 88);
  if (start_playing_song==0) {
    println("test");
    start_music.play();
    start_playing_song=1;
  }

  if (keyPressed==true)
  {
    game_state=1;
  }

  textAlign(CENTER);
  textSize(30);
  text("Press any key to start!", screensizeX/2, screensizeY-100);
  textAlign(CENTER);
  textSize(50);
  text("Naughty Cat", screensizeX/2, 80);
  draw_cat(screensizeX/2-50, int(random(screensizeY/2-50, screensizeY/2+5-50)));
}

void cat_wins() {
  background_farm();
  textAlign(CENTER);
  textSize(30);
  text("Naughty cat Won!!", screensizeX/2, screensizeY-100);
  if (keyPressed==true)
  {
    game_state=1;
    score_farmer=0;
    score_cat=0;
  }
}

void farmer_wins() {
  background_farm();
  textAlign(CENTER);
  textSize(30);
  text("Farmer Won!!", screensizeX/2, screensizeY-100);
  if (keyPressed==true)
  {
    game_state=1;
    score_farmer=0;
    score_cat=0;
  }
}

void play_game() {
  start_music.stop();
  background_farm();
  fill(0, 0, 0);
  textAlign(LEFT);
  textSize(20);
  text("Farmer's Score: "+score_farmer, 20, 50);
  textAlign(RIGHT);
  text("Cats's Score: "+score_cat, screensizeX-20, 50);

  draw_cat(x_cat, y_cat);

  ////// realise when cat caught the flowers
  for (int i=0; i<x_plant.length; i++) {
    if (x_cat<x_plant[i]+30 && x_cat>x_plant[i]-30 && y_cat<y_plant[i]+30 && y_cat>y_plant[i]-30 && plant_state[i]<4)
    {
      plant_state[i]=5;
    }
  }


  for (int i=0; i<x_plant.length; i++) //////// Determines the plant states: seed, under soil, sprout (small plant), and growm plant
  {
    if (plant_state[i]==0)
    {
      draw_seed(x_plant[i], y_plant[i]);
    } else if (plant_state[i]==1)
    {
      draw_soil(x_plant[i], y_plant[i]);
    } else if (plant_state[i]==2)
    {
      draw_small_plant(x_plant[i], y_plant[i]);
    } else if (plant_state[i]==3)
    {
      draw_grown_plant(x_plant[i], y_plant[i]);
    } else if (plant_state[i]==4)
    {
      score_farmer++;
      score.play();
      plant_state[i]=6; //This stage does not exist
      if (score_farmer==winner_score)
      {
        game_state=3;
      }
    } else if (plant_state[i]==5)
    {
      score_cat++;
      cat_eating.play();
      plant_state[i]=6; //This stage does not exist
      if (score_cat==winner_score)
      {
        game_state=2;
      }
    }
  }
}

void mousePressed() {
  if (mouseButton == LEFT) { //we are in seed mode
    doop.play();
    shift_this_array(x_plant);
    shift_this_array(y_plant);
    shift_this_array(plant_state);
    x_plant[0]=mouseX;
    y_plant[0]=mouseY;
    plant_state[0]=0;
  } else if (mouseButton == RIGHT) {
    // here goes the water mode
    for (int i=0; i<x_plant.length; i++)
    {
      if (mouseX<x_plant[i]+20 && mouseX>x_plant[i]-20 && mouseY<y_plant[i]+20 && mouseY>y_plant[i]-20)
      {
        plant_state[i]++;
        water.play();
      }
    }
  }
}

void keyPressed() { //// For moving the cat
  int steps=30;

  if (key =='a')
  {
    x_cat-=steps;
  }
  if (key =='d')
  {
    x_cat+=steps;
  }
  if (key =='w')
  {
    y_cat-=steps;
  }
  if (key =='s')
  {
    y_cat+=steps;
  }
}

void shift_this_array(int[] the_array)
{
  for (int m = the_array.length-1; m > 0; m--) {
    the_array[m] = the_array[m-1];
  }
}


////////////////////////////////////
// Here are the drawing functions //
////////////////////////////////////

void draw_seed(int x_seed, int y_seed)
{
  noStroke();
  fill(27, 47, 38);
  ellipse(x_seed, y_seed, 20, 20);
  triangle(x_seed-10, y_seed-2, x_seed+10, y_seed-2, x_seed, y_seed-23);
}

void draw_soil(int x_soil, int y_soil)
{
  noFill();
  stroke(27, 47, 38);
  strokeWeight(2);
  arc(x_soil-10, y_soil, 20, 20, PI, 2*PI, OPEN);
  arc(x_soil+10, y_soil, 20, 20, PI, 2*PI, OPEN);
}

void draw_small_plant(int x, int y)
{
  draw_soil(x, y);
  stroke(103, 54, 63);
  line(x, y, x, y-30);
  noStroke();
  fill(103, 54, 63);
  ellipse(x, y-40, 15, 25);
}

void draw_grown_plant(int x, int y)
{
  draw_soil(x, y);
  stroke(103, 54, 63);
  line(x, y, x, y-50);
  noStroke();
  fill(int(random(315, 360)), 63, 93);
  ellipse(x, y-50, 15, 40);
  ellipse(x, y-50, 40, 15);
  fill(52, 63, 93); //center is yellow
  ellipse(x, y-50, 15, 15);
}

void draw_cat(int x, int y) {
  noStroke();
  fill(0, 0, 90); //the gray foot
  ellipse(x+75, y+75, 20, 40);
  fill(0, 0, 100); //the whole body
  ellipse(x, y, 60, 50);
  triangle(x-30, y-5, x-20, y-40, x-10, y-20);
  triangle(x+10, y-20, x+20, y-40, x+30, y-5);
  rect(x+50, y+40, 120, 70);
  ellipse(x, y+75, 20, 40);
  ellipse(x+25, y+75, 20, 40);
  ellipse(x+100, y+75, 20, 40);
  ellipse(x+100, y-5, 25, 60); //tail
  fill(0, 0, 0);
  ellipse(x-12, y-5, 10, 10); //eyes
  ellipse(x+12, y-5, 10, 10); //eyes
}

void background_farm()
{
  background(36, 33, 88);
  //background(112, 52, 75);
}
