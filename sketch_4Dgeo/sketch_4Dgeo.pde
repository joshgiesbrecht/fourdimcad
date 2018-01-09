ArrayList<Hypersphere> objects;

float chaos = 20;

void setup() {
  size(1100, 800, P3D);
  background(0);
  noStroke();
  sphereDetail(10);
  objects = new ArrayList<Hypersphere>();
  float x=0;
  float y=0;
  float z=0;
  float j=0;
  for (int n=0; n<15; n++) {
    y=200;
    x=0;
    z=0;
    j=0;
    for (int i=0; i < 100; i++) {
      Hypersphere myHyperSphere = new Hypersphere(x, y, z, j, 20);
      x += random(-chaos, chaos);
      y -= 10;
      z += random(-chaos, chaos);
      j += random(-chaos, chaos);
      objects.add(myHyperSphere);
    }
  }
}

void draw() {
  lights();
  background(0);

  float slice = (mouseY * 1.0 / height) * 1000 - 500;
  for (int i=0; i < objects.size(); i++) {
    objects.get(i).drawSlice(slice);
  }
  ellipse(10, mouseY, 5, 5);
}

class Hypersphere {
  Vec4D pos;
  float rad;

  Hypersphere(float x, float y, float z, float j, float r) {
    pos = new Vec4D(x, y, z, j);
    rad = r;
  }
  
  Hypersphere(Vec4D p, float r) {
    pos = new Vec4D(p.x, p.y, p.z, p.j);
    rad = r;
  }
  
  void drawSlice(float jslice) {
    float diff = jslice - pos.j;
    if (diff < rad) {
      float rprime = sqrt(rad*rad - diff*diff);
      pushMatrix();
      translate(width/2, height/2, 0);
      rotateY(frameCount/200.0);
      translate(pos.x, pos.y, pos.z);
      sphere(rprime);
      popMatrix();
    }    
  }

}

class Vec4D {
  float x;
  float y;
  float z;
  float j;
  
  Vec4D(Vec4D init) {
    x = init.x;
    y = init.y;
    z = init.z;
    j = init.j;
  }
  Vec4D(float a, float b, float c, float d) {
    x = a;
    y = b;
    z = c;
    j = d;
  }

  void add(Vec4D b) {
    x += b.x;
    y += b.y;
    z += b.z;
    j += b.j;
  }
}