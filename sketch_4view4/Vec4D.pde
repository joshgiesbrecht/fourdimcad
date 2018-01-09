class Vec4D {
  float x;
  float y;
  float z;
  float w;
  
  Vec4D(Vec4D init) {
    x = init.x;
    y = init.y;
    z = init.z;
    w = init.w;
  }
  Vec4D(float a, float b, float c, float d) {
    x = a;
    y = b;
    z = c;
    w = d;
  }

  void add(Vec4D b) {
    x += b.x;
    y += b.y;
    z += b.z;
    w += b.w;
  }
  
  void subtract(Vec4D s) {
    x -= s.x;
    y -= s.y;
    z -= s.z;
    w -= s.w;
  }
  
}

// axis: 1=x, 2=y, 3=z, 4=w
void setupView(int axis) {
  // x-axis
  // (y, z, w)
  pushMatrix();
  translate(width/2, height*2.0/3, 0);
  rotateX(radians(-20));
  rotateY(angle);
  if (axis == 1) {
    translate(400, 0, 0);
  } else if (axis == 2) {
    translate(0, -400, 0);
  } else if (axis == 3) {
    translate(0, 0, 400);
  } else {
    translate(0, 0, 0);
  }
}