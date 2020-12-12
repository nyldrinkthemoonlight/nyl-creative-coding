class Particle{
	PVector loc,speed,acc;//位置，速度，加速度
	color col;
	float rad;
	float maxVel = 2.0;//粒子最大速度
	float w = 500.0;
	float h = 500.0;
	float f = 1000.0;
	//构造函数
	Particle(PVector _loc,PVector _speed,PVector _acc) {
		loc = _loc;
		speed = _speed;
		acc = _acc;
	}
	Particle() {
		loc = new PVector(random(width * 1.2),random(height));
		rad = random(TWO_PI);
		speed = new PVector(0,0);
		acc = new PVector(cos(rad),sin(rad));
	}
	void move() {		
		rad = random(2*PI);
		acc.set(cos(rad),sin(rad));
		if (mousePressed)
		{
			float d = dist(mouseX, mouseY, loc.x, loc.y);
			PVector repulse = new PVector(loc.x - mouseX,loc.y - mouseY);
			repulse.normalize();
			repulse.mult(100 / d);
			acc.add(repulse);
		}
		speed.add(acc);
		if (speed.magSq()>maxVel) {
			speed.normalize();
			speed.mult(maxVel);
		}
		loc.add(speed);
	}
	void checkEdges() {
		if (loc.x < 0 || loc.x > width || loc.y < 0 || loc.y > height) {
			loc.x = random(width * 1.2);
			loc.y = random(height);
		}
	}
	void render() {
		//ellipse(loc.x,loc.y,2,2);
    stroke(0);
    point(loc.x,loc.y);
	}
	void run() {
		move();
		checkEdges();
		render();
	}
}

//粒子数
int num = 15000;
//存放粒子的数组
Particle[] particles = new Particle[num];

void setup() {
	size(1024, 768,P3D);
	noStroke();
	//迭代生成所有粒子
	for (int i = 0; i < num; i++) {
		PVector loc = new PVector(random(width * 1.2), random(height));
		float rad = random(TWO_PI);
		PVector speed = new PVector(0, 0);
		PVector acc = new PVector(cos(rad), sin(rad));
		particles[i] = new Particle(loc, speed, acc);
	}
}

void draw() {
	//半透明背景
	fill(255, 10);
	noStroke();
	rect(0, 0, width, height);
	fill(17,0,125);
	//遍历数组，每一个粒子都run起来
	for (int i = 0; i < particles.length; i++) {
		particles[i].run();
	}
}
