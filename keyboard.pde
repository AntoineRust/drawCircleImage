void setBuf() {
  String buf = "";
  for (int a = posInText + 1; a < typed.length(); a++) {
    buf += typed.charAt(a);
  }

  widthOfPos = constrain((width - (textWidth(typed))) / 2.0, 0, 100000000) + textWidth(typed) - textWidth(buf);
  if (textWidth(typed) + 12 > width) {
    widthOfPos += 5;
  }

  last = millis();
  on_off = true;
}

void keyPressed() {
  if (setting) {
    textSize(width / 20.0);
    if (keyCode == ENTER || keyCode == RETURN) {
      boolean point = false;
      name = "";
      type = "";

      for (int a = 0; a < typed.length(); a++) {
        if (typed.charAt(a) == '.') {
          if (point) {
            point = false;
            break;
          } else {
            point = true;
          }
        } else if (point) {
          type += typed.charAt(a);
        } else {
          name += typed.charAt(a);
        }
      }

      if (point) {
        img = loadImage(typed);
        imgCopy = loadImage(typed);
        String buf = typed;
        typed = "";
        for (int a = 0; a < buf.length(); a++) {
          if (buf.charAt(a) == '/') {
            typed = "";
          } else {
            typed += buf.charAt(a);
          }
        }
        newPic();
        doIt = true;
      }
    } else if (keyCode == BACKSPACE) {
      if (!typed.isEmpty()) {
        String buf = typed; 
        typed = ""; 
        for (int a = 0; a < buf.length(); a++) {
          if (a != posInText) {
            typed += buf.charAt(a);
          }
        }

        posInText = constrain(posInText - 1, -1, typed.length() - 1); 

        setBuf();
      }
    } else if (keyCode == DELETE) {
      if (!typed.isEmpty()) {
        String buf = typed; 
        typed = ""; 
        for (int a = 0; a < buf.length(); a++) {
          if (a != posInText + 1) {
            typed += buf.charAt(a);
          }
        }

        setBuf();
      }
    } else if (keyCode == LEFT) {
      posInText = constrain(posInText - 1, -1, typed.length() - 1); 

      setBuf();
    } else if (keyCode == RIGHT) {
      posInText = constrain(posInText + 1, -1, typed.length() - 1); 

      setBuf();
    } else if (key >= 32 & key <= 126 & typed.length() < 64) {
      if (posInText == typed.length() - 1) {
        typed += key;
      } else {
        String buf = typed; 
        typed = ""; 
        for (int a = 0; a < buf.length(); a++) {
          if (a == posInText + 1) {
            typed += key;
          }

          typed += buf.charAt(a);
        }
      }

      posInText = constrain(posInText + 1, -1, typed.length() - 1); 

      setBuf();
    }

    if (keyCode == UP) {
      ammTurn = constrain(ammTurn + 1, 0, 10);
      last = millis();
    }

    if (keyCode == DOWN) {
      ammTurn = constrain(ammTurn - 1, 0, 10);
      last = millis();
    }
  } else {
    if (doIt) {
      if (key == 'f') {
        if (fast) {
          fast = false; 
          frameRate(30);
        } else {
          fast = true; 
          frameRate(10000);
        }
      }

      if (key == 'i') {
        if (showImg) {
          showImg = false;
        } else {
          showImg = true;
        }
      }

      if (key == 'x') {
        if (filling) {
          filling = false;
        } else {
          filling = true;
        }
      }

      if (key == 'n') {
        surface.setSize(int(screenSize.y / 2), int(screenSize.y / 2));
        backCol = color(0);
        setting = true;
        showImg = true;
        pict = 0;
        scal = false;
        setBuf();
      }
    }
  }
}
