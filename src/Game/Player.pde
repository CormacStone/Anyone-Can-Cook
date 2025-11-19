//Cormac Stone, Trace Kinghorn
class Player {
  float x, y;
  float w, h;
  float xspeed;
  float vy; // vertical velocity
  PImage remmy;
  boolean inWater = false;


  Player(float x, float y) {
    this(x, y, 20, 20, 3);
  }

  Player(float x, float y, float w, float h, float xspeed) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.xspeed = xspeed;
    this.vy = 0;
  }

  void display() {
    fill(255, 0, 0);
    rect(x, y, w, h);
    remmy = loadImage("remmeigh3-3.png");
    image(remmy, x-40, y-20);
  }
  void handleMovement() {

    // ----------------------------------------------------
    // CHECK IF PLAYER IS IN WATER
    // ----------------------------------------------------
    int midCol = int((x + w/2) / map.cellSize);
    int midRow = int((y + h/2) / map.cellSize);

    int tile = map.getTile(midCol, midRow);
    inWater = (tile == 2);  // water tile


    // ----------------------------------------------------
    // CONSTANTS FOR WATER PHYSICS
    // ----------------------------------------------------
    float waterGravity = gravity * 0.2;  // fall slower
    float waterXspeed = xspeed * 0.5;   // move slower
    float swimForce = -1.5;             // weaker upward movement
    float maxWaterFallSpeed = 2;        // cap sinking speed


    // ----------------------------------------------------
    // 1. HORIZONTAL MOVEMENT
    // ----------------------------------------------------
    float horizontalSpeed = inWater ? waterXspeed : xspeed;
    float newX = x;

    if (l) newX -= horizontalSpeed;
    if (r) newX += horizontalSpeed;


    // --- Horizontal collision ---
    int top = int(y / map.cellSize);
    int bottom = int((y + h - 1) / map.cellSize);

    if (newX > x) {
      int col = int((newX + w - 1) / map.cellSize);
      for (int j = top; j <= bottom; j++) {
        if (map.isSolid(col, j)) {
          newX = col * map.cellSize - w;
          break;
        }
      }
    } else if (newX < x) {
      int col = int(newX / map.cellSize);
      for (int j = top; j <= bottom; j++) {
        if (map.isSolid(col, j)) {
          newX = (col + 1) * map.cellSize;
          break;
        }
      }
    }

    x = newX;


    // ----------------------------------------------------
    // 2. APPLY GRAVITY or WATER BUOYANCY
    // ----------------------------------------------------
    if (inWater) {
      vy += waterGravity;
      if (vy > maxWaterFallSpeed) vy = maxWaterFallSpeed;
    } else {
      if (!onGround) vy += gravity;
    }


    // ----------------------------------------------------
    // 3. VERTICAL MOVEMENT
    // ----------------------------------------------------
    float newY = y + vy;

    int left = int(x / map.cellSize);
    int right = int((x + w - 1) / map.cellSize);

    onGround = false;

    if (vy > 0) {  // FALLING
      int row = int((newY + h) / map.cellSize);
      for (int c = left; c <= right; c++) {
        if (map.isSolid(c, row)) {
          newY = row * map.cellSize - h;
          vy = 0;
          onGround = true;
          break;
        }
      }
    } else if (vy < 0) { // MOVING UPWARDS
      int row = int(newY / map.cellSize);
      for (int c = left; c <= right; c++) {
        if (map.isSolid(c, row)) {
          newY = (row + 1) * map.cellSize;
          vy = 0;
          break;
        }
      }
    }

    y = newY;


    // ----------------------------------------------------
    // 4. JUMP / SWIM
    // ----------------------------------------------------
    if (!inWater) {
      // normal jump
      if (u && onGround) {
        vy = jumpForce;
        onGround = false;
      }
    } else {
      // swimming upward
      if (u) vy += swimForce;  // gentle upward swim
    }


    // ----------------------------------------------------
    // 5. NEXT MAP (tile = 5)
    // ----------------------------------------------------
    int leftTile = map.getTile(int(x / map.cellSize), midRow);
    int rightTile = map.getTile(int((x + w - 1) / map.cellSize), midRow);

    if (leftTile == 5) {
      loadNextMap("left");
      return;
    }
    if (rightTile == 5) {
      loadNextMap("right");
      return;
    }
  }



  void loadNextMap(String e) {
    if (e=="left") {
      currentLevel--;
      e = "done";
    }
    if (e == "right") {
      currentLevel++;
      e = "done";
    }
    String nextMapFile = currentLevel + ".csv";
    println("Loading next map: " + nextMapFile);

    map = new Map(nextMapFile);

    // Reset player to start position
    player.x = 50;
    player.y = 50;
    player.vy = 0;

    // Reset camera too
    camX = 0;
    camY = 0;
  }
}
