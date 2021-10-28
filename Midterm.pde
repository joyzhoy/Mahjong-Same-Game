import processing.sound.*;
SoundFile same_sound;
SoundFile win_sound;
SoundFile fit_sound;
SoundFile over_sound;

int w = 10;
int h = 10;
int q = 40;
int dt;
int currentTime;

PImage[] cubes;
PImage bg;
PImage bg1;
PImage win;
PImage over;

Grid grid;
Piece piece;
Piece nextPiece;
Pieces pieces;
Score score;
int level = 1;
int nbLines = 0;

int txtSize = 20;
int textColor = 0;
int x1;

Boolean gameOver = false;
Boolean gameOn = false;
Boolean gamePause = false;
Boolean gameWin = false;
Boolean help = false;

void setup()
{
  size(600, 480, P2D);
  textSize(30);
  cubes = new PImage[4];
  cubes[0] = loadImage("dong.png");
  cubes[1] = loadImage("nan.png");
  cubes[2] = loadImage("xi.png");
  cubes[3] = loadImage("bei.png");
  bg = loadImage("bg.png");
  bg1 = loadImage("bg1.png");
  win = loadImage("win.jpeg");
  over = loadImage("over.png");
  
  same_sound = new SoundFile(this, "same.wav");
  win_sound = new SoundFile(this, "win.wav");
  fit_sound = new SoundFile(this, "fit.wav");
  over_sound = new SoundFile(this, "over.wav");
}

void initialize() {
  nbLines = 0;
  dt = 1000;
  currentTime = millis();
  score = new Score();
  grid = new Grid();
  pieces = new Pieces();
  piece = new Piece(-2);
  nextPiece = new Piece(-2);
  grid.generate();
  score = new Score();
  level = 1;
  
  x1 = int(random(0, w)); 
  while (grid.isFree(x1,h-1)) {
    x1 = int(random(0, w));
  }
}

void draw()
{
  background(0);
  image(bg, 0, 0, 600, 480);
  if (grid != null) {
    grid.drawGrid();
    int now = millis();
    if (gameOn) {
      if (now - currentTime > dt) {
        currentTime = now;
        piece.oneStepDown();
      }
    }
    fill(#F8FC08);
    PFont f = createFont("", 20);
    textFont(f);
    text("P - PAUSE", 30, 360);
    text("H - HELP", 30, 400);
    
    PFont pixel = createFont("ARCADECLASSIC.TTF", 40);
    textFont(pixel);
    piece.display(false);
    score.display();
    fill(#DE9F16);
    text("Goal: ", 30, 200);
    if (grid.cells[x1][h-1] != -1) {
      image(cubes[grid.cells[x1][h-1]], 50, 220, 40, 40);
    }    
    stroke(#F8FC08);
    strokeWeight(5);
    line(50, 220, 90, 220);
    line(50, 220, 50, 260);
    line(90, 220, 90, 260);
    line(50, 260, 90, 260);
  }
  
  if (gameOver) {
     noStroke();
     background(255);
     fill(0);
     over.resize(600, 200);
     image(over, 0, 100);
     text("Press 'ENTER' to     restart.", 50, 400);
     over_sound.play(); 
     noLoop();
  }
  
  if (!gameOn) {
    image(bg1, 0, 0, 600, 480);
    noStroke();    
    fill(#A04C13);
    PFont f = createFont("", 30);
    textFont(f);
    text("MOVE LEFT", 70, 140);
    text("MOVE RIGHT", 70, 180);
    text("MOVE DOWN", 70, 220);
    text("PAUSE", 70, 260);
    text("HELP", 465, 390);
    text("EXIT", 500, 430);

    PFont pixel = createFont("ARCADECLASSIC.TTF", 40);
    textFont(pixel);
    text("A", 25, 140);
    text("D", 25, 180);
    text("S", 25, 220);
    text("P", 25, 260);
    text("H", 420, 390);
    text("ESC", 420, 430);
    
    fill(0);
    stroke(0);
    strokeWeight(3);
    line(20, 140, 50, 140);
    line(20, 115, 50, 115);
    line(20, 115, 20, 140);
    line(50, 115, 50, 140);
    
    line(20, 155, 50, 155);
    line(20, 180, 50, 180);
    line(20, 155, 20, 180);
    line(50, 155, 50, 180);   

    line(20, 195, 50, 195);
    line(20, 220, 50, 220);
    line(20, 195, 20, 220);
    line(50, 195, 50, 220); 
    
    line(20, 235, 50, 235);
    line(20, 260, 50, 260);
    line(20, 235, 20, 260);
    line(50, 235, 50, 260);    

    line(415, 390, 445, 390);
    line(415, 365, 445, 365);
    line(415, 365, 415, 390);
    line(445, 365, 445, 390);  
    
    line(415, 430, 490, 430);
    line(415, 405, 490, 405); 
    line(415, 405, 415, 430);
    line(490, 405, 490, 430);  
    
  }
  
  if (gameWin) {
     noStroke();
     image(win, 0, 0, 600, 480);
     fill(#E36917);
     text("Press 'ENTER' to    restart.", 30, 460);
     win_sound.amp(0.5);
     win_sound.play();
     noLoop();
  }
  
  if (help) {
    fill(#EAD0E4);
    rect(0, 0, 600, 480);
    fill(#E36917);
    PFont f = createFont("", 30);
    textFont(f);
    text("Match 3 or more cubes with", 40, 100);
    text("the same pattern to eliminate.", 40, 140);
    image(cubes[3], 60, 180, 50, 50);
    image(cubes[3], 110, 180, 50, 50);
    image(cubes[3], 160, 180, 50, 50);
    
    image(cubes[2], 280, 180, 50, 50);
    image(cubes[2], 330, 180, 50, 50);
    image(cubes[2], 380, 180, 50, 50);
    image(cubes[2], 430, 180, 50, 50);
    image(cubes[2], 480, 180, 50, 50);  
    
    image(cubes[1], 110, 250, 50, 50);
    image(cubes[1], 110, 300, 50, 50);
    image(cubes[1], 110, 350, 50, 50);
    
    image(cubes[0], 280, 250, 50, 50);
    image(cubes[0], 330, 250, 50, 50);
    image(cubes[0], 380, 250, 50, 50);
    image(cubes[0], 380, 300, 50, 50);
    image(cubes[0], 380, 350, 50, 50);
   }
}

void goToNextPiece() {
  piece = new Piece(nextPiece.kind);
  nextPiece = new Piece(-2);
}

void goToNextLevel() {
  level = 1 + int(nbLines / 100);
  dt *= .98;
}

void keyPressed() {
  if (gameOn) {
      piece.inputKey(keyCode);
  }
  if (keyCode == 80) {
    if (gameOn) {
      gamePause = !gamePause;
      
      if (gamePause) {
        fill(0, 60);
        rect(width/2 - 220, height/2 - 50, 450, 100, 20);
        fill(255);
        textSize(25);
        PFont f = createFont("", 30);
        textFont(f);
        stroke(0);
        text("Press  'P'  to restart the game", width/2 - 200, height/2);
        noLoop();
      } else if (!gamePause){
        loop();
      }
    }
    
  } else if (key == ENTER) {
    if (!gameOn || gameWin || gameOver) {
      initialize();
      gameWin = false;
      gameOver = false;
      gameOn = true;
      loop();
    }    
  } 
  
  if (keyCode == 72) {
    help = !help;
    if (gameOn) {
      gamePause = true;
    }
  }
}
