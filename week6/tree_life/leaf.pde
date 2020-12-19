class Leaf{
  static final int ALPH=50;
  static final int MAX_LIFE = 200;
  static final int HALF_LIFE = MAX_LIFE/2;
  int[] c_green = {93,74,58};
  int[] c_yellow = {52,84,93};
  PVector pos;
  PVector vel;
  float size;
  float step;
  int life=MAX_LIFE;
  
  Leaf(PVector _pos, float _size)
  {
    pos = _pos;
    vel = new PVector(0,0);
    size = 0;
    step = _size/HALF_LIFE;
  }
  void render()
  {
    colorMode(HSB,360,100,100,100);
    noStroke();
    choose_color();
    ellipse(pos.x,pos.y,size,size);
    colorMode(RGB,255,255,255);
    update();
  }
  void choose_color()
  {
    if (life>HALF_LIFE) fill(c_green[0],c_green[1],c_green[2],ALPH);
    else if (life>0) fill(map(life,0,HALF_LIFE,c_yellow[0],c_green[0]),
                            map(life,0,HALF_LIFE,c_yellow[1],c_green[1]),
                            map(life,0,HALF_LIFE,c_yellow[2],c_green[2]),ALPH);
    else fill(c_yellow[0],c_yellow[1],c_yellow[2],ALPH);
    colorMode(RGB);
  }
  void update()
  {
    if (life>0) life=life-1;
    if (life>HALF_LIFE) size = size+step;
    if (life==0) vel.add(new PVector(0,0.1));
    pos.add(vel);
  }
};
