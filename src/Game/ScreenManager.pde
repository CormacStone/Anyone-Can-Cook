char screen = 's';   // s = start, m = menu, t = settings, p = play, u = pause, g = game over, a = app stats
Button btnStart, btnMenu, btnSettings, btnBack, btnPause;

void setup() {
  size(600, 400);

  // Example buttons for practice starter
  btnStart    = new Button("Go to Menu", 220, 150, 160, 50);
  btnMenu = new Button("Menu", 220, 250, 150, 50);
  btnSettings = new Button("Settings", 220, 200, 150, 50);
  btnPause = new Button("Pause", 220,200,150,50);
}

void draw() {
  background(150);
  switch(screen) {
  case 's':
    drawStart();
    break;
  case 'm':
    drawMenu();
    break;
  case 'i':
    drawSettings();
    break;
  case 'p':
    drawPause();
    break;
  }
}

void mousePressed() {
  switch(screen) {
  case 's':
    if (btnStart.clicked()) {
      screen = 'm';
    }
    break;
  case 'm':
    if (btnMenu.clicked()) {
      screen = 'i';
    }
    break;
  case 'i':
    if (btnSettings.clicked()) {
      screen = 'p';
    }
    break;
  case 'p':
    if (btnPause.clicked()) {
      screen = 's';
    }
    break;
  }
}

void drawStart() {
  background(100, 160, 200);
  textAlign(CENTER);
  textSize(32);
  text("START SCREEN", width/2, 50);
  btnStart.display();
  btnMenu.display();
}

void drawMenu() {
  background(120, 200, 140);
  textSize(32);
  text("MENU SCREEN", width/2, 50);
  btnMenu.display();
}

void drawSettings() {
  background(200, 150, 120);
  textSize(32);
  text("SETTINGS", width/2, 50);
  btnSettings.display();
}

void drawPlay() {
  background(255);
  textSize(32);
  text("PAUSE", width/2, 50);
  btnPause.display();
}


void drawPause() {
  background(255);
  textSize(32);
  text("PAUSE", width/2, 50);
  btnPause.display();
}

void drawGameOver() {
  background(255);
  text("GAME OVER SCREEN (fill this in)", 200, 200);
}

void drawStats() {
  background(255);
  text("STATS SCREEN (fill this in)", 200, 200);
}
