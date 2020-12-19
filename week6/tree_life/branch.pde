class Branch{
  static final float GROW_RATE = 0.02; // rate of grow
  /** VARS **/
  PVector start;
  PVector end;
  PVector step;
  float length;
  float rad;
  boolean is_growing = true;
  boolean splitting = false;
  boolean is_end = false;
  Leaf leaf;
  /** CONSTRUCTORS **/
  Branch(PVector _pos,float _length,float _rad)
  {
    setup(_pos,_length,_rad);
  }
  void setup(PVector _pos,float _length,float _rad)
  {
    start = _pos.copy();
    end = _pos.copy();
    length = _length;
    rad = _rad;
    step = PVector.fromAngle(rad).mult(-1*GROW_RATE*length);
    leaf = new Leaf(PVector.add(start,PVector.fromAngle(_rad).mult(-1*_length)),_length);
  }
  
  void render()
  {
    if (is_end) leaf.render();
    colorMode(RGB,255,255,255);
    stroke(0);
    strokeWeight(length*0.2);
    fill(0);
    line(start.x,start.y,end.x,end.y);
    if (is_growing) end = PVector.add(end,step); // grow
    else return;

    if (PVector.dist(start,end)>=length)
    {
      is_growing = false; // check grow stop
      splitting = true;
    }
  }
};
