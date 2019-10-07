int[] tunnels = new int[500];
float h = random(100, 400), h2 = random(100, 400); 
float xSpd, tunnelGap, w;
float x = 200;
float x2 = 500;
int xB = 50;
float yB = height/2;
float ballVelocity = 0;
float gravity = .8;
int score = 0;
int gameState = 0;

void setup() {
  size(600, 600);
  background(255);
  rectMode(CORNERS);
  textAlign(CENTER);
  String[] highscore = loadStrings("HighScore");
}

void draw() {
  if (gameState==0) {
    startScreen();
  }
  if (gameState==1) {
    tunnels();
    ball();
    score();
    checkHit();
  } 
  if (gameState==2) {
    gameOver();
    restart();
  }
}

void startScreen() {
  background(255);
  fill(0);
  textSize(55);
  text("Click to Play", width/2, height/2);
  if (mousePressed && gameState == 0) {
    gameState = 1;
  }

  textSize(32);
  String[] highscore = loadStrings("HighScore");
  text("Highscore: " + highscore[0], width/2, height/2 + 50);
}


void tunnels() {
  background(255);
  fill(0);
  xSpd = 2;
  tunnelGap = 150;
  w = 50;
  x = x - xSpd;
  x2 = x2 - xSpd;
  rect(x, 0, x+w, h);
  rect(x, h+200, x+w, 1000);
  rect(x2, 0, x2+w, h2);
  rect(x2, h2+200, x2+w, 1000);
  if (x<0-w) {
    h = random(100, 400);
    x = width - w;
  }
  if (x2<0-w) {
    h2 = random(100, 400);
    x2 = width - w;
  }
}

void ball() {
  ballVelocity += gravity;
  yB += ballVelocity;
  ellipse(xB, yB, 25, 25);
}

void keyPressed() {
  if (key==' ') {
    ballVelocity = -15;
  }
}

void checkHit() {
  if (xB >= x && xB <= x + w && yB <= h) {
    gameState = 2;
  }
  if (xB >= x && xB <= x + w && yB >= h+200) {
    gameState = 2;
  }
  if (xB >= x2 && xB <= x2 + w && yB <= h2) {
    gameState = 2;
  }
  if (xB >= x2 && xB <= x2 + w && yB >= h2+200) {
    gameState = 2;
  }
  if (yB <= 0) {
    gameState = 2;
  }
  if (yB >= height) {
    gameState = 2;
  }
}

void score() {
  if (xB == x) {
    score = score+1;
  }
  if (xB == x2) {
    score = score+1;
  }
  fill(0);
  textSize(30);
  text(score, 25, 25);
}

void gameOver() {
  background(255);
  textSize(40);
  text("Click to Play Again", width/2, 50);
  textSize(80);
  text("GAME OVER", width/2, height/2);
  textSize(40);
  text("Score:" + score, width/2, height/2 + 50);
  String[] highscore = loadStrings("HighScore");
  String HighScore = str(score);
  String[] HighScores = split(HighScore, ' ');
  int newHighscore = int(highscore[0]);
  if (newHighscore < score) {
    saveStrings("HighScore", HighScores);
  }
  if (newHighscore < score) {
    saveStrings("HighScore", HighScores);
  }
}

void restart() {
  xB = 50;
  yB = height/2;
  ballVelocity = 0;
  x = 200;
  x2 = 500;
  score = 0;
  if(mousePressed && gameState == 2) {
    gameState = 1;
  }
}
