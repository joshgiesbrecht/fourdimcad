ArrayList<Hyperrect> objects;

float size = 200;

boolean newHR;
float angle = 0;

Hypersphere cursor;
Hyperrect nextrect;

void setup() {
  size(1200, 800, P3D);
  //ortho();
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  background(0);
  colorMode(HSB);
  noStroke();
  sphereDetail(10);
  objects = new ArrayList<Hyperrect>();
  //nextrect = new Hyperrect(new Vec4D(-50, -50, -50, -50), new Vec4D(30, 60, 90, 120));
  //objects.add(nextrect);
  cursor = new Hypersphere(0,0,0,0,20);
  nextrect = new Hyperrect(new Vec4D(0,0,0,0), new Vec4D(0,0,0,0));
  newHR = true;
}

void mouseClicked() {
  if (newHR) {
    nextrect = new Hyperrect(cursor.pos, new Vec4D(0,0,0,0));
  } else {
    objects.add(nextrect);
    nextrect = new Hyperrect(new Vec4D(0,0,0,0), new Vec4D(10,10,10,10));
    cursor.pos = new Vec4D(0,0,0,0);
  }
  newHR = !newHR;
}


void draw() {
  lights();
  background(0);

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
  } else {
    angle += (mouseX - pmouseX) / 200.0;
  }
  
  cursor.drawViews();
  
  if (newHR) {
    nextrect.updatePos(cursor.pos);
  } else {
    Vec4D tmp = new Vec4D(cursor.pos);
    text("nextrect: " + nextrect.pos.x + ", " + nextrect.pos.y  + ", " + nextrect.pos.z + ", " + nextrect.pos.w, 100, 250);
    tmp.subtract(nextrect.pos);
    text("tmp: " + tmp.x + ", " + tmp.y  + ", " + tmp.z + ", " + tmp.w, 100, 300);
    nextrect.updateWidths(tmp);
    nextrect.drawViews();
  }

  for (int i=0; i < objects.size(); i++) {
    objects.get(i).drawViews();
  }
  
  text(cursor.pos.x + ", " + cursor.pos.y  + ", " + cursor.pos.z + ", " + cursor.pos.w, 100, 100);
  
  if (!newHR) {
    text(nextrect.widths.x + ", " + nextrect.widths.y  + ", " + nextrect.widths.z + ", " + nextrect.widths.w, 
      100, 200);
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