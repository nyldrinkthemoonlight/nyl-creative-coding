import java.util.*;
Random rand;
Tree test;
ArrayList<Tree> trees;
PVector g = new PVector(0,1);
void setup()
{
  size(1920,800);
  rand = new Random();
  //rand.setSeed()
  trees = new ArrayList<Tree>();
  trees.add(new Tree(new PVector(200,height),4));
  trees.add(new Tree(new PVector(width/2,height),3));
  trees.add(new Tree(new PVector(1200,height),5));
    trees.add(new Tree(new PVector(1400,height),4 ));

}

void draw()
{
  background(255);
  for (Tree tree:trees) tree.render();
}
