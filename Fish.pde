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
boolean verbose = false; // print console debug messages
boolean callback = true; // updates only after callbacks
PImage img;
goldFish fish1;
goldFish fish2;
goldFish fish3;
goldFish fish4;
goldFish fish5;

//魚クラス
public class goldFish{
  String state;  //魚の状態（プールかボウルか）
  int x;         //魚のx座標
  int y;         //魚のy座標
  int angle;     //魚の向き
  int target_x;  //目的地のx座標
  int target_y;  //目的地のy座標
  float radian;  //魚が向くべき方向
  
  //コンストラクタ
  goldFish(String fish_state, int fish_x, int fish_y, int fish_angle, int dest_x, int dest_y, float rad){
    state = fish_state;
    x = fish_x;
    y = fish_y;
    angle = fish_angle;
    target_x = dest_x;
    target_y = dest_y;
    radian = rad;
  }
  
  void swim() {
    //目的地のxかyに到達したら新しい目的地を設定
    if (x == target_x || y == target_y) {
      target_x = destinationX(state);
      target_y = destinationY(state);
      radian = calcAngle(x, y, target_x, target_y);  //魚が向くべき方向を計算
    }

    //魚の方向調整
    if(angle < int(degrees(radian))) {
      angle++;
    }else if(angle > int(degrees(radian))) {
      angle--;
    }else{
      //もし魚が目的地方向を向いているなら移動する
      if (x > target_x) {
        x--;
      } else if (x < target_x) {
        x++;
      }
      if (y > target_y) {
        y--;
      } else if (y < target_y) {
        y++;
      }
    }
  }
  
  void drawFish(){
    pushMatrix();
    rotate(0);
    translate(x, y);
    imageMode(CENTER);
    rotate(radians(90 + angle));
    image(img, 0, 0);
    popMatrix();
  }
}

//目的地のx座標を決定
int destinationX(String state){
  int target_x;
  if(state.equals("pool")){
    target_x = int(random(0,width));
  }else{
    target_x = int(random(50, 250));                //ボウルの円より50pxだけ内側
  }
  return target_x;
}

//目的地のy座標を決定
int destinationY(String state){
  int target_y;
  if(state.equals("pool")){
    target_y = int(random(0,height));
  }else{
    target_y = int(random(height-250, height-50));  //ボウルの円より50pxだけ内側
  }
  return target_y;
}

//魚と目的地の2点から角度を求める
float calcAngle(int fish_x, int fish_y, int target_x, int target_y){
  int line_x = target_x - fish_x;
  int line_y = target_y - fish_y;
  return atan2(line_y, line_x);
}


//ゲット判定
void GET(float reacX, float reacY){
  goldFish[] fishes = {fish1, fish2, fish3, fish4, fish5};

  for (goldFish fish : fishes) {
    float range = dist(reacX, reacY, fish.x, fish.y);

    if (range < 30 && fish.state.equals("pool")) {
      SE1.rewind();
      SE1.play();
      fish.state = "bowl";
      fish.x = 150;
      fish.y = height - 150;
      fish.target_x = 150;
      fish.target_y = height - 150;
    }
  }
}

void setup(){
  fullScreen();
  img = loadImage("kingyo1.png");
  img.resize(100,0);
  tuioClient = new TuioProcessing(this);
  frameRate(60);
  minim = new Minim(this);
  BGM = minim.loadFile("PerituneMaterial_Ohayashi_loop.mp3");
  BGM.loop();
  SE1 = minim.loadFile("決定ボタンを押す34.mp3");
  SE2 = minim.loadFile("決定ボタンを押す24.mp3");
  noCursor();
  fish1 = new goldFish("pool", 300, 100, 0, 300, 100, 0);  //goldFish(金魚が泳ぐ場所, 金魚のx座標, 金魚のy座標, 金魚の角度, 目的地のx座標, 目的地のy座標, 金魚が向くべき方向)
  fish2 = new goldFish("pool", 800, 200, 0, 800, 200, 0);  //goldFish(金魚が泳ぐ場所, 金魚のx座標, 金魚のy座標, 金魚の角度, 目的地のx座標, 目的地のy座標, 金魚が向くべき方向)
  fish3 = new goldFish("pool", 1600, 700, 0, 1600, 700, 0);  //goldFish(金魚が泳ぐ場所, 金魚のx座標, 金魚のy座標, 金魚の角度, 目的地のx座標, 目的地のy座標, 金魚が向くべき方向)
  fish4 = new goldFish("pool", 1000, 600, 0, 1000, 600, 0);  //goldFish(金魚が泳ぐ場所, 金魚のx座標, 金魚のy座標, 金魚の角度, 目的地のx座標, 目的地のy座標, 金魚が向くべき方向)
  fish5 = new goldFish("pool", 1000, 900, 0, 1000, 900, 0);  //goldFish(金魚が泳ぐ場所, 金魚のx座標, 金魚のy座標, 金魚の角度, 目的地のx座標, 目的地のy座標, 金魚が向くべき方向)
}

void draw(){
  //プールの描画
  background(100,100,255);
  
  //ボウルの描画
  pushMatrix();
  rotate(0);
  translate(150, height-150);
  fill(255, 255, 0);
  ellipse(0,0,300,300);
  popMatrix();
  
  //reacTIVisionによる操作とポイの描画
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
  
  //魚の位置を更新
  fish1.swim();
  fish2.swim();
  fish3.swim();
  fish4.swim();
  fish5.swim();

  //魚を描画
  fish1.drawFish();
  fish2.drawFish();
  fish3.drawFish();
  fish4.drawFish();
  fish5.drawFish();
  
  //ゲームクリア
  if(fish1.state.equals("bowl") && fish2.state.equals("bowl") && fish3.state.equals("bowl") && fish4.state.equals("bowl") && fish5.state.equals("bowl")){
    SE2.play();
    textSize(100);
    fill(255, 255, 0);
    text("Game Clear!!", width/2, height/2);
    fill(255, 0, 0);
    text("Press \"Escape\" to exit", width-950, height-50);
  }
}

// --------------------------------------------------------------
// Tuioのモジュール（エラーメッセージ回避）
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
