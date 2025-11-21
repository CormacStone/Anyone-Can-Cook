//Trace Kinghorn, Maxwell Johnson + Kolby Green
class Menu {
  int x, y, w, h;
  Menu() {
    x=width/2;
    y=height/2;
    w=25;
    h=75;
  }
  void display() {
    rect(x, y, w, h);
  }
  void hover() {
  }
  //Trace Kinghorn
  void startScreen() {
    textAlign(CENTER);
    text("Start Screen: filler edition", width/2, 100);
    btnStart.display();
  }
  //Maxwell Johnson
  void endScreen() {
    background(1);
    fill(255);
    textSize(100);
    textAlign(CENTER);
    text("You dumb",width/2, height/2);
  }
  //Kolby Green
  void pauseScreen() {
    background(0);
  textAlign(CENTER);
  textSize(100);
  fill(255);
  text("Pause", 300,200);
  btnSettings.display();
  btnSave.display();
  btnPlay.display();
  }
}
