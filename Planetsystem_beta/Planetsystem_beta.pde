ArrayList<Planet> space;
PVector start;
PVector end;
PVector velo;
int mass = 1000000;
boolean show;

void setup() {
  size(1200,900);
  start = new PVector();
  end  = new PVector();
  velo  = new PVector(0,0);
  space  = new ArrayList<Planet>();
  println("mass = " + mass);
}

void draw() {
  background(51);
  stroke(255);
  strokeWeight(4);
  fill(255); 
  if(show) {
    line(start.x, start.y, mouseX, mouseY);
  }
  for(int i = 0; i < space.size(); i++) {
    Planet P  = space.get(i);
    P.influence(space);
    P.update();
    P.show();
    if(P.outOfBounds()) {
      space.remove(i);
    }
  }
}

void mousePressed() {
  start.set(mouseX, mouseY);
  show = true;
}

void mouseReleased() {
  end.set(mouseX, mouseY);
  
  velo = PVector.sub(start, end);
  velo.setMag(velo.mag()/(3000));
  
  space.add(new Planet(start, velo, mass));
  
  show = false;
}

void keyReleased() {
  if  (key == 'a' || key == 'A') {
    mass *= 10;
  } else if  (key == 'z' || key == 'Z') {
    mass *= 0.1;
  }
  println("mass = " + mass);
}