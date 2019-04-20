int gridWidth;
int gridHeight;

int squareSize;

Grid grid;

int     startButtonX;
int     startButtonY;
int     startButtonSize;
color   startButtonInitColor;
color   startButtonHoverColor;
color   startButtonFinalColor;
boolean isButtonPressed;

void setup() {
  size(900, 700);
  
  gridWidth     = 700;
  gridHeight    = 700;
  squareSize    = 10; 
  
  grid = new Grid(gridWidth, gridHeight, 10);
  
  initStartButton();
}


void draw() {
  background(255);
  grid.drawGrid();
  drawStartButton();
}


void initStartButton() {
  startButtonX            = 800;
  startButtonY            = 350;
  startButtonSize         = 50;
  startButtonInitColor    = color(109, 232, 125);
  startButtonHoverColor   = color(204);
  startButtonFinalColor   = color(196, 68, 89);
  isButtonPressed         = false;
  ellipseMode(CENTER);
}

void drawStartButton() {
  if (isButtonPressed) {
    fill(startButtonFinalColor);  
  }
  else if (isOverStartButton()) {
    fill(startButtonHoverColor);
  }
  else {
    fill(startButtonInitColor);
  }
  ellipse(startButtonX, startButtonY, startButtonSize, startButtonSize);
}


boolean isOverStartButton() {
  float disX = startButtonX - mouseX;
  float disY = startButtonY - mouseY;
  
  if (sqrt(sq(disX) + sq(disY)) < startButtonSize/2 ) {
    return true;
  } 
  else {
    return false;
  }
}

void mousePressed() {
  if (mouseX >= 0 && mouseX < gridWidth && mouseY >= 0 && mouseY < gridHeight && !isButtonPressed) {
    int x = floor(mouseX/squareSize);
    int y = floor(mouseY/squareSize);
  
    grid.block(y, x);
  }
  else if (isOverStartButton()) {
    isButtonPressed = true;
  }
}

void mouseDragged() {
   if (mouseX >= 0 && mouseX < gridWidth && mouseY >= 0 && mouseY < gridHeight && !isButtonPressed) {
    int x = floor(mouseX/squareSize);
    int y = floor(mouseY/squareSize);
  
    grid.block(y, x);
  }
}
