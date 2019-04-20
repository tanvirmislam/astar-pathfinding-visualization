import java.util.ArrayList;

class Square {
    final int row;
    final int col;

    // g = the movement cost to move from the starting point to a given square on the grid, following the path generated to get there
    // h = the estimated movement cost to move from that given square on the grid to the final destination. This is often referred to as the   
    // f = g + h
    double g;
    double h;
    double f; 

    ArrayList<Square> neighbors;

    Square parent;

    // These booleans help in drawing appropriate colors
    boolean isBlocked;
    boolean isDiscovered;
    boolean isEvaluated;
    boolean isInBestPath;

    Square(int i, int j) {
        this.row        = i;
        this.col        = j;

        g = -1;
        h = -1;
        f = -1;

        neighbors = new ArrayList<Square>();

        parent = null;

        this.isBlocked    = false;
        this.isDiscovered = false;
        this.isEvaluated  = false;
        this.isInBestPath = false;
    }

    void block()                     { this.isBlocked = true; h = -1; }
    void discover()                  { this.isDiscovered = true;      } 
    void evaluate()                  { this.isEvaluated = true;       }
    void includeInBestPath()         { this.isInBestPath = true;      }

    boolean isBlocked()              { return this.isBlocked;         }
    boolean isDiscovered()           { return this.isDiscovered;      }
    boolean isEvaluated()            { return this.isEvaluated;       }
    boolean isInBestPath()           { return this.isInBestPath;      }

    int getRow()                     { return this.row;               }
    int getCol()                     { return this.col;               }

    void setParent(Square sq)        { this.parent = sq;              }
    Square getParent()               { return this.parent;            }

    void addNeighbor(Square sq)      { neighbors.add(sq);             }
    ArrayList<Square> getNeighbors() { return this.neighbors;         }

    void setG(double gVal)           { this.g = gVal;                 }
    double getG()                    { return this.g;                 }  

    void setH(double hVal)           { this.h = hVal;                 }
    double getH()                    { return this.h;                 }

    void setF(double fVal)           { this.f = fVal;                 }
    double getF()                    { return this.f;                 }

}
