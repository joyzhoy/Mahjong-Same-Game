class Piece {

  final int[] colors = {0, 1, 2, 3};

  final int[][] pos;
  int x = int(w/2);
  int y = 0;
  int kind;
  int c;

  Piece(int k) {
    if (k == -2) {
      kind = int(random(0, 4));
    } else {
      kind = k;
    }
    c = colors[kind];
    pos = pieces.pos[kind];
  }

  void display(Boolean still) {
    stroke(250);
    //fill(c);
    pushMatrix();
    if (!still) {
      translate(160, 40);
      translate(x*q, y*q);
    }
    image(cubes[c], pos[0][0] * q, pos[0][1] * q, 40, 40);
    popMatrix();
  }

  // returns true if the piece can go one step down
  void oneStepDown() {
    y += 1;
    if(!grid.pieceFits()){
      piece.y -= 1;
      grid.addPieceToGrid();
    }
  }

  // try to go one step left
  void oneStepLeft() {
    x --;
  }

  // try to go one step right
  void oneStepRight() {
    x ++;
  }

  void goToBottom() {
    grid.setToBottom();
  }

  void inputKey(int k) {
    switch(k) {
    case 65:
      x --;
      if(grid.pieceFits()){
      }else {
         x++; 
      }
      break;
    case 68:
      x ++;
      if(grid.pieceFits()){
      }else{
         x--; 
      }
      break;
    case 83:
      oneStepDown();
      break;
    }
  }

}



class Pieces {
  int[][][] pos = new int [4][1][2];
  
  Pieces() {
    pos[0][0][0] = -1;
    pos[0][0][1] = 0;
    pos[1][0][0] = -1;
    pos[1][0][1] = 0;
    pos[2][0][0] = -1;
    pos[2][0][1] = 0;
    pos[3][0][0] = -1;
    pos[3][0][1] = 0;
  }
}
