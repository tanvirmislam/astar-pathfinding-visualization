class Square {
  int size;

  // g = the movement cost to move from the starting point to a given square on the grid, following the path generated to get there
  // h = the estimated movement cost to move from that given square on the grid to the final destination. This is often referred to as the   
  int g;
  int h;
  int f; // f = g + h
  
  boolean isBlocked;
  
  Square(int s) {
    this.size       = s;
    this.isBlocked  = false;
    
    g = -1;
    h = -1;
    f = -1;
  }
  
  void block() {
    this.isBlocked = true;
  }
  
  void unblock() {
    this.isBlocked = false;
  }
  
  boolean isBlocked() {
    return this.isBlocked;
  }
}
