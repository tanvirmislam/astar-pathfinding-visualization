class Grid {
  int cols;
  int rows;
  
  int squareSize;
  
  Square[][] squareGrid;
  
  int[] startPos;
  int[] endPos;
  
  Grid(int windowWidth, int windowHeight, int squareSize) {
    this.squareSize  = squareSize;
    
    this.cols = windowWidth  / squareSize;
    this.rows = windowHeight / squareSize;
  
    squareGrid = new Square[rows][cols];
    
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        squareGrid[i][j] = new Square(squareSize);    
      }
    }
    
    startPos     = new int[2];
    startPos[0]  = rows/2;
    startPos[1]  = cols/8;
    
    endPos       = new int[2];
    endPos[0]    = rows/2;
    endPos[1]    = cols - (cols/8);
  }
  
  
  boolean isValid(int i, int j) {
    if ((i >= 0 && i <= rows) && (j >= 0 && j <+ cols)) {
      return true;
    }
    else {
      return false;
    }
  }
  
  boolean isBlocked(int i, int j) {
    if (!isValid(i, j)) {
      return false;
    }
  
    return squareGrid[i][j].isBlocked();
  }
  
  boolean isStartPos(int i, int j) {
    if (!isValid(i, j)) {
      return false;
    }
    
    if (startPos[0] == i && startPos[1] == j) {
      return true;
    }
    else {
      return false;
    }
  }
  
  boolean isEndPos(int i, int j) {
    if (!isValid(i, j)) {
      return false;
    }
    
    if (endPos[0] == i && endPos[1] == j) {
      return true;
    }
    else {
      return false;
    }
  }
  
  
  double calculateHValue(int row, int col) {
    return Math.sqrt( ((row - endPos[0]) * (row - endPos[0])) + ((col - endPos[1]) * (col - endPos[1])) );
  }
  
  
  
  
  void drawGrid() {
    stroke(0);
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        if (isStartPos(i, j)) {
          fill(109, 232, 125);
        }
        else if (isEndPos(i, j)) {
          fill(196, 68, 89);
        }
        else if (squareGrid[i][j].isBlocked()) {
          fill(0);
        }
        else {
          fill(255);
        }
        
        rect(j*squareSize, i*squareSize, squareSize, squareSize);
      }
    }
  }
  
  void block(int row, int col) {
    if (!isStartPos(row, col) && !isEndPos(row, col) && !squareGrid[row][col].isBlocked()) {
      squareGrid[row][col].block();
    }
  }
}
