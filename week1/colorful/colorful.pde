void setup() {
  size(1000, 1000);
  background(255);
}

void draw() {
} // Empty draw() keeps the program running

void mousePressed() {
  rect_or_circ();
}

void rect_or_circ()
{
  fill(int(random(255)),int(random(255)),int(random(255)), 102);
  if (random(3)>1){
      rect(mouseX, mouseY, 300, 300);
  }else{
  ellipse(mouseX,mouseY,300,300);
}
}
