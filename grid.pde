class Grid {
  int [][] cells = new int[w][h];

  Grid() {
    for (int i = 0; i < w; i ++) {
      for (int j = 0; j < h; j ++) {
        cells[i][j] = -1;
      }
    }
  }

  Boolean isFree(int x, int y) {
    if (x > -1 && x < w && y > -1 && y < h) {
      return cells[x][y] == -1;
    } else if (y < 0) {
      return true;
    }
    return false;
  }

  Boolean pieceFits() {
    int x = piece.x;
    int y = piece.y;
    int[][] pos = piece.pos;
    Boolean pieceOneStepDownOk = true;
    int tmpx = pos[0][0]+x;
    int tmpy = pos[0][1]+y;
    if (tmpy >= h || !isFree(tmpx, tmpy)) {
      fit_sound.play();
      pieceOneStepDownOk = false;
     }
    return pieceOneStepDownOk;
  }

  void addPieceToGrid() {
    int x = piece.x;
    int y = piece.y;
    int[][] pos = piece.pos;
      if(pos[0][1]+y >= 0){
        cells[pos[0][0]+x][pos[0][1]+y] = piece.c;
      }else{
        gameOn = false;
        gameOver = true;
        return;
      }
    checkSame();
    
    
    goToNextPiece();
    checkSame();
    drawGrid();
    checkGame();
    
  }
  

  void checkSame() {
    int nb = 0;
    int mark_x = 0;
    int mark_y = 0;
    boolean same = false;
    
    // check horizontal
    for (int j = 0; j < h; j ++) {
      for (int i = 0; i < w; i++) {
        int c1 = cells[i][j];
        if ((i+2 < w) && (!isFree(i, j))) {
          if ((cells[i+1][j] == c1) &&
            (cells[i+2][j] == c1)) {
              int mark_num = 2;
              mark_x = i;
              mark_y = j;
              if ((i+3 < w) && (cells[i+3][j] == c1)) {
                mark_num = 3;
              }
              if ((i+4 < w) && (cells[i+4][j] == c1)) {
                mark_num = 4;
              }            
              nb = nb + mark_num - 1;
              same_sound.play();
              for (int k = mark_y; k > 0; k--) {
                for (int m = mark_x;  m <= mark_x + mark_num; m++) {
                  if (m==x1 && j == h-1) {
                    cells[x1][h-1] = -1;
                    checkGame();
                  }
                  if ((j+2 < h) && (cells[m][j+1] == c1) &&
                  (cells[m][j+2] == c1)) {       
                    cells[m][j+1] = cells[m][j];
                    cells[m][j+2] = cells[m][j+1];
                    checkGame();
                  }
                  cells[m][k] = cells[m][k-1];
                  cells[m][0] = -1;
                  checkGame();
              continue;
             }           
            }
           }
      }
      if ((j+2 < h) && (!isFree(i, j))) {
          if ((cells[i][j+1] == c1) &&
          (cells[i][j+2] == c1)) {
            same = true;
            mark_x = i;
            mark_y = j;         
      if (same) {
        nb++;
        same_sound.play();
        for (int k = mark_y; k < mark_y + 3; k++) {
          try{       
          cells[mark_x][k] = -1;
          checkGame();
          } catch(Exception e) {           
          }
        }
        for (int k = mark_y; k > 2; k--){
          cells[mark_x][k] = cells[mark_x][k-2];
          checkGame();
        }
     
      } 
      }
      }
      }
    }
    checkGame();
    deleteLines(nb);
    }
    
    
  Boolean checkWin() {
    if (isFree(x1, h-1)) {
      return true;
    }
    return false;
  }

  void deleteLines(int nb) {
    nbLines += nb;
    if (int(score.points / 100) > level) {
      goToNextLevel();
    }
    score.addLinePoints(nb);
  }

  void setToBottom() {
    int j = 0;
    for (j = 0; j < h; j ++) {
      if (!pieceFits()) {
        break;
      } else {
        piece.y++;
      }
    }
    piece.y--;
    delay(1500);
    addPieceToGrid();
  }

  void drawGrid() {
    stroke(150);
    pushMatrix();
    translate(160, 40);
    line(-10, 0, -10, h*q);

    for (int i = 0; i < w; i ++) {
      for (int j = 0; j < h; j ++) {
        if (cells[i][j] != -1) {
          image(cubes[cells[i][j]], i * q, j * q, 40, 40);
        }
      }
    }
    pick(x1, h-1);
    popMatrix();
  }
  
  void generate() {
     for (int i = 0; i < w; i ++) {
      for (int j = h * 1/2 ; j < h ; j ++) {
        int kind = int(random(0, 4));
        cells[i][j] = kind;
        image(cubes[kind], i * q, j * q, 40, 40);
      }
      checkSame();
    }
    checkSame();
  }

  
  void checkGame() {
    for (int i=0; i<w; i++) {
      if (!isFree(i, 0)) {
        gameOver = true;    
      }
      for (int j=0; j<h; j++) {
        if (!isFree(i, j) && isFree(i,j+1)) {
          cells[i][j] = -1;
        }
      } 
    }
    if (checkWin()) {
      gameWin = true;
    }
  }
  
  void pick(int x, int y) {
    stroke(#F8FC08);
    strokeWeight(5);
    if (cells[x][y] != -1) {
      image(cubes[cells[x][y]], x * q, y * q, 40, 40);
    }
    line(x*q, y*q, (x+1)*q, y*q);
    line(x*q, y*q, x*q, (y+1)*q);
    line((x+1)*q, y*q, (x+1)*q, (y+1)*q);
    line(x*q, (y+1)*q, (x+1)*q, (y+1)*q);
  }

}
