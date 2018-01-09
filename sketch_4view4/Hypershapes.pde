class Hyperrect {
  Vec4D pos;
  Vec4D widths;
  
  Hyperrect(Vec4D p, Vec4D w) {
    pos = new Vec4D(p);
    widths = new Vec4D(w);
  }
  
  void updateWidths(Vec4D w) {
    widths.x = w.x;
    widths.y = w.y;
    widths.z = w.z;
    widths.w = w.w;
  }
  
  void updatePos(Vec4D p) {
    pos.x = p.x;
    pos.y = p.y;
    pos.z = p.z;
    pos.w = p.w;
  }
  
  void drawViews() {
    fill(255, 100);
    stroke(255);

    // x-axis
    // (w, y, z)
    setupView(1);
    translate(pos.w + widths.w/2, pos.y + widths.y/2, pos.z + widths.z/2);
    box(widths.w, widths.y, widths.z);
    popMatrix();
    
    // y-axis
    // (x, w, z)
    setupView(2);
    translate(pos.x + widths.x/2, -(pos.w + widths.w/2), pos.z + widths.z/2);
    box(widths.x, -widths.w, widths.z);
    popMatrix();
    
    
    // z-axis
    // (x, y, w)
    setupView(3);
    translate(pos.x + widths.x/2, pos.y + widths.y/2, pos.w + widths.w/2);
    box(widths.x, widths.y, widths.w);
    popMatrix();
    
    
    // w-axis
    // (x, y, z)
    setupView(4);
    translate(pos.x + widths.x/2, pos.y + widths.y/2, pos.z + widths.z/2);
    box(widths.x, widths.y, widths.z);
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
    fill(100, 100);
    noStroke();
    drawX();
    drawY();
    drawZ();
    drawW();
  }
  
  // look down the x-axis at the 4D object
  void drawX() {
    setupView(1);

    translate(pos.w, pos.y, pos.z);
    fill(hue, 100, lerp(50,205, (pos.x+size)/(2*size)));
    sphere(rad);
    popMatrix();
  }
  
  // look down the y-axis at the 4D object
  // (x, z, w)
  void drawY() {
    setupView(2);

    translate(pos.x, -pos.w, pos.z);
    fill(hue, 100, lerp(50,205, (pos.y+size)/(2*size)));
    sphere(rad);
    popMatrix();
  }
  
  // look down the z-axis at the 4D object
  // (y, x, w)
  void drawZ() {
    setupView(3);

    translate(pos.x, pos.y, pos.w);
    fill(hue, 100, lerp(50,205, (pos.z+size)/(2*size)));
    sphere(rad);
    popMatrix();
  }
  
  // look down the w-axis at the 4D object
  // (y, x, z)
  void drawW() {
    setupView(4);

    translate(pos.x, pos.y, pos.z);
    fill(hue, 100, lerp(50,205, (pos.w+size)/(2*size)));
    sphere(rad);
    popMatrix();
  }

}