//Cormac Stone
boolean l, r, u;  // movement keys
boolean onGround;
float gravity = 0.4;
float jumpForce = -12;
float camX = 0;
float camY = 0;
float camSmooth = 0.1;  // smaller = smoother
int currentLevel = 1;
char screen = 'p';
boolean jumpPressed = false;
boolean jumpLastFrame = false;
Player player;
Map map;
Enemy guy;
Menu menu;
Button btnStart, btnPause, btnMenu, btnSettings, btnSave, btnPlay;

void setup() {
  size(600, 600);
  //fullScreen();
  btnStart = new Button("Start", 220, 400, 140, 50);
  btnSettings = new Button("Settings", 220, 360, 160, 50);
  btnSave = new Button("Save", 220, 300, 160, 50);
  btnPlay = new Button("Unpause", 220, 240, 160, 50);
  menu = new Menu();
  map = new Map(1 + ".csv");   // loads CSV or defaults if missing
  player = new Player(100, 100, 18, 80, 3); // (x, y, w, h, xspeed)
  guy = new Enemy(250, 250, 50, 50); // (x,y,w,h)
}

void draw() {
  switch(screen) {
  case 's':
    menu.startScreen();
    break;
  case 'p':
    background(255);
    // --- Smooth camera follow ---
    float targetCamX = constrain(player.x - width / 2, 0, map.cols * map.cellSize - width);
    float targetCamY = constrain(player.y - height / 2, 0, map.rows * map.cellSize - height);
    camX = lerp(camX, targetCamX, camSmooth);
    camY = lerp(camY, targetCamY, camSmooth);

    // --- Apply camera ---
    pushMatrix();
    translate(-camX, -camY);
    map.drawMap();
    player.display();
    jumpPressed = u && !jumpLastFrame;
    jumpLastFrame = u;
    player.handleMovement();
    guy.display();
    guy.move();
    popMatrix();
    //println(player.x, player.y);
    break;
  case 'z':
    menu.pauseScreen();
    break;
  case 'e':
    menu.endScreen();
    noLoop();
    break;
  }
}

void keyPressed() {
  if (key == 'a' || keyCode == 37) l = true;
  if (key == 'd' || keyCode == 39) r = true;
  if (key == 'w' || key == ' ' || keyCode == 38) u = true;
  if (key == 'e') menu.display();
  if (key == '-') screen = 'e';
  if (key == 'z') screen = 'z';
}

void keyReleased() {
  if (key == 'a'|| keyCode == 37) l = false;
  if (key == 'd'|| keyCode == 39) r = false;
  if (key == 'w' || key == ' '|| keyCode == 38) u = false;
}

void mousePressed() {
  switch(screen) {
  case 's':
    if (btnStart.clicked()) {
      screen = 'p';
    }
  break;
  case 'z':
    if(btnPlay.clicked()){
      screen = 'p';
    }
  }
}
