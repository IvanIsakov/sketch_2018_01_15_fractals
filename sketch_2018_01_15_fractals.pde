float atten = 0.8;
float attenA = 1.2;
int index = -0;
float angleAdd = 0.0;
int numBranches = 6;

void setup() {
  size(640,640,P3D);
  background(0);
  colorMode(HSB);
  noStroke();
  //noLoop();
  rectMode(CENTER);
}

void draw() {
  background(0);
  float ir = index/314.0;
  float irir = 200 + 640.0*(ir-1)*(ir-1);
  //translate(width/2,height/2);
  //lights();
  //pointLight(127, 80, 210, 400, 400, 400);
  pointLight(127, 80, 210, 400*cos(-index*0.05), 400*sin(-index*0.05), 400);
  camera(0,0,irir,
  //camera(0,0,700,
         0,0,0,
         0,1,0);
  //rotate(PI/4);
 // fill(127);
  //translate(width/2,height/2);
  for (int i = 0; i < numBranches; i++) {
    fractal(100,0,0,i*2.0*PI/numBranches);
  }
  index++;
  println(index);
  angleAdd += 0.01;
  //saveFrame("video/####.tiff");
}

void fractal(float sizeF, float x, float y, float angle) {
  //fill((100 - sizeF)*3,255,255);
  //imageF(x,y,sizeF/2);
  octahedron(x,y,sizeF/2);
 // for (int i = 1; i < 3; i++) {
    //line(x,y,x+sizeF*attenA*sin(angle),y + sizeF*attenA*cos(angle));
    if (sizeF > 3 ) {
        stroke(127);
        noStroke();
        fractal(atten*sizeF, x + sizeF*attenA*sin(angle), y + sizeF*attenA*cos(angle), angle + angleAdd);
      //fractal(atten*sizeF, x + sizeF*attenA*sqrt(3)/2, y + sizeF*attenA/2);
      //fractal(atten*sizeF, x - sizeF*attenA*sqrt(3)/2, y + sizeF*attenA/2);
    //}
  }
}


void imageF(float x, float y, float sizeF) {
  pushMatrix();
  //rotate(angleAdd);
  translate(x,y,-sizeF);
 // ellipse(x,y,sizeF,sizeF);
  sphere(sizeF);
  popMatrix();
}


void hexagon(float x, float y, float sizeOfIt) {
  pushMatrix();
  translate(x,y);
  int flowerInd = 200;
  int indexFlo = index % 50;
 // rotate(index/5);
  float col = sin(7.0*(index)/flowerInd/4);
  fill((1+col)*127,255*(1-col*col),127*(1 - col));
  stroke(255*(1-col*col),127*(1 - col),(1+col)*127);
  beginShape();
  float[] coordinatesX = new float[8];
  float[] coordinatesY = new float[8];
  for (int i = 0; i < 8; i++) {
    coordinatesX[i] = (0.8*sizeOfIt*cos(i*1.0/6*2*PI));    
    coordinatesY[i] = (0.8*sizeOfIt*sin(i*1.0/6*2*PI));
  }
  vertex(coordinatesX[0],coordinatesY[0]); // first point
  for (int i = 1; i < 7; i++) {
    bezierVertex(coordinatesX[i]*indexFlo/flowerInd,coordinatesY[i]*indexFlo/flowerInd,coordinatesX[i-1]*indexFlo/flowerInd,coordinatesY[i-1]*indexFlo/flowerInd,coordinatesX[i],coordinatesY[i]);
  }
  endShape(CLOSE);
  popMatrix();  
}

void octahedron(float x, float y, float sizeOfIt) {
  pushMatrix();
  translate(x,y,0);
  //rotateX(index*0.033);
  //rotateZ(index*0.053);
  beginShape(TRIANGLE_FAN);
  vertex(0, 0, sizeOfIt);
  vertex(0, -sizeOfIt, 0); 
  vertex(sizeOfIt, 0, 0); 
  vertex(0, sizeOfIt, 0); 
  vertex(-sizeOfIt, 0, 0); 
  vertex(0, -sizeOfIt, 0); 
  endShape();
  beginShape(TRIANGLE_FAN);
  vertex(0, 0, -sizeOfIt);
  vertex(0, -sizeOfIt, 0); 
  vertex(sizeOfIt, 0, 0); 
  vertex(0, sizeOfIt, 0); 
  vertex(-sizeOfIt, 0, 0); 
  vertex(0, -sizeOfIt, 0); 
  endShape();
  popMatrix();
}