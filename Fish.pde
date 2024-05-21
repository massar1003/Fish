import ddf.minim.*;
Minim minim;
AudioPlayer BGM;
AudioPlayer SE1;
AudioPlayer SE2;
import TUIO.*;
TuioProcessing tuioClient;
float cursor_size = 15;
float object_size = 60;
float table_size = 760;
float scale_factor = 1;
PFont font;
int H = 0;
boolean verbose = false; // print console debug messages
boolean callback = true; // updates only after callbacks
PImage img;
int fish1X = 300;
int fish1Y = 100;
int fish2X = 800;
int fish2Y = 200;
int fish3X = 1600;
int fish3Y = 700;
int fish4X = 1000;
int fish4Y = 600;
int fish5X = 1000;
int fish5Y = 900;
int target1X = 100;
int target1Y = 100;
int target2X = 600;
int target2Y = 200;
int target3X = 500;
int target3Y = 100;
int target4X = 200;
int target4Y = 200;
int target5X = 400;
int target5Y = 300;
int distance1X = 0;
int distance1Y = 0;
int distance2X = 0;
int distance2Y = 0;
int distance3X = 0;
int distance3Y = 0;
int distance4X = 0;
int distance4Y = 0;
int distance5X = 0;
int distance5Y = 0;
int angle1 = 0;
int angle2 = 0;
int angle3 = 0;
int angle4 = 0;
int angle5 = 0;
float radian1 = 0;
float radian2 = 0;
float radian3 = 0;
float radian4 = 0;
float radian5 = 0;
int mode1 = 0;
int mode2 = 0;
int mode3 = 0;
int mode4 = 0;
int mode5 = 0;
int i = 0;

void setup(){
  fullScreen();
  img = loadImage("data/kingyo1.png");
  img.resize(100,0);
  tuioClient = new TuioProcessing(this);
  frameRate(100);
  minim = new Minim(this);
  BGM = minim.loadFile("PerituneMaterial_Ohayashi_loop.mp3");
  BGM.loop();
  SE1 = minim.loadFile("決定ボタンを押す34.mp3");
  SE2 = minim.loadFile("決定ボタンを押す24.mp3");
}

void draw(){
  background(100,100,255);
  
  //マウスカーソルの非表示
  noCursor();
  
  if(fish1X == target1X || fish1Y == target1Y){  //次の目的地を作成1
      target1X = destinationX(mode1);
      target1Y = destinationY(mode1);
      distance1X = calcDistanceX(fish1X, target1X);
      distance1Y = calcDistanceY(fish1Y, target1Y);
  }
  if(fish2X == target2X || fish2Y == target2Y){  //次の目的地を作成2
      target2X = destinationX(mode2);
      target2Y = destinationY(mode2);
      distance2X = calcDistanceX(fish2X, target2X);
      distance2Y = calcDistanceY(fish2Y, target2Y);
  }
  if(fish3X == target3X || fish3Y == target3Y){  //次の目的地を作成3
      target3X = destinationX(mode3);
      target3Y = destinationY(mode3);
      distance3X = calcDistanceX(fish3X, target3X);
      distance3Y = calcDistanceY(fish3Y, target3Y);
  }
  if(fish4X == target4X || fish4Y == target4Y){  //次の目的地を作成4
      target4X = destinationX(mode4);
      target4Y = destinationY(mode4);
      distance4X = calcDistanceX(fish4X, target4X);
      distance4Y = calcDistanceY(fish4Y, target4Y);
  }
  if(fish5X == target5X || fish5Y == target5Y){  //次の目的地を作成5
      target5X = destinationX(mode5);
      target5Y = destinationY(mode5);
      distance5X = calcDistanceX(fish5X, target5X);
      distance5Y = calcDistanceY(fish5Y, target5Y);
  }
  
  //reacTIVision
  float obj_size=object_size*scale_factor;
  
  ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();
  for (int i=0;i<tuioObjectList.size();i++) {
     TuioObject tobj = tuioObjectList.get(i);
     pushMatrix();
     translate(width - tobj.getScreenX(width),tobj.getScreenY(height));
     fill(255);
     ellipse(0,0,obj_size+50,obj_size+50);
     popMatrix();
     GET(width - tobj.getScreenX(width),tobj.getScreenY(height));
  }
   
  //Fish1泳ぐ
  if(mode1 == 0){
    pushMatrix();
    rotate(0);
    translate(fish1X, fish1Y);  //原点を魚にする。
    radian1 = calcAngle(fish1X, fish1Y, target1X, target1Y, distance1X, distance1Y);
    if(angle1 < int(degrees(radian1))){
      angle1++;
    }else if(angle1 > int(degrees(radian1))){
      angle1--;
    }else{
      if(fish1X > target1X){
        fish1X--;
      }else if(fish1X < target1X){
        fish1X++;
      }
      if(fish1Y > target1Y){
        fish1Y--;
      }else if(fish1Y < target1Y){
        fish1Y++;
      }
    }
    imageMode(CENTER);
    rotate(radians(90+angle1));
    image(img, 0, 0);
    popMatrix();
  }
  
  //Fish2泳ぐ
  if(mode2 == 0){
    pushMatrix();
    rotate(0);
    translate(fish2X, fish2Y);  //原点を魚にする。
    radian2 = calcAngle(fish2X, fish2Y, target2X, target2Y, distance2X, distance2Y);
    if(angle2 < int(degrees(radian2))){
      angle2++;
    }else if(angle2 > int(degrees(radian2))){
      angle2--;
    }else{
      if(fish2X > target2X){
        fish2X--;
      }else if(fish2X < target2X){
        fish2X++;
      }
      if(fish2Y > target2Y){
        fish2Y--;
      }else if(fish2Y < target2Y){
        fish2Y++;
      }
    }
    imageMode(CENTER);
    rotate(radians(90+angle2));
    image(img, 0, 0);
    popMatrix();
  }
  
  //Fish3泳ぐ
  if(mode3 == 0){
    pushMatrix();
    rotate(0);
    translate(fish3X, fish3Y);  //原点を魚にする。
    radian3 = calcAngle(fish3X, fish3Y, target3X, target3Y, distance3X, distance3Y);
    if(angle3 < int(degrees(radian3))){
      angle3++;
    }else if(angle3 > int(degrees(radian3))){
      angle3--;
    }else{
      if(fish3X > target3X){
        fish3X--;
      }else if(fish3X < target3X){
        fish3X++;
      }
      if(fish3Y > target3Y){
        fish3Y--;
      }else if(fish3Y < target3Y){
        fish3Y++;
      }
    }
    imageMode(CENTER);
    rotate(radians(90+angle3));
    image(img, 0, 0);
    popMatrix();
  }
  
  //Fish4泳ぐ
  if(mode4 == 0){
    pushMatrix();
    rotate(0);
    translate(fish4X, fish4Y);  //原点を魚にする。
    radian4 = calcAngle(fish4X, fish4Y, target4X, target4Y, distance4X, distance4Y);
    if(angle4 < int(degrees(radian4))){
      angle4++;
    }else if(angle4 > int(degrees(radian4))){
      angle4--;
    }else{
      if(fish4X > target4X){
        fish4X--;
      }else if(fish4X < target4X){
        fish4X++;
      }
      if(fish4Y > target4Y){
        fish4Y--;
      }else if(fish4Y < target4Y){
        fish4Y++;
      }
    }
    imageMode(CENTER);
    rotate(radians(90+angle4));
    image(img, 0, 0);
    popMatrix();
  }
  
  //Fish5泳ぐ
  if(mode5 == 0){
    pushMatrix();
    rotate(0);
    translate(fish5X, fish5Y);  //原点を魚にする。
    radian5 = calcAngle(fish5X, fish5Y, target5X, target5Y, distance5X, distance5Y);
    if(angle5 < int(degrees(radian5))){
      angle5++;
    }else if(angle5 > int(degrees(radian5))){
      angle5--;
    }else{
      if(fish5X > target5X){
        fish5X--;
      }else if(fish5X < target5X){
        fish5X++;
      }
      if(fish5Y > target5Y){
        fish5Y--;
      }else if(fish5Y < target5Y){
        fish5Y++;
      }
    }
    imageMode(CENTER);
    rotate(radians(90+angle5));
    image(img, 0, 0);
    popMatrix();
  }
  
  //ボウル
  pushMatrix();
  rotate(0);
  translate(150,height-150);
  fill(255, 255, 0);
  ellipse(0,0,300,300);
  popMatrix();
  
  //ボウルの後に描画することで手前に表示する。
  //fish1ボウルで泳ぐ
  if(mode1 == 1){
    pushMatrix();
    rotate(0);
    translate(fish1X, fish1Y);  //原点を魚にする。
    radian1 = calcAngle(fish1X, fish1Y, target1X, target1Y, distance1X, distance1Y);
    if(angle1 < int(degrees(radian1))){
      angle1++;
    }else if(angle1 > int(degrees(radian1))){
      angle1--;
    }else{
      if(fish1X > target1X){
        fish1X--;
      }else if(fish1X < target1X){
        fish1X++;
      }
      if(fish1Y > target1Y){
        fish1Y--;
      }else if(fish1Y < target1Y){
        fish1Y++;
      }
    }
    imageMode(CENTER);
    rotate(radians(90+angle1));
    image(img, 0, 0);
    popMatrix();
  }
  
  //fish2ボウルで泳ぐ
  if(mode2 == 1){
    pushMatrix();
    rotate(0);
    translate(fish2X, fish2Y);  //原点を魚にする。
    radian2 = calcAngle(fish2X, fish2Y, target2X, target2Y, distance2X, distance2Y);
    if(angle2 < int(degrees(radian2))){
      angle2++;
    }else if(angle2 > int(degrees(radian2))){
      angle2--;
    }else{
      if(fish2X > target2X){
        fish2X--;
      }else if(fish2X < target2X){
        fish2X++;
      }
      if(fish2Y > target2Y){
        fish2Y--;
      }else if(fish2Y < target2Y){
        fish2Y++;
      }
    }
    imageMode(CENTER);
    rotate(radians(90+angle2));
    image(img, 0, 0);
    popMatrix();
  }
  
  //fish3ボウルで泳ぐ
  if(mode3 == 1){
    pushMatrix();
    rotate(0);
    translate(fish3X, fish3Y);  //原点を魚にする。
    radian3 = calcAngle(fish3X, fish3Y, target3X, target3Y, distance3X, distance3Y);
    if(angle3 < int(degrees(radian3))){
      angle3++;
    }else if(angle3 > int(degrees(radian3))){
      angle3--;
    }else{
      if(fish3X > target3X){
        fish3X--;
      }else if(fish3X < target3X){
        fish3X++;
      }
      if(fish3Y > target3Y){
        fish3Y--;
      }else if(fish3Y < target3Y){
        fish3Y++;
      }
    }
    imageMode(CENTER);
    rotate(radians(90+angle3));
    image(img, 0, 0);
    popMatrix();
  }
  
  //fish4ボウルで泳ぐ
  if(mode4 == 1){
    pushMatrix();
    rotate(0);
    translate(fish4X, fish4Y);  //原点を魚にする。
    radian4 = calcAngle(fish4X, fish4Y, target4X, target4Y, distance4X, distance4Y);
    if(angle4 < int(degrees(radian4))){
      angle4++;
    }else if(angle4 > int(degrees(radian4))){
      angle4--;
    }else{
      if(fish4X > target4X){
        fish4X--;
      }else if(fish4X < target4X){
        fish4X++;
      }
      if(fish4Y > target4Y){
        fish4Y--;
      }else if(fish4Y < target4Y){
        fish4Y++;
      }
    }
    imageMode(CENTER);
    rotate(radians(90+angle4));
    image(img, 0, 0);
    popMatrix();
  }
  
  //fish5ボウルで泳ぐ
  if(mode5 == 1){
    pushMatrix();
    rotate(0);
    translate(fish5X, fish5Y);  //原点を魚にする。
    radian5 = calcAngle(fish5X, fish5Y, target5X, target5Y, distance5X, distance5Y);
    if(angle5 < int(degrees(radian5))){
      angle5++;
    }else if(angle5 > int(degrees(radian5))){
      angle5--;
    }else{
      if(fish5X > target5X){
        fish5X--;
      }else if(fish5X < target5X){
        fish5X++;
      }
      if(fish5Y > target5Y){
        fish5Y--;
      }else if(fish5Y < target5Y){
        fish5Y++;
      }
    }
    imageMode(CENTER);
    rotate(radians(90+angle5));
    image(img, 0, 0);
    popMatrix();
  }
  
  //ゲームクリア
  if(mode1 == 1 && mode2 == 1 && mode3 == 1 && mode4 == 1 && mode5 == 1){
    SE2.play();
    textSize(100);
    fill(255, 0, 0);
    text("Game Clear!!", width/2, height/2);
  }
}

//目的地を決定
int destinationX(int mode){
  int targetX;
  if(mode == 0){
    targetX = int(random(0,width));
  }else{
    targetX = int(random(50, 250));
  }
  return targetX;
}
int destinationY(int mode){
  int targetY;
  if(mode == 0){
    targetY = int(random(0,height));
  }else{
    targetY = int(random(height-250,height-50));
  }
  return targetY;
}

//金魚と目的地の2点から角度を求める
float calcAngle(int fishX,int fishY, int targetX, int targetY, int disX, int disY){
  if(fishX > targetX && fishY > targetY){
    disX = -targetX;
    disY = -targetY;
  }else if(fishX > targetX && fishY <= targetY){
    disX = -targetX;
    disY = targetY;
  }else if(fishX <= targetX && fishY > targetY){
    disX = targetX;
    disY = -targetY;
  }else{
    disX = targetX;
    disY = targetY;
  }
  float radian = atan2(disY, disX);  //原点と1点を結ぶ直線のX軸からの角度をラジアンで計算
  return radian;
}

//目的地と魚の距離を測定
int calcDistanceX(int fishX, int targetX){
  return int(abs(targetX - fishX));
}
int calcDistanceY(int fishY, int targetY){
  return int(abs(targetY - fishY));
}

//ゲット判定
void GET(float reacX, float reacY){
  float d1 = dist(reacX, reacY, fish1X, fish1Y);
  float d2 = dist(reacX, reacY, fish2X, fish2Y);
  float d3 = dist(reacX, reacY, fish3X, fish3Y);
  float d4 = dist(reacX, reacY, fish4X, fish4Y);
  float d5 = dist(reacX, reacY, fish5X, fish5Y);

  if (d1 < 30 && mode1 == 0) {
    SE1.rewind();
    SE1.play();
    mode1 = 1;
    fish1X = 150;
    fish1Y = height-150;
    target1X = 150;
    target1Y = height-150;
  } else if (d2<30 && mode2 == 0) {
    SE1.rewind();
    SE1.play();
    mode2 = 1;
    fish2X = 150;
    fish2Y = height-150;
    target2X = 150;
    target2Y = height-150;
  } else if (d3<30 && mode3 == 0) {
    SE1.rewind();
    SE1.play();
    mode3 = 1;
    fish3X = 150;
    fish3Y = height-150;
    target3X = 150;
    target3Y = height-150;
  } else if (d4<30 && mode4 == 0) {
    SE1.rewind();
    SE1.play();
    mode4 = 1;
    fish4X = 150;
    fish4Y = height-150;
    target4X = 150;
    target4Y = height-150;
  } else if (d5<30 && mode5 == 0) {
    SE1.rewind();
    SE1.play();
    mode5 = 1;
    fish5X = 150;
    fish5Y = height-150;
    target5X = 150;
    target5Y = height-150;
  }
}

// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  if (verbose) println("add obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  if (verbose) println("set obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
          +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  if (verbose) println("del obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// --------------------------------------------------------------
// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  if (verbose) println("add cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
  //redraw();
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
  if (verbose) println("set cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
          +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
  //redraw();
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  if (verbose) println("del cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
  //redraw()
}

// --------------------------------------------------------------
// called when a blob is added to the scene
void addTuioBlob(TuioBlob tblb) {
  if (verbose) println("add blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea());
  //redraw();
}

// called when a blob is moved
void updateTuioBlob (TuioBlob tblb) {
  if (verbose) println("set blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea()
          +" "+tblb.getMotionSpeed()+" "+tblb.getRotationSpeed()+" "+tblb.getMotionAccel()+" "+tblb.getRotationAccel());
  //redraw()
}

// called when a blob is removed from the scene
void removeTuioBlob(TuioBlob tblb) {
  if (verbose) println("del blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+")");
  //redraw()
}

// --------------------------------------------------------------
// called at the end of each TUIO frame
void refresh(TuioTime frameTime) {
  if (verbose) println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
  if (callback) redraw();
}
