//Cormac Stone, Trace Kinghorn
class Player {
  float x, y;
  float w, h;
  float xspeed;
  float vy; // vertical velocity
  PImage remmy;

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

    // --------------------------
    // 1. HORIZONTAL MOVEMENT
    // --------------------------
    float newX = x;

    if (l) newX -= xspeed;
    if (r) newX += xspeed;

    // Horizontal collision detection
    int top = int(y / map.cellSize);
    int bottom = int((y + h - 1) / map.cellSize);

    if (newX > x) {
        // moving right
        int col = int((newX + w - 1) / map.cellSize);
        for (int j = top; j <= bottom; j++) {
            if (map.isSolid(col, j)) {
                newX = col * map.cellSize - w;
                break;
            }
        }
    } else if (newX < x) {
        // moving left
        int col = int(newX / map.cellSize);
        for (int j = top; j <= bottom; j++) {
            if (map.isSolid(col, j)) {
                newX = (col + 1) * map.cellSize;
                break;
            }
        }
    }

    x = newX;

    // --------------------------
    // 2. APPLY GRAVITY
    // --------------------------
    if (!onGround) vy += gravity;

    // --------------------------
    // 3. VERTICAL MOVEMENT
    // --------------------------
    float newY = y + vy;

    int left = int(x / map.cellSize);
    int right = int((x + w - 1) / map.cellSize);

    onGround = false;

    if (vy > 0) {
        // falling
        int row = int((newY + h) / map.cellSize);
        for (int c = left; c <= right; c++) {
            if (map.isSolid(c, row)) {
                newY = row * map.cellSize - h;
                vy = 0;
                onGround = true;
                break;
            }
        }
    } else if (vy < 0) {
        // jumping upwards
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

    // --------------------------
    // 4. JUMP
    // --------------------------
    if (u && onGround) {
        vy = jumpForce;
        onGround = false;
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
