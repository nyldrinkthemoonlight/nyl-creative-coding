class Tree
{
  static final float LW_RATIO = 20;
  static final float ROOT_LEAF_RATIO = 0.85;
  float END_LENGTH;
  ArrayList<Branch> branches;
  PVector pos;
  float w; // width of the trunk
  float nrad1=0,nrad2=0;

  Tree(PVector _pos, float _w)
  {
    pos = _pos.copy();
    w = _w;
    branches = new ArrayList();
    branches.add(new Branch(pos,w*LW_RATIO,PI/2));
    END_LENGTH = w*4;
  }
  
  void render()
  {
    int size = branches.size();
    for (int i=0;i<size;i++)
    {
      Branch branch = branches.get(i);
      branch.render();
      if (branch.splitting)
      {
        branch.splitting = false;
        if (branch.length>END_LENGTH)split(branch);
        else
        {
          branch.is_end = true;
        }
      }
    }
  }
  
// split 1 or 2 new branches
  void split(final Branch root)
  {
      new_angle(root.rad);
      branches.add(new Branch(root.end,
      g_length(root.length,nrad1),nrad1));
      branches.add(new Branch(root.end,
      g_length(root.length,nrad2),nrad2));
  }
  
  float g_length(float base,float nrad)
  {
    float ref=map(abs(nrad-PI/2),PI,0,0.4*base,ROOT_LEAF_RATIO*base); //<>//
    float gauss = constrain((float)rand.nextGaussian()*0.3*base+ref,
    ref*0.9,min(base,ref*1.4));
    return gauss;
  }
  
  void new_angle(final float orad)
  {
     final float range = PI/4;
     nrad1 = orad+map(rand.nextFloat(),0,1,-range,0);
     nrad2 = orad+map(rand.nextFloat(),0,1,0,range);
  }
};
