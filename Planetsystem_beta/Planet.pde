int scale = 3;
int time_scale = 300;

class Planet {
  PVector pos;
  ArrayList<PVector> prevPos;
  PVector speed;
  int mass;
  int diameter;
  
  Planet(PVector pos_, PVector speed_, int mass_) {
    pos = pos_.copy();
    speed = speed_.copy();
    mass = mass_;
    diameter = floor(log(mass))*2;
    prevPos = new ArrayList<PVector>();
  }
  
  void show() {
    noStroke();
    fill(255);
    ellipse(pos.x, pos.y, diameter, diameter);
    for (PVector P : prevPos) {
      fill(255, 100);
      ellipse(P.x, P.y, diameter/2, diameter/2);
    }
  }
  
  void update() {
    PVector tmpSpeed = speed.copy();
    tmpSpeed.mult(time_scale);
    prevPos.add(pos.copy());
    pos.add(tmpSpeed);
    
    if (prevPos.size() > 25) {
      prevPos.remove(0);
    }
  }
  
  boolean outOfBounds() {
   return (pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height); 
  }
  
  void influence(ArrayList<Planet> list) {
    PVector totGrav = new PVector();
    for( Planet b : list) {
      if (b != this) {
        float dist = dist(this.pos.x, this.pos.y, b.pos.x, b.pos.y);
        float acc = (b.mass/(pow(dist, 2))) * (6.67259 * pow(10, -11));//*time_scale;
        PVector grav = PVector.sub(b.pos, this.pos);
        grav.setMag(acc);
      
        totGrav.add(grav);
      }
    }
    totGrav.setMag(totGrav.mag()*time_scale);
    speed.add(totGrav);
  }
}