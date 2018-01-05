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