class World {

  World(int num) {
    preys = new ArrayList<Creature>();
    for (int i = 0; i < num; i++) {
      PVector l = new PVector(random(width),random(height));
      DNA dna = new DNA();
      preys.add(new Creature(l,dna));
    }
    predators = new ArrayList<Predator>();
    for (int i=0;i < num/4;i++){
      PVector l = new PVector(random(width),random(height));
      DNA dna = new DNA();
      predators.add(new Predator(l,dna));
    }
  }

  void run() {
    
    for (int i = preys.size()-1; i >= 0; i--) {
      Creature b = preys.get(i);
      b.run();
      // 死亡
      if (b.dead()){
        preys.remove(i);
      }
      // 繁殖
      Creature child = b.reproduce();
      if (child != null && preys.size()<MAX_PREYS) preys.add(child);
    }
    for (int i = predators.size()-1; i >= 0; i--) {
      Predator b = predators.get(i);
      b.run();
      if (b.dead()){
        predators.remove(i);
      }
      // 检查是否吃到猎物
      for (int j=preys.size()-1;j>=0;j--)
      {
        b.eat(preys.get(j));
      }
    }
  }
}
