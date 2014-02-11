//joselyn
class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(PVector l) {
    acceleration = new PVector(0,0.05);
    velocity = new PVector(random(-10,10),random(-20,40));
    location = l.get();
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update location
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 1.0;
    
  }

  // Method to display
  void display() {
    //stroke(255,lifespan);
    //fill(255,lifespan);
    image(images[0], location.x + 400, location.y +200 , 100, 100);
    image(images[8], location.x +450, location.y +190, 100, 100); 
  }
  
  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
//joselyn's particles

