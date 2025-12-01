class Map {
  int[][] map;
  int cellSize = 100;
  int rows, cols;
  String fileName;

  Map(String fileName) {
    this.fileName = fileName;

    loadFromCSV(fileName);

    rows = map[0].length;
    cols = map.length;
  }

  // ----------------------------
  // Load CSV
  void loadFromCSV(String fileName) {
    String[] lines = loadStrings(fileName);
    if (lines == null) {
      println("❌ Could not load CSV, using blank map.");
      map = new int[20][20];   // safe fallback
      return;
    }

    rows = lines.length;
    cols = split(lines[0], ',').length;
    map = new int[cols][rows];

    for (int j = 0; j < rows; j++) {
      String[] tokens = split(lines[j], ',');
      for (int i = 0; i < cols; i++) {
        map[i][j] = int(trim(tokens[i]));
      }
    }
  }

  // ----------------------------
  // Draw ONLY the visible tiles
  void drawMap() {

    int startCol = max(0, int(camX / cellSize));
    int endCol   = min(cols-1, int((camX + width) / cellSize) + 1);

    int startRow = max(0, int(camY / cellSize));
    int endRow   = min(rows-1, int((camY + height) / cellSize) + 1);

    noStroke();
    for (int i = startCol; i <= endCol; i++) {
      for (int j = startRow; j <= endRow; j++) {
        int val = map[i][j];
        switch(val) {
        //case 0:
        //  fill(0, 150, 255);
        //  break; // air
        case 1:
          fill(101, 67, 33);
          break; // dirt
        case 2:
          fill(28, 80, 200);
          break; // water
        case 3:
          fill(0, 255, 0);
          break;   // ground
        case 4:
          fill(80);
          break;        // stone
        case 5:
          fill(20);
          break;        // transitions
        default:
          continue;              // skip air
        }
        rect(i * cellSize, j * cellSize, cellSize, cellSize);
      }
    }
  }

  // ----------------------------
  boolean isSolid(int col, int row) {
    if (col < 0 || row < 0 || col >= cols || row >= rows) return true;
    int v = map[col][row];
    return (v == 3 || v == 4);
  }

  int getTile(int col, int row) {
    if (col < 0 || row < 0 || col >= cols || row >= rows) return -1;
    return map[col][row];
  }
}
