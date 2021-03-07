final float x = 1200;
final float y = 720;
final float z = 1000;

PImage bg;

final String instructions = "Usa las flechas \u2191 y \u2193 para mover el ángulo de la cámara";

float cameraAngle = 30;

// sol
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
  textAlign(CENTER);
}

void draw(){
  background(bg);
  
  text(instructions, width / 2, 40);
  
  translate(x / 2, y / 2, -z / 2);
  rotateX(radians(-cameraAngle));
  
  pushMatrix();
  stroke(color(255, 165, 0));
  rotateY(radians(sunAngle));
  sphere(90);
  popMatrix();
  
  sunAngle += 0.25;
  if(sunAngle >= 360) sunAngle = 0.0;
  
  // Planeta 1
  pushMatrix();
  stroke(color(100, 165, 0));
  rotateY(p1Angle);
  translate(p1Xpos, p1Ypos, 0);
  sphere(p1Radius);
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
  sphere(p2Radius);
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
  sphere(p3Radius);
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
  sphere(p4Radius);
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
  sphere(p5Radius);
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
  if( keyPressed ){
    if( keyCode == UP ){
      cameraAngle += 1;
    }
    
    if( keyCode == DOWN ){
      cameraAngle -= 1;
    }
  }
    
}
