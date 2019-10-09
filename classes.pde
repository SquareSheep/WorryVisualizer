class AColor {
  SpringValue r;
  SpringValue g;
  SpringValue b;
  SpringValue a;
  AColor(float R, float G, float B, float A, float vMult, float mass) {
    this.r = new SpringValue(R, vMult, mass);
    this.g = new SpringValue(G, vMult, mass);
    this.b = new SpringValue(B, vMult, mass);
    this.a = new SpringValue(A, vMult, mass);
  }

  AColor(float R, float G, float B, float A) {
    this.r = new SpringValue(R, defaultVMult, defaultMass);
    this.g = new SpringValue(G, defaultVMult, defaultMass);
    this.b = new SpringValue(B, defaultVMult, defaultMass);
    this.a = new SpringValue(A, defaultVMult, defaultMass);
  }

  AColor copy() {
    return new AColor(r.X, g.X, b.X, a.X, r.vMult, r.mass);
  }
  void update() {
    r.update();
    g.update();
    b.update();
    a.update();
  }

  void fillStyle() {
    fill(r.x, g.x, b.x, a.x);
  }

  void strokeStyle() {
    stroke(r.x, g.x, b.x, a.x);
  }

  void addx(AColor other) {
    r.x += other.r.x;
    g.x += other.g.x;
    b.x += other.b.x;
    a.x += other.a.x;
  }

  void addX(AColor other) {
    r.X += other.r.X;
    g.X += other.g.X;
    b.X += other.b.X;
    a.X += other.a.X;
  }

  void setx(float r, float g, float b, float a) {
    this.r.x = r;
    this.g.x = g;
    this.b.x = b;
    this.a.x = a;
  }

  void addx(float R, float G, float B, float A) {
    this.r.x += R;
    this.g.x += G;
    this.b.x += B;
    this.a.x += A;
  }
}

class APoint {
  PVector p;
  PVector v = new PVector(0,0,0);
  PVector a = new PVector(0,0,0);
  float mass;
  float vMult;

  APoint(PVector p, float vMult, float mass) {
    this.p = p;
    this.mass = mass;
    this.vMult = vMult;
  }

  APoint(PVector p) {
    this.p = p;
    this.mass = defaultMass;
    this.vMult = defaultVMult;
  }

  void updateVectors() {
    v.add(a);
    v.mult(vMult);
    p.add(v);
    a.mult(0);
  }

  void update() {
    updateVectors();
  }

  void applyForce(PVector f) {
    a.add(f.div(mass));
  }

  APoint copy() {
    return new APoint(p.copy(), vMult, mass);
  }
}

class Point {
  PVector p;
  PVector P;
  PVector v = new PVector(0,0,0);
  float vMult;
  float mass;

  Point() {
    this.p = new PVector();
    this.P = new PVector();
    this.vMult = defaultVMult;
    this.mass = defaultMass;
  }

  Point(PVector p, float vMult, float mass) {
    this.p = p;
    this.P = p.copy();
    this.vMult = vMult;
    this.mass = mass;
  }

  Point(PVector p) {
    this.p = p;
    this.P = p.copy();
    this.vMult = defaultVMult;
    this.mass = defaultMass;
  }

  Point(float x, float y) {
    this.p = new PVector(x, y);
    this.P = p.copy();
    this.vMult = defaultVMult;
    this.mass = defaultMass;
  }

  Point(float x, float y, float vMult, float mass) {
    this.p = new PVector(x, y);
    this.P = p.copy();
    this.vMult = vMult;
    this.mass = mass;
  }

  void update() {
    v.mult(vMult);
    v.add(PVector.sub(P,p).div(mass));
    p.add(v);
  }

  Point copy() {
    return new Point(p.copy(), vMult, mass);
  }
}

class SpringValue {
  float x;
  float X;
  float v = 0;
  float vMult;
  float mass;

  SpringValue(float x, float vMult, float mass) {
    this.x = x;
    this.X = x;
    this.vMult = vMult;
    this.mass = mass;
  }

  SpringValue(float x) {
    this.x = x;
    this.X = x;
    vMult = defaultVMult;
    mass = defaultMass;
  }

  void update() {
    v += (X - x)/mass;
    v *= vMult;
    x += v;
  }
}

class BeatTimer {
  //this.beat will be true exactly once every beat
  int offset;
  int bpm;
  float sec;
  int threshold;
  boolean beat = false;
  boolean beatAlready = false;
  int tick = 1;

  BeatTimer(int threshold, int offset, int bpm) {
    this.bpm = bpm;
    this.sec = sec;
    this.offset = offset;
    this.threshold = threshold;
  }

  void update() {
    float currMil = currTime % (60000.0/bpm);
    if (!beatAlready && currMil < threshold) {
      beat = true;
      beatAlready = true;
      tick ++;
      if (tick > 4) tick = 1;
    } else {
      beat = false;
    }
    if (currMil > threshold) {
      beatAlready = false;
    }
  }
}