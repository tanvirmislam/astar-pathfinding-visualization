import java.util.HashSet;
import java.util.PriorityQueue;

final int gridWidth  = 700;                // Square grid width
final int gridHeight = 700;                // Square grid height

final int squareSize = 10;                 // Square size

final int rows = gridHeight / squareSize;  // Number of rows in the grid
final int cols = gridWidth  / squareSize;  // Number of cols in the grid

// 2D array of squares
Square[][] grid; 

int[] startPos;  // Start position
int[] endPos;    // End position

// Closed set: set of squares that are already evaluated
HashSet<Square> closedSet;

// Open set: set of squares that are discovered but not yet evaluated
HashSet<Square> openSet;

// Next square that needs to be evaluated will be chosen from open set
// The sqaure having the least f value will be chosen
// In order to find the square with least f, maintain a min-heap of the open set squares
PriorityQueue<Square> minPQ;


// Boolean to indicate if the search is over or not
boolean isOver;

// Start button
Button startButton;

// Setup
void setup() {
    size(900, 700);
  
    // Assign start position
    startPos    = new int[2];
    startPos[0] = rows/2;
    startPos[1] = cols/8;

    // Assign end position
    endPos    = new int[2];
    endPos[0] = rows/2;
    endPos[1] = cols - (cols/8);
  
    // Initialize grid
    grid = new Square[rows][cols];
  
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            grid[i][j] = new Square(i, j);    
            grid[i][j].setH(dist(j, i, endPos[1], endPos[0]));  // Eucledian distance to end square
            grid[i][j].setF(Double.MAX_VALUE);                  // Initially, f score is set to infinity
        }
    }
  
    // Assign neighbors to the squares
    // Call assignNeighbors() after the blocked squares have been marked (at button press)
  
    // g score of starting node is 0 (cost of path from start node to start node = 0)
    // f score of starting node is as a result completely heuristic
    grid[startPos[0]][startPos[1]].setG(0);
    grid[startPos[0]][startPos[1]].setF(grid[startPos[0]][startPos[1]].getH() + 0);
  
    // Initialize closedSet
    closedSet = new HashSet<Square>();
  
    // Initialize openSet
    // Initially openSet contains just the starting square
    openSet = new HashSet<Square>();
    openSet.add(grid[startPos[0]][startPos[1]]);
  
    // Initialize min priority queue
    minPQ = new PriorityQueue<Square>(new SquareComparator());
    minPQ.add(grid[startPos[0]][startPos[1]]);
  
    // Initialize isOver to false
    isOver = false;
  
  
    // Start button
    startButton = new Button(800, 350, 50);
}


// Draw loop
void draw() {
    background(255);
    drawGrid();
    startButton.drawButton();
  
    if (!startButton.isPressed()) {
        return;
    }
  
    // if openSet is not empty and the search is not over, continue calculation
    if (!openSet.isEmpty() && !isOver) { 
        // current = the node in openSet with LOWEST f value
        Square current = minPQ.poll();
    
        // If current = endPos, then the search is over
        // Print path
        if (current == grid[endPos[0]][endPos[1]]) {
            isOver = true;
            traceBestPath();
        }
    
        // Remove the current square from openSet, and add it to closedSet
        openSet.remove(current);
        closedSet.add(current);
        current.evaluate();
    
        for (Square neighbor : current.getNeighbors()) {
            // If the neighbor has already been evaluated, then ignore the neighbor
            if (closedSet.contains(neighbor)) {
                continue;
            }
      
            // g = Distance (start, neighbor) = Dist(start, current) = Dist(current, neigbor)
            // This g value is tentative. The lowest g value for a square will be save
            double tentativeG = current.getG() + dist(current.getCol(), current.getRow(), neighbor.getCol(), neighbor.getRow());
      
            // If this neighbor is not in the openSet, it is newly discovered
            // Add it to the openSet
            if (!openSet.contains(neighbor)) {
                openSet.add(neighbor);
                minPQ.add(neighbor);  
                neighbor.discover();
            }
            else if (tentativeG >= neighbor.getG()) {
                // The neighbor is already discovered and has a better g value stored
                // so dont save the tentativeG and continue to the next neighbor
                continue;
            }
      
            // Best known path discovered, save the path
            neighbor.setParent(current);
            neighbor.setG(tentativeG);
            neighbor.setF(neighbor.getG() + neighbor.getH());
        }  
    }
    else {
        // done  
    }
}


// Trace the best path
// Start from the end square and trace parents
void traceBestPath() {
    Square current = grid[endPos[0]][endPos[1]];
    while (current.getParent() != null) {
        current = current.getParent();
        current.includeInBestPath();
    }
}


// Assign reachable neighbors to each squares
void assignNeighbors() {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            // Up
            if (i > 0) {
                if (!grid[i-1][j].isBlocked()) {
                    grid[i][j].addNeighbor(grid[i-1][j]);
                }
            }
          
            // Down
            if (i < rows-1) {
                if (!grid[i+1][j].isBlocked()) {
                    grid[i][j].addNeighbor(grid[i+1][j]);
                }
            }
          
            // Left
            if (j > 0) {
                if (!grid[i][j-1].isBlocked()) {
                    grid[i][j].addNeighbor(grid[i][j-1]);
                }
            }
          
            // Right
            if (j < cols-1) {
                if (!grid[i][j+1].isBlocked()) {
                    grid[i][j].addNeighbor(grid[i][j+1]);
                }
            }
        }
    }
}


//----------------------------------------------------------------------------------------------------------
// Helper functions
//----------------------------------------------------------------------------------------------------------
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

    return grid[i][j].isBlocked();
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

void block(int i, int j) {
    if (!isStartPos(i, j) && !isEndPos(i, j) && !grid[i][j].isBlocked()) {
        grid[i][j].block();
    }
}
//----------------------------------------------------------------------------------------------------------



//----------------------------------------------------------------------------------------------------------
// Draw grid
//----------------------------------------------------------------------------------------------------------
void drawGrid() {
    stroke(0);
  
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (isStartPos(i, j)) {
                fill(40, 62, 204);
            }
            else if (isEndPos(i, j)) {
                fill(109, 232, 125);
            }
            else if (grid[i][j].isBlocked()) {
                fill(0);
            }
            else if (grid[i][j].isInBestPath()) {
                fill(168, 191, 224);
            }
            else if (grid[i][j].isEvaluated()) {
                fill(193, 67, 67);
            }
            else if (grid[i][j].isDiscovered()) {
                fill(242, 191, 214);
            }
            else {
                fill(255);
            }
            rect(j*squareSize, i*squareSize, squareSize, squareSize);
        }
    }
}
//----------------------------------------------------------------------------------------------------------



//----------------------------------------------------------------------------------------------------------
// Mouse Event Handler
//----------------------------------------------------------------------------------------------------------
void mousePressed() {
    if (mouseX >= 0 && mouseX < gridWidth && mouseY >= 0 && mouseY < gridHeight && !startButton.isPressed()) {
        int x = floor(mouseX/squareSize);
        int y = floor(mouseY/squareSize);
  
        block(y, x);
    }
    else if (startButton.isOverStartButton()) {
        startButton.press();
        // Start simulation: assign reachable neighbors to each squares
        assignNeighbors();
    }
}

void mouseDragged() {
    if (mouseX >= 0 && mouseX < gridWidth && mouseY >= 0 && mouseY < gridHeight && !startButton.isPressed()) {
        int x = floor(mouseX/squareSize);
        int y = floor(mouseY/squareSize);
  
        block(y, x);
    }
}
//----------------------------------------------------------------------------------------------------------
