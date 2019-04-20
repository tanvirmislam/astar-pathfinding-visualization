class Button {
    int     buttonX;
    int     buttonY;
    int     buttonSize;
    color   buttonInitColor;
    color   buttonHoverColor;
    color   buttonFinalColor;
    boolean isButtonPressed;  

    Button(int x, int y, int s) {
        this.buttonX           = x;
        this.buttonY           = y;
        this.buttonSize        = s;
        this.buttonInitColor   = color(109, 232, 125);
        this.buttonHoverColor  = color(204);
        this.buttonFinalColor  = color(196, 68, 89);
        this.isButtonPressed   = false;
        ellipseMode(CENTER);
    }
  
    boolean isOverStartButton() {
        float disX = this.buttonX - mouseX;
        float disY = this.buttonY - mouseY;

        if (sqrt(sq(disX) + sq(disY)) < this.buttonSize/2 ) {
            return true;
        } 
        else {
            return false;
        }
    }
  
    void drawButton() {
        if (this.isButtonPressed) {
            fill(this.buttonFinalColor);  
        }
        else if (this.isOverStartButton()) {
            fill(this.buttonHoverColor);
        }
        else {
            fill(this.buttonInitColor);
        }

        ellipse(this.buttonX, this.buttonY, this.buttonSize, this.buttonSize);
    }
  
    void press() {
        this.isButtonPressed = true;
    }
  
    boolean isPressed() {
        return this.isButtonPressed;
    }
}
