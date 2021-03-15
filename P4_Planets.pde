final float x = 1200;
final float y = 720;
final float z = 1000;

PImage bg;
PImage sunTexture, green, grass, earth, red, dirt;
PShape sun, p1, p2, p3, p4, p5;

boolean panoramicView = false;

// W, S, ARROWRIGTH, ARROWLEFT, ARROWUP, ARROWDOWN 
int[] controls = {0, 0, 0, 0, 0, 0};

// inercia hacia adelante o hacia atras
int[] inertia = {0, 0};

class CameraView {
  float[] eye = {0, 0, z};
  float[] center = {0, 0, z-1};
  float[] up = {0, 1, 0};
  
  float[] v = {0, 0, -1};
  
  public float eyeX(){
    return eye[0];
  }
  
  public float eyeY(){
    return eye[1];
  }
  
  public float eyeZ(){
    return eye[2];
  }
  
  public float centerX(){
    return center[0];
  }
  
  public float centerY(){
    return center[1];
  }
  
  public float centerZ(){
    return center[2];
  }
  
  public float upX(){
    return up[0];
  }
  
  public float upY(){
    return up[1];
  }
  
  public float upZ(){
    return up[2];
  }
  
  public void rotateY(boolean right){
    float ang = right ? PI / 360 : -PI / 360;
    float x2, y2, z2;
    x2 = v[0] * cos(ang) - v[2]*sin(ang);
    y2 = v[1];
    z2 = v[0]*sin(ang) + v[2]*cos(ang);
    
    v[0] = x2;
    v[1] = y2;
    v[2] = z2;
    
    this.center[0] = this.eye[0] + this.v[0];
    this.center[1] = this.eye[1] + this.v[1];
    this.center[2] = this.eye[2] + this.v[2];
  }
  
  public void rotateX(boolean down){
    float ang = down ? PI / 360 : -PI / 360;
    float x2, y2, z2;
    x2 = v[0];
    y2 = v[1]*cos(ang) - v[2]*sin(ang);
    z2 = v[1]*sin(ang) + v[2]*cos(ang);
    
    v[0] = x2;
    v[1] = y2;
    v[2] = z2;
    
    this.center[0] = this.eye[0] + this.v[0];
    this.center[1] = this.eye[1] + this.v[1];
    this.center[2] = this.eye[2] + this.v[2];
  }
  
  public void moveForward(){
    this.eye[0] = this.eye[0] + this.v[0];
    this.eye[1] = this.eye[1] + this.v[1];
    this.eye[2] = this.eye[2] + this.v[2];
    
    this.center[0] = this.eye[0] + this.v[0];
    this.center[1] = this.eye[1] + this.v[1];
    this.center[2] = this.eye[2] + this.v[2];
  }
  
  public void moveBackward(){
    this.eye[0] = this.eye[0] - this.v[0];
    this.eye[1] = this.eye[1] - this.v[1];
    this.eye[2] = this.eye[2] - this.v[2];
    
    this.center[0] = this.eye[0] + this.v[0];
    this.center[1] = this.eye[1] + this.v[1];
    this.center[2] = this.eye[2] + this.v[2];
  }
}


CameraView cv = new CameraView();
CameraView defaultcv = new CameraView();

// sol
float sunRadius = 90;
float sunAngle = 0.0;

// planeta 1
float p1Radius = 25;
float p1Angle = 25;
float p1Xpos = 200;
float p1Ypos = 0;

// planeta 2
float p2Radius = 45;
float p2Angle = 70;
float p2Xpos = 350;
float p2Ypos = 100;

// planeta 3
float p3Radius = 35;
float p3Angle = 25;
float p3Xpos = 450;
float p3Ypos = -100;
// luna 1 planeta 3
float l1p3Radius = 10;
float l1p3Angle = 15;
float l1p3Xpos = 60;
float l1p3Ypos = -20;

// planeta 4
float p4Radius = 50;
float p4Angle = 90;
float p4Xpos = 500;
float p4Ypos = 0;
// luna 1 planeta 4
float l1p4Radius = 10;
float l1p4Angle = 15;
float l1p4Xpos = 60;
float l1p4Ypos = -20;
// luna 2 planeta 4
float l2p4Radius = 10;
float l2p4Angle = 94;
float l2p4Xpos = 80;
float l2p4Ypos = 0;

// planeta 5
float p5Radius = 20;
float p5Angle = 75;
float p5Xpos = 600;
float p5Ypos = 0;

void setup(){
  size(1200, 720, P3D);
  
  imageMode(CENTER);
  //carga de la imagen
  bg = loadImage("space.jpg");
  textSize(20);
  
  sunTexture = loadImage("sun.jpg");
  
  beginShape();
  sun = createShape(SPHERE, sunRadius);
  sun.setStroke(255);
  sun.setTexture(sunTexture);
  endShape(CLOSE);
  
  
  green = loadImage("green.jpg");
  
  beginShape();
  p1 = createShape(SPHERE, p1Radius);
  p1.setStroke(255);
  p1.setTexture(green);
  endShape(CLOSE);
  
  
  grass = loadImage("grass.jpg");
  
  beginShape();
  p2 = createShape(SPHERE, p2Radius);
  p2.setStroke(255);
  p2.setTexture(grass);
  endShape(CLOSE);
  
  
  earth = loadImage("earth.jpg");
  
  beginShape();
  p3 = createShape(SPHERE, p3Radius);
  p3.setStroke(255);
  p3.setTexture(earth);
  endShape(CLOSE);
  
  
  red = loadImage("red.jpg");
  
  beginShape();
  p4 = createShape(SPHERE, p4Radius);
  p4.setStroke(255);
  p4.setTexture(red);
  endShape(CLOSE);
  
  dirt = loadImage("dirt.jpg");
  
  beginShape();
  p5 = createShape(SPHERE, p5Radius);
  p5.setStroke(255);
  p5.setTexture(dirt);
  endShape(CLOSE);
  
}

void draw(){
  background(bg);
  
  translate(x / 2, y / 2, -z / 2);

  if( panoramicView ){
    setCameraView(defaultcv);
    pushMatrix();
    translate(cv.eyeX(), cv.eyeY(), cv.eyeZ());
    fill(color(135, 206, 235));
    box(20);
    popMatrix();
  } else {
    setCameraView(cv);
  }
  
  pushMatrix();
  rotateY(radians(sunAngle));
  shape(sun);
  popMatrix();
  
  sunAngle += 0.25;
  if(sunAngle >= 360) sunAngle = 0.0;
  
  // Planeta 1
  pushMatrix();
  stroke(color(100, 165, 0));
  rotateY(p1Angle);
  translate(p1Xpos, p1Ypos, 0);
  
  shape(p1);
  
  noFill();
  rotateX(radians(90));
  translate(-p1Xpos, p1Ypos, 0);
  circle(0,0, 2*p1Xpos);
  fill(255);
  popMatrix();
  
  p1Angle += 0.02;
  if(p1Angle >= 360) p1Angle = 0.0;
  
  // Planeta 2
  pushMatrix();
  stroke(color(0, 165, 100));
  rotateY(p2Angle);

  translate(p2Xpos, p2Ypos, 0);

  shape(p2);
  
  noFill();
  rotateX(radians(90));
  translate(-p2Xpos, 0, 0);
  circle(0,0, 2*p2Xpos);
  fill(255);
  popMatrix();
  
  p2Angle += 0.01;
  if(p2Angle >= 360) p2Angle = 0.0;
  
  // Planeta 3
  pushMatrix();
  stroke(color(59, 131, 189));
  rotateY(p3Angle);
  translate(p3Xpos, p3Ypos, 0);

  shape(p3);
  
  noFill();
  
  pushMatrix();
  rotateX(radians(90));
  translate(-p3Xpos, 0, 0);
  circle(0,0, 2*p3Xpos);
  popMatrix();
  
  fill(255);
  // luna 1 planeta 3
  stroke(255);
  rotateY(l1p3Angle);
  translate(l1p3Xpos, l1p3Ypos, 0);
  sphere(l1p3Radius);
  
  l1p3Angle += 0.03;
  if(l1p3Angle >= 360) l1p3Angle = 0.0;
  
  popMatrix();
  
  p3Angle += 0.005;
  if(p3Angle >= 360) p3Angle = 0.0;
  
  
  // Planeta 4
  pushMatrix();
  stroke(color(139, 63, 73));
  rotateY(p4Angle);
  translate(p4Xpos, p4Ypos, 0);

  shape(p4);
  
  noFill();
  
  pushMatrix();
  rotateX(radians(90));
  translate(-p4Xpos, 0, 0);
  circle(0,0, 2*p4Xpos);
  popMatrix();
  
  fill(255);
  // luna 1 planeta 4
  pushMatrix();
  stroke(128);
  rotateY(l1p4Angle);
  translate(l1p4Xpos, l1p4Ypos, 0);
  sphere(l1p4Radius);
  popMatrix();
  
  l1p4Angle += 0.03;
  if(l1p4Angle >= 360) l1p4Angle = 0.0;
  
  // luna 2 planeta 4
  pushMatrix();
  stroke(64);
  rotateY(l2p4Angle);
  translate(l2p4Xpos, l2p4Ypos, 0);
  sphere(l2p4Radius);
  popMatrix();
  
  l2p4Angle += 0.03;
  if(l2p4Angle >= 360) l2p4Angle = 0.0;
  
  popMatrix();
  
  p4Angle += 0.005;
  if(p4Angle >= 360) p4Angle = 0.0;
  
  
  // Planeta 5
  pushMatrix();
  stroke(color(78, 59, 49));
  rotateY(p5Angle);
  translate(p5Xpos, p5Ypos, 0);

  shape(p5);
  
  noFill();
  
  pushMatrix();
  rotateX(radians(90));
  translate(-p5Xpos, 0, 0);
  circle(0,0, 2*p5Xpos);
  popMatrix();
  
  fill(255);
  popMatrix();
  
  p5Angle += 0.007;
  if(p5Angle >= 360) p5Angle = 0.0;
  
  
  // Check camera angles changes
  // W pressed
  if( controls[0] != 0 || inertia[0] > 0){
      cv.moveForward();
      inertia[0]--;
  }
  
  // S pressed
  if( controls[1] != 0 || inertia[1] > 0){
      cv.moveBackward();
      inertia[1]--;
  }
  
  // RIGHT pressed
  if( controls[2] != 0 ){
      cv.rotateY(true);
  }

  // LEFT pressed
  if( controls[3] != 0 ){
     cv.rotateY(false);
  }
    
  // UP pressed
  if( controls[4] != 0 ){
    cv.rotateX(false);
  }
  
  //DOWN pressed
  if( controls[5] != 0 ){
    cv.rotateX(true);
  }
    
}

void keyPressed(){
 
  if( key == 'w' || key == 'W' ){
    controls[0] = 1;
  }
  
  if( key == 's' || key == 'S' ){
    controls[1] = 1;
  }
  
  if( keyCode == RIGHT ){
    controls[2] = 1;
  }
    
  if( keyCode == LEFT ){
    controls[3] = 1;
  }
  
  if( keyCode == UP ){
    controls[4] = 1;
  }
  
  if( keyCode == DOWN ){
    controls[5] = 1;
  }
}

void keyReleased(){
  
  if( key == 'p' || key == 'P' ){
    panoramicView = !panoramicView;
  }
  
  if( key == 'w' || key == 'W' ){
    controls[0] = 0;
    inertia[0] = 60;
  }
  
  if( key == 's' || key == 'S' ){
    controls[1] = 0;
    inertia[1] = 60;
  }
  
  if( keyCode == RIGHT ){
    controls[2] = 0;
  }
    
  if( keyCode == LEFT ){
    controls[3] = 0;
  }
  
  if( keyCode == UP ){
    controls[4] = 0;
  }
  
  if( keyCode == DOWN ){
    controls[5] = 0;
  }
}

void setCameraView(CameraView cv){
  camera(cv.eyeX(), cv.eyeY(), cv.eyeZ(),
         cv.centerX(), cv.centerY(), cv.centerZ(),
         cv.upX(), cv.upY(), cv.upZ());
}
