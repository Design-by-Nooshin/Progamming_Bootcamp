size(1000, 1000);
noStroke();
background(255);

int x=500; //// x & y are the center position of the flower
int y=500;
int hieght= int(random(100, 300));
int length= int(random(350, 700));
int H = int(random(length));
colorMode(HSB, length); //// changing color mode

//stem
fill(H, 150, length);
rect(x-25, y+100, 50, length);


// petal
H = int(random(length));
int i=length;
fill(H, 150, length);
ellipse(x, y, i, hieght);
ellipse(x, y, hieght, i);


//center of the flower
H = int(random(length));
i=hieght;
fill(H, 150, length);
ellipse(x, y, i, i);

i-=30;
fill(H, 150-20, length-20);
ellipse(x, y, i, i);

i-=30;
fill(H, 150-40, length-40);
ellipse(x, y, i, i);

i-=30;
fill(H, 150-60, length-60);
ellipse(x, y, i, i);

i-=30;
fill(H, 150-80, length-80);
ellipse(x, y, i, i);
