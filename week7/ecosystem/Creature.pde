 class Creature {
  PVector position; // 位置
  PVector vel; // 速度
  DNA dna;          // DNA
  float health;     // 血量
  float MAX_HEALTH; // 总血量取决于大小
  float r; // 半径
  float maxspeed; // 越小最大速度越快
  float maxacc; // 越小加速度越快
  float reproduction_rate = 0.003; // 每帧繁殖概率
  color c;
  
  Creature(PVector l, DNA dna_) {
    position = l.copy();
    vel = new PVector(0,0);
    MAX_HEALTH = 200;
    health = MAX_HEALTH;
    dna = dna_;

    maxspeed = map(dna.genes[0], 0, 2, 5, 0);
    maxacc = map(dna.genes[0], 0, 0.5, 1.5, 0);
    r = map(dna.genes[0], 0, 1, 0, 50);
    c = color(109,227,187);
  }
 
  void run() {
    update();
    borders(); // 边界则出现在另一端
    display();
  }


  // 生殖
  Creature reproduce() {
    if (random(1) < reproduction_rate) {
      // Child is exact copy of single parent
      DNA childDNA = dna.copy();
      // Child DNA can mutate
      childDNA.mutate(0.1);
      return new Creature(new PVector(random(-width,width),random(-height,height)), childDNA); // 随机位置降低重叠
    }
    else {
      return null;
    }
  }

  void update() {
    PVector acc = find_dir().mult(maxacc);
    vel.add(acc);
    vel.limit(maxspeed);
    position.add(vel);
    // 死亡在逼近
    health -= 0.2;
  }

  void borders() {
    if (position.x < -r) position.x = width+r;
    if (position.y < -r) position.y = height+r;
    if (position.x > width+r) position.x = -r;
    if (position.y > height+r) position.y = -r;
  }

  void display() {
    ellipseMode(CENTER);
    stroke(0,health);
    fill(c, health/MAX_HEALTH*255);
    ellipse(position.x, position.y, r, r);
  }

  // 判断死亡
  boolean dead() {
    if (health < 0.0) {
      return true;
    }
    else {
      return false;
    }
  }
  
  // 逃跑方向， 方向为此猎物对每个捕食者反向的向量乘上相对距离的权重后的和
  // 如： 比较近的捕食者会对方向有较大影响
  PVector find_dir()
  {
    PVector dir = new PVector(0,0);
    for (Predator predator:predators)
    {
       PVector real_dist = real_dist(predator.position,position);
       dir.add(real_dist.normalize().mult(1/real_dist.mag()/real_dist.mag())); // in ratio with size
    }
    return dir.normalize();
  }

  // 真实相对位置, 考虑到画布另一端的物体，防止卡顿
  PVector real_dist(PVector vec1,PVector vec2)
  {
    float min_dist = MAX_FLOAT;
    PVector back = new PVector(0,0);
    for (int i=-1;i<2;i++)
    {
      for (int j=-1;j<2;j++)
      {
        PVector ppos = PVector.add(vec1,new PVector(i*width,j*height));
        if (PVector.dist(ppos,vec2)<min_dist)
        {
          min_dist = PVector.dist(ppos,vec2);
          back = PVector.sub(ppos,vec2);
        }
      }
    }
    return back;
  }
}
