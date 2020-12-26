class Predator extends Creature // 猎手也是生物
{
  int cd = 0; // 捕食存在cd
  Creature target; // 目标猎物
  float reproduction_rate = 0.5; // 吃到猎物后有概率繁殖
  Predator(PVector l, DNA dna_)
  {
    super(l,dna_);
    c = color(109,0,158);
    target = null;
    MAX_HEALTH = map(dna.genes[0],0,1,0,200);
    health = MAX_HEALTH;
  }
  // 判断是否捕捉到猎物
  boolean contains(Creature prey)
  {
    if (PVector.dist(prey.position,position)<(prey.r+r)/2) return true;
    else return false;
  }
  void eat(Creature prey)
  {
    if (contains(prey)) // 如果捉到
    {
      if (cd<=0) // 如果要吃东西
      {
        // 扣血，小捕食者咬一口掉血少
        prey.health -= prey.health*min(1,r/prey.r);
        Predator child = reproduce(); // 生成新捕食者
        if (child != null && predators.size()<MAX_PREDATORS) predators.add(child);
        target = null; // 清空目标以寻找下一个
        cd = 10; // 设置贤者时间
      }
    }
  }
  PVector find_target()
  {
    if (target == null) // 如果为空，随机寻找下一个猎物
    {
      if (preys.size()==0){cd = MAX_INT;return new PVector(0,0);} // 没有猎物了则停止
      target = preys.get((int)random(preys.size()));
    }
    return real_dist(target.position,position); // 返回与目标的距离向量
  }
  
  void update() {
    PVector acc = find_target().mult(maxacc);
    vel.add(acc);
    vel.limit(maxspeed); // 设置最大速度
    if (cd>0) vel.mult(0);
    position.add(vel);
    health -= 0.2;
    cd--;
    if (target==null || target.dead()) target = null; // 如果目标死亡则清空
  }
  Predator reproduce() {
    if (random(1) < reproduction_rate) {
      DNA childDNA = dna.copy();
      childDNA.mutate(0.1);
      return new Predator(position, childDNA);
    }
    else {
      return null;
    }
  }
}
