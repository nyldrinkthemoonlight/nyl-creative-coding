World world;
// 生物数量限制
int MAX_PREYS = 100;
int MAX_PREDATORS = 20;
ArrayList<Creature>preys; // 猎物
ArrayList<Predator>predators; // 猎手

void setup() {
  size(1500, 1000);
  world = new World(20);
  smooth();
}

void draw() {
  background(0);
  world.run();
}
