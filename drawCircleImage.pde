import drop.*;

SDrop drop;
ArrayList<circle> circs;
float strokeW = 2;
float scroll = 0;
float widthOfPos = 0;
int diffCol = 50;//the minimal value of the r, g or b value to qualify
int rez = 4320;
int ammTurn = 1;//new circle by turn
int posInText = 0;
int maxLoop = 5000;
int last = millis();
int pict = 0;
boolean scal = false;
boolean filling = true;//fill the circle
boolean doIt = true;
boolean fast = true;
boolean showImg = true;
boolean showCir = true;
boolean uniCol = false;
boolean grayTone = false;//picture in black and white
boolean InversCol = false;//inverse color of the picture
boolean unWhite = false;//replace the pur white with black
boolean fluid = false;
boolean oneByOne = true;//doesn't make a new circle until the last one can't grow anymore
boolean setting = true;
boolean on_off = true;//for blinking things
color backCol = color(0);
PImage imgCopy;
PImage img;
IVector screenSize = new IVector(int(1920), int(1080));

String typed = "";
String name = "";
String type = "";

void settings() {
  screenSize = new IVector(int(displayWidth * 0.9), int(displayHeight * 0.9));
  size(int(screenSize.y / 2), int(screenSize.y / 2));
}

void setup() {
  if (fast) {
    frameRate(10000);
  } else {
    frameRate(30);
  }

  textSize(width / 20.0);
  posInText = typed.length() - 1;

  setBuf();

  drop = new SDrop(this);
}

void draw() {
  if (scal) {
    scale(float(rez) / float(img.pixelWidth));
  }

  background(backCol);

  if (setting) {
    float textS = width / 20.0;
    rectMode(CENTER);
    textSize(textS);
    fill(100);
    stroke(155);
    strokeWeight(5);
    rect(width / 2, height / 8 + textS / 4, constrain(textWidth(typed) + (textS / 2), textS, width - 5), textS * 1.25);

    fill(255);
    textAlign(LEFT, CENTER);
    textSize(textS);
    push();
    if (textWidth(typed) + 12 > width) {
      translate(5, 0);
    }

    text(typed, constrain(((width - textWidth(typed) - (textS / 16)) / 2.0), textS / 10, width) - scroll, height / 8);

    if (on_off) {
      noStroke();
      rect(widthOfPos - scroll, height / 8 + textS / 4, textS / 8, textS);
    }
    pop();

    if (abs(millis() - last) > 500) {
      if (on_off) {
        on_off = false;
      } else {
        on_off = true;
      }
      
      last = millis();
    }

    stroke(155);
    noFill();
    rect(width / 2, height / 8 + textS / 4, constrain(textWidth(typed) + (textS / 2), textS, width - 5), textS * 1.25);

    /////////////////////////////////////////////////////

    seter(fast, 1, "FAST");
    seter(uniCol, 2, "COL");
    seter(grayTone, 3, "B&W");
    seter(unWhite, 4, "BACK");
    seter(InversCol, 5, "INV");
    seter(filling, 6, "FILL");
    seter(showImg, 7, "IMG");
    seter(oneByOne, 8, "WAIT");

    /////////////////////////////////////////////////////

    if (!oneByOne) {
      slider(ammTurn, 10, 0, "NEW");
      ammTurn = insSlid(ammTurn, 10, 0);
    }

    slider(maxLoop, 10000, 1, "LOOP");
    maxLoop = insSlid(maxLoop, 10000, 1);

    slider(rez, 8640, 2, "REZ");
    rez = insSlid(rez, 8640, 2);

    slider(diffCol, 255, 3, "DIFF");
    diffCol = insSlid(diffCol, 255, 3);

    /////////////////////////////////////////////////////
  } else {/////////////////////////////////////////////////////
    img.loadPixels();
    if (doIt) {
      if (oneByOne) {
        if (circs.size() == 0) {
          circs.add(new circle(circs.size()));
        } else if (!circs.get(circs.size() - 1).check) {
          circs.add(new circle(circs.size()));
        }
      } else {
        if (ammTurn >= 1) {
          for (int a = 0; a < ammTurn; a++) {
            if (doIt) {
              circs.add(new circle(circs.size()));
            } else {
              break;
            }
          }
        } else if (frameCount % (1 / ammTurn) == 0) {
          circs.add(new circle(circs.size()));
        }
      }
    }

    if (showCir) {
      for (circle c : circs) {
        c.canGrow();
      }

      for (circle c : circs) {
        c.grow();
        c.display();
      }
    }

    if (showImg) {
      image(imgCopy, 0, 0);
    }

    if (doIt) {
      if (abs(millis() - last) < 2000) {
        float adj = (1000.0 - abs(millis() - last)) / 1000.0;
        fill(color(255.0 - red(backCol), 255.0 - green(backCol), 255.0 - blue(backCol), 255.0 * adj));
        textAlign(RIGHT, TOP);
        textSize(width / 50.0);

        if (ammTurn >= 1) {
          text(int(ammTurn), width - (width / 100), height / 100.0);
        } else {
          noStroke();
          text(1, width - (width / 100.0), height / 100.0);
          rectMode(CENTER);
          rect(width - (width / 65.0), height / 100.0 + width / 45.0, width / 50.0, width / 500.0);
          text(int(1 / ammTurn), width - (width / 100.0), height / 100.0 + width / 50.0);
        }
      }
    } else if (pict < 2) {
      if (scal) {
        loadPixels();
        pict++;
        saveFrame("output/" + name + "Pointilism" + pict + ".png");
        if (pict == 2) {
          surface.setSize(img.pixelWidth, img.pixelHeight);
          scal = false;
          backCol = color(255);
          frameRate(60);
          fast = false;

          fluid = true;
          last = millis();
        }

        if (filling) {
          filling = false;
        } else {
          filling = true;
        }
      } else {
        scal = true;
        showImg = false;
        filling = true;
        surface.setSize(rez, int((float(rez) / float(width)) * float(height)));
      }
    } else if (backCol != color(0)) {
      float adj = (1000.0 - abs(millis() - last)) / 1000.0;
      backCol = color(255.0 * adj);
      fluid = true;
    } else if (fluid & abs(millis() - last) < 3000) {
      if (!showImg) {
        last = millis();
        showImg = true;
        showCir = false;

        img = loadImage("output/" + name + "Pointilism" + 1 + ".png");
        img.resize(width, height);
        img.loadPixels();

        imgCopy = createImage(width, height, ARGB);
        imgCopy.loadPixels();

        for (int a = 0; a < width * height; a++) {
          imgCopy.pixels[a] = img.pixels[a];
        }

        imgCopy.updatePixels();
      }

      imgCopy.loadPixels();

      for (int c = 0; c < width * height; c++) {
        imgCopy.pixels[c] = color(red(imgCopy.pixels[c]), green(imgCopy.pixels[c]), blue(imgCopy.pixels[c]), constrain(1.0 - (constrain(millis() - last, 0, millis()) / 2500.0), 0, 1.0) * 255.0);
      }

      imgCopy.updatePixels();
    } else {
      showCir = true;
      fast = true; 
      surface.setSize(int(screenSize.y / 2), int(screenSize.y / 2)); 
      backCol = color(0); 
      setting = true; 
      showImg = true; 
      fluid = false; 
      pict = 0; 
      scal = false; 
      setBuf();
    }
  }
}

void dropEvent(DropEvent theDropEvent) {
  if (setting) {
    String buf = theDropEvent.toString(); 
    typed = ""; 
    for (int a = 0; a < buf.length(); a++) {
      if (buf.charAt(a) == '/') {
        typed = "";
      } else {
        typed += buf.charAt(a);
      }
    }
    println(typed); 

    if (theDropEvent.isImage()) {
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
        img = loadImage(theDropEvent.toString()); 
        imgCopy = loadImage(theDropEvent.toString()); 
        newPic(); 
        doIt = true;
      }
    }
  }
}
