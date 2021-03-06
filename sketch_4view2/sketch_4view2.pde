ArrayList<Hypersphere> objects;

float chaos = 50;
float size = 200;

Hypersphere cursor;

void setup() {
  size(1200, 800, P3D);
  background(0);
  colorMode(HSB);
  noStroke();
  sphereDetail(10);
  objects = new ArrayList<Hypersphere>();
  cursor = new Hypersphere(0,0,0,0,20);
}

void mouseClicked() {
  objects.add(cursor.copy());
  cursor = new Hypersphere(0,0,0,0, 20);
}


void draw() {
  lights();
  background(0);

  float slice = (mouseY * 1.0 / height) * 1000 - 500;
  for (int i=0; i < objects.size(); i++) {
    objects.get(i).drawViews();
  }
  
  if (keyPressed) {
    if (key == 'x') {
      cursor.pos.x += mouseX - pmouseX;
      cursor.pos.x = mid(cursor.pos.x, -size, size);
    }
    if (key == 'y') {
      cursor.pos.y += mouseX - pmouseX;
      cursor.pos.y = mid(cursor.pos.y, -size, size);
    }
    if (key == 'z') {
      cursor.pos.z += mouseX - pmouseX;
      cursor.pos.z = mid(cursor.pos.z, -size, size);
    }
    if (key == 'w') {
      cursor.pos.w += mouseX - pmouseX;
      cursor.pos.w = mid(cursor.pos.w, -size, size);
    }
  }
  
  cursor.drawViews();
  
  ellipse(10, mouseY, 5, 5);
}

class Hyperrect {
  Vec4D pos;
  Vec4D widths;
  
  Hyperrect(Vec4D p, Vec4D w) {
    pos = p;
    widths = w;
  }
  
  void updateWidths(Vec4D w) {
    widths = w;
  }
  
  void drawViews() {
    // x-axis
    // (y, z, w)
    pushMatrix();
    translate(width/2, height/2, 0);
    rotateY(frameCount/200.0);
    translate(pos.y, pos.z, pos.w);
    box(widths.y, widths.z, widths.w);
    popMatrix();
    
    // y-axis
    // (x, z, w)
    pushMatrix();
    translate(width/2, height/2, 0);
    rotateY(frameCount/200.0);
    translate(pos.x, pos.z, pos.w);
    box(widths.x, widths.z, widths.w);
    popMatrix();
    
    
    // z-axis
    // (y, x, w)
    pushMatrix();
    translate(width/2, height/2, 0);
    rotateY(frameCount/200.0);
    translate(pos.y, pos.x, pos.w);
    box(widths.y, widths.x, widths.w);
    popMatrix();
    
    
    // w-axis
    // (y, x, z)
    pushMatrix();
    translate(width/2, height/2, 0);
    rotateY(frameCount/200.0);
    translate(pos.y, pos.x, pos.z);
    box(widths.y, widths.x, widths.z);
    popMatrix();
    
    
  }

  
}

class Hypersphere {
  Vec4D pos;
  float rad;
  float hue;

  Hypersphere(float x, float y, float z, float w, float r) {
    pos = new Vec4D(x, y, z, w);
    rad = r;
    hue = random(0,255);
  }
  
  Hypersphere(Vec4D p, float r) {
    pos = new Vec4D(p.x, p.y, p.z, p.w);
    rad = r;
  }
  
  Hypersphere copy() {
    Hypersphere n = new Hypersphere(pos, rad);
    n.hue = hue;
    return n;
  }
  
  void drawSlice(float wslice) {
    float diff = wslice - pos.w;
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
  
  void drawViews() {
    drawX();
    drawY();
    drawZ();
    drawW();
  }
  
  // look down the x-axis at the 4D object
  // (y, z, w)
  void drawX() {
    pushMatrix();
    translate(width/4, height/4, 0);
    rotateY(frameCount/200.0);
    translate(pos.y, pos.z, pos.w);
    fill(hue, 100, lerp(50,205, (pos.x+size)/(2*size)));
    sphere(rad);
    popMatrix();
  }
  
  // look down the y-axis at the 4D object
  // (x, z, w)
  void drawY() {
    pushMatrix();
    translate(width*3/4, height/4, 0);
    rotateY(frameCount/200.0);
    translate(pos.x, pos.z, pos.w);
    fill(hue, 100, lerp(50,205, (pos.y+size)/(2*size)));
    sphere(rad);
    popMatrix();
  }
  
  // look down the z-axis at the 4D object
  // (y, x, w)
  void drawZ() {
    pushMatrix();
    translate(width/4, height*3/4, 0);
    rotateY(frameCount/200.0);
    translate(pos.y, pos.x, pos.w);
    fill(hue, 100, lerp(50,205, (pos.z+size)/(2*size)));
    sphere(rad);
    popMatrix();
  }
  
  // look down the w-axis at the 4D object
  // (y, x, z)
  void drawW() {
    pushMatrix();
    translate(width*3/4, height*3/4, 0);
    rotateY(frameCount/200.0);
    translate(pos.y, pos.x, pos.z);
    fill(hue, 100, lerp(50,205, (pos.w+size)/(2*size)));
    sphere(rad);
    popMatrix();
  }

}

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
}


float mid(float a, float b, float c) {
  if (a < b) {
    if (c < a) {
      return a;
    } else if (b < c) {
      return b;
    } else {
      return c;
    }
  } // a > b
  if (b > c) {
    return b;
  } else if (a < c) {
    return a;
  } else {
    return c;
  }
}