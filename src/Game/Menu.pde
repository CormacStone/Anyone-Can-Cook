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
  void startScreen() {
  }
  void endScreen() {
    background(1);
    fill(255);
    textSize(100);
    textAlign(CENTER);
    text("You dumb",width/2, height/2);
  }
  void pauseScreen() {
  }
}
