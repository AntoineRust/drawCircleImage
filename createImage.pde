void newPic() {
  setPic();
  modify();

  textSize(width / 20.0);

  setBuf();

  img.loadPixels();
  circs = new ArrayList<circle>();

  setting = false;
}

void setPic() {
  if (img.pixelWidth > screenSize.x || img.pixelHeight > screenSize.y) {
    float scale;
    if ((float(screenSize.x) / float(img.pixelWidth)) < (float(screenSize.y) / float(img.pixelHeight))) {
      scale = (float(screenSize.x) / float(img.pixelWidth));
    } else {
      scale = (float(screenSize.y) / float(img.pixelHeight));
    }

    float x = float(img.pixelWidth) * scale;
    float y = float(img.pixelHeight) * scale;

    img.resize(int(x), int(y));
    imgCopy.resize(int(x), int(y));
  }

  surface.setSize(img.pixelWidth, img.pixelHeight);
}

void modify() {
  img.loadPixels();
  imgCopy.loadPixels();
  if (InversCol) {
    for (int a = 0; a < img.pixelWidth * img.pixelHeight; a++) {    
      img.pixels[a] = color(255.0 - red(imgCopy.pixels[a]), 255.0 - green(imgCopy.pixels[a]), 255.0 - blue(imgCopy.pixels[a]));
    }
  }

  if (unWhite) {
    for (int a = 0; a < img.pixelWidth * img.pixelHeight; a++) {
      if (red(imgCopy.pixels[a]) >= diffCol & green(imgCopy.pixels[a]) >= diffCol & blue(imgCopy.pixels[a]) >= diffCol) {
        img.pixels[a] = color(0);
      }
    }
  }

  if (grayTone) {
    for (int a = 0; a < img.pixelWidth * img.pixelHeight; a++) {    
      if (imgCopy.pixels[a] != color(0) & imgCopy.pixels[a] != color(255)) {
        img.pixels[a] = color((red(imgCopy.pixels[a]) + green(imgCopy.pixels[a]) + blue(imgCopy.pixels[a])) / 3.0);
      }
    }
  }
  img.updatePixels();

  img.loadPixels();
  imgCopy.loadPixels();
  for (int a = 0; a < img.pixelWidth * img.pixelHeight; a++) {
    imgCopy.pixels[a] = color(red(img.pixels[a]), green(img.pixels[a]), blue(img.pixels[a]), 100);
  }
}
