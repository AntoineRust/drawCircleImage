void mouseWheel(MouseEvent event) {
  scroll = constrain(scroll + event.getCount(), 0, constrain((textWidth(typed + "|") + 10) - width, 0, 100000000.0));
}

void mousePressed() {
  if (setting) {
    fast = ins(fast, 1);
    uniCol = ins(uniCol, 2);
    grayTone = ins(grayTone, 3);
    unWhite = ins(unWhite, 4);
    InversCol = ins(InversCol, 5);
    filling = ins(filling, 6);
    showImg = ins(showImg, 7);
    oneByOne = ins(oneByOne, 8);

    if (fast) {
      frameRate(10000);
    } else {
      frameRate(30);
    }
  }
}

void seter(boolean bool, int p, String na) {
  noFill();
  textSize(width / 25);
  ellipseMode(CENTER);
  if (bool) {
    fill(100);
  }
  if (sqrt(sq(mouseX - ((width / 9) * p)) + sq(mouseY - ((height / 8) * 3))) <= width / 26) {
    fill(50);
    if (bool) {
      fill(150);
    }
  }
  ellipse((width / 9) * p, ((height / 8) * 3), width / 16, width / 16);
  fill(255);
  textAlign(CENTER, CENTER);
  text(na, (width / 9) * p, (height / 16) * 5.0);
}

boolean ins(boolean bool, int p) {
  if (sqrt(sq(mouseX - ((width / 9) * p)) + sq(mouseY - ((height / 8) * 3))) <= width / 26) {
    if (bool) {
      bool = false;
    } else {
      bool = true;
    }
  }

  return bool;
}

void slider(int numb, int max, int p, String na) {
  textSize(width / 25);
  textAlign(CENTER, CENTER);
  fill(75);
  noStroke();
  rectMode(CENTER);
  rect(width / 2, (height / 8) * (4.25 + p), (width / 4) * 3, height / 100);
  fill(255);
  ellipse((width / 8) + ((width / 4) * 3) * (float(numb) / float(max)), (height / 8) * (4.25 + p), height / 40, height / 40);
  text(numb, width / 2, (height / 8) * (3.9 + p));
  text(na, width / 16, (height / 8) * (4.2 + p));
}

int insSlid(int numb, int max, int p) {
  if (mousePressed) {
    if (mouseY >= (height / 8) * (4.25 + p) - height / 40 & mouseY <= (height / 8) * (4.25 + p) + height / 40 & mouseX >= width / 16 & mouseX <= (width / 16) * 15) {
      numb = int(constrain(((mouseX - (width / 8.0)) / ((width / 4.0) * 3.0)) * max, 0, max));
    }
  }

  return numb;
}
