class Score {
  int points = 0;

  void addLinePoints(int nb) {
    points += level * nb * 10;
  }


  void display() {
    pushMatrix();
    translate(30, 60);

    //score
    fill(#DE9F16);
    text("score: ", 0, 0);
    fill(230, 230, 12);
    text(""+formatPoint(points), 0, txtSize + 10);
    
    popMatrix();

  }

  String formatPoint(int p) {
    String txt = "";
    int qq = int(p/1000000);
    if (qq > 0) {
      txt += qq + ",";
      p -= qq * 1000000;
    }

    qq = int(p/1000);
    if (txt != "") {
      if (qq == 0) {
        txt += "000";
      } else if (qq < 10) {
        txt += "00";
      } else if (qq < 100) {
        txt += "0";
      }
    }
    if (qq > 0) {
      txt += qq;
      p -= qq * 1000;
    }
    if (txt != "") {
      txt += ",";
    }

    if (txt != "") {
      if (p == 0) {
        txt += "000";
      } else if (p < 10) {
        txt += "00" + p;
      } else if (p < 100) {
        txt += "0" + p;
      } else {
        txt += p;
      }
    } else {
      txt += p;
    }
    return txt;
  }
}
