public class circle {
  IVector pos = new IVector();
  PVector acc = new PVector(0, 0);
  int rad = 1;
  color col;
  boolean check = true;//if it is going to get inside an other thing it became false
  int n;//n is the position of the circle in the ArrayList

  circle(int num) {
    n = num;

    int looped = 0;
    do {
      looped++;
      pos.random2D(0, img.pixelWidth, 0, img.pixelHeight);
      check = false;

      if (n == 0) {
        if (!hit() & !badCol()) {
          check = true;
        }
      } else {
        boolean buf = true;
        for (int a = 0; a < circs.size(); a++) {
          if (a != n) {
            if (inside(circs.get(a)) || hit() || badCol()) {
              buf = false;
              break;
            }
          }
        }
        check = buf;
      }
    } while (!check & looped <= maxLoop);

    if (looped > maxLoop) {
      doIt = false;
      println("finish");
    }

    col = color(red(img.pixels[pos.x + (pos.y * img.pixelWidth)]), green(img.pixels[pos.x + (pos.y * img.pixelWidth)]), blue(img.pixels[pos.x + (pos.y * img.pixelWidth)]));
  }

  void display() {
    fill(col);
    if (!filling) {
      noFill();
    }
    stroke(col);
    strokeWeight(strokeW);

    circle(pos.x, pos.y, rad * 2);
  }

  void grow() {
    if (check) {
      rad ++;
    }
  }

  boolean inside(circle c) {//return if both circle are inside each other
    return (sqrt(sq(pos.x - c.pos.x) + sq(pos.y - c.pos.y)) <= (c.rad + rad + (strokeW * 2)));
  }

  boolean hit() {//return if the circle hit the side of the window
    return (((pos.x + rad) >= (img.pixelWidth - (strokeW / 2.0))) || ((pos.x - rad) < (strokeW / 2.0)) || ((pos.y + rad) >= (img.pixelHeight - (strokeW / 2.0))) || ((pos.y - rad) < (strokeW / 2.0)));
  }

  boolean badCol() {//return if the pixel its in is of the color drawCol
    boolean bad = false;
    color colBuf = img.pixels[pos.x + (pos.y * img.pixelWidth)];
    if (red(colBuf) < diffCol & green(colBuf) < diffCol & blue(colBuf) < diffCol) {
      bad = true;
    }

    if (!bad & rad > 1) {
      for (float angle = 0; angle < TWO_PI; angle += (PI / (rad * 2.0))) {
        if (int(pos.x + (cos(angle) * (rad + strokeW))) >= 0 & int(pos.x + (cos(angle) * (rad + strokeW))) < img.pixelWidth & int(pos.y - (sin(angle) * (rad + strokeW))) >= 0 & int(pos.y - (sin(angle) * (rad + strokeW))) < img.pixelHeight) {
          colBuf = img.pixels[int(pos.x + (cos(angle) * (rad + strokeW))) + (int(pos.y - (sin(angle) * (rad + strokeW))) * img.pixelWidth)];
          if (red(colBuf) < diffCol & green(colBuf) < diffCol & blue(colBuf) < diffCol & !uniCol) {
            bad = true;
            break;
          } else if (uniCol & red(colBuf) > red(col) + (diffCol / 2.0) || uniCol & red(colBuf) < red(col) - (diffCol / 2.0) ||
            uniCol & green(colBuf) > green(col) + (diffCol / 2.0) || uniCol & green(colBuf) < green(col) - (diffCol / 2.0) ||
            uniCol & blue(colBuf) > blue(col) + (diffCol / 2.0) || uniCol & blue(colBuf) < blue(col) - (diffCol / 2.0)) {
            bad = true;
            break;
          }
        }
      }
    }

    return bad;
  }

  boolean canGrow() {
    if (check) {
      if (hit() || badCol()) {
        check = false;
      }

      if (check) {
        for (int a = 0; a < circs.size(); a++) {
          if (!check) {
            break;
          }

          if (a != n) {
            if (inside(circs.get(a))) {
              check = false;
            }
          }
        }
      }
    }

    return check;
  }
}
