Sentence[] ss;

void setup()
{
	size(1500,1000);
	PVector p = new PVector(100,100);
	ss = new Sentence[1];
	ss[0] = new Sentence(p,"SJTU",50);
	//p = new PVector(100,350);
	//ss[1] = new Sentence(p,"a rebel",30);
	//p = new PVector(100,600);
	//ss[2] = new Sentence(p,"just for",30);
	//p = new PVector(100,850);
	//ss[3] = new Sentence(p,"kicks",30);
}

void draw()
{
	background(0,0,100);
	for (int i = 0;i < ss.length;i++)
	{
		ss[i].draw();
	}
}


class ColorBall
{
	PVector pos; // position of the ball
	float max_size; // max_size
	float size_rate; // 目前和最大size缩放比， 1 代表最大size
	// 记录球的状态， 1 代表在放大，-1代表在缩小
	private int rise_flag = 1; // 1 for up, -1 for down
	private final float SIZE_CHANGE_STEP = 0.01; // 每次修改多少的步长
	
	// h s b alpha通道的分量 最大值：180 100 100 100
	private int c_h;
	private final int c_s = 100;
	private final int c_b = 100;
	private final int c_a = 100;
	// 构造器
	ColorBall(PVector _p,float _size)
	 {
		pos = _p;
		max_size = _size;
		size_rate = random(1); // 随机一个size
		c_h = floor(random(180)); // 随机一个颜色
	}
	
	void draw()
	 {
		colorMode(HSB,180,100,100);
		fill(c_h,c_s,c_b,c_a);
		noStroke();
		ellipse(pos.x,pos.y,size_rate * max_size,size_rate * max_size);
		// 每次循环结束修改大小
		change_size();
	}
	
	void change_color()
	 {
		//if (c_h!=180)
		//{
		//  c_h++;
		//}
		//else
		//{
		//  c_h=0;
		//}
		while(c_h>180)
		{
			c_h -=180;
		}
		c_h += 50;
	}
	
	void change_size()
	 {
		if (size_rate > 1)
		{
			// 如果太大了 就调整为1并且球的变化状态为缩小
			size_rate = 1;
			rise_flag = - 1;
		}
		else if (size_rate < 0)
		{
			// 太小了就设成0并且球的变化状态为放大
			size_rate = 0;
			rise_flag = 1;
			change_color();
		}
		// 修改球的size_rate, 大小为step乘上变化状态(1 or -1)
		size_rate += SIZE_CHANGE_STEP * rise_flag;
	}
}

class Letter
{
	PVector pos;
	char lett; // 存储表示的字符
	static final float BALL_SIZE = 50; // 每个球的大小
	int size;// 字号大小
	float multiplier; // 最后创建球时乘上的系数
	int w = 4; // 字符宽度 一般是4
	ColorBall[] balls; // 存储球的数组
	
	Letter(PVector _p,char _c,int font_size)
	{
		pos = _p;
		lett = _c;
		size = font_size;
		multiplier = BALL_SIZE * size / 50; // 50 为标准字号
		init();
	}
	
	void init()
	{
		// 根据lett初始化balls数组
		// <spcace>,a,b,c,e,f,i,j,k,l,m,o,r,s,t,u
		switch(lett)
		{
			case ' ' : // 空格就不创建球, 修改w为3，相当于占位符
			balls = new ColorBall[0]; // 防止空值
			w = 3;
			break;
			
			case 'a':
			balls = new ColorBall[12];
			balls[0] = cb_helper(1,0);
			balls[1] = cb_helper(2,0);
			balls[2] = cb_helper(0,1);
			balls[3] = cb_helper(3,1);
			balls[4] = cb_helper(0,2);
			balls[5] = cb_helper(1,2);
			balls[6] = cb_helper(2,2);
			balls[7] = cb_helper(3,2);
			balls[8] = cb_helper(0,3);
			balls[9] = cb_helper(3,3);
			balls[10] = cb_helper(0,4);
			balls[11] = cb_helper(3,4);
			break;
			
			case 'b':
			balls = new ColorBall[13];
			balls[0] = cb_helper(0,0);
			balls[1] = cb_helper(1,0);
			balls[2] = cb_helper(2,0);
			balls[3] = cb_helper(0,1);
			balls[4] = cb_helper(3,1);
			balls[5] = cb_helper(0,2);
			balls[6] = cb_helper(1,2);
			balls[7] = cb_helper(2,2);
			balls[8] = cb_helper(0,3);
			balls[9] = cb_helper(3,3);
			balls[10] = cb_helper(0,4);
			balls[11] = cb_helper(1,4);
			balls[12] = cb_helper(2,4);
			break;
			
			case 'c':
			balls = new ColorBall[9];
			balls[0] = cb_helper(1,0);
			balls[1] = cb_helper(2,0);
			balls[2] = cb_helper(3,0);
			balls[3] = cb_helper(0,1);
			balls[4] = cb_helper(0,2);
			balls[5] = cb_helper(0,3);
			balls[6] = cb_helper(1,4);
			balls[7] = cb_helper(2,4);
			balls[8] = cb_helper(3,4);
			break;
			
			case 'e':
			balls = new ColorBall[14];
			balls[0] = cb_helper(0,0);
			balls[1] = cb_helper(1,0);
			balls[2] = cb_helper(2,0);
			balls[3] = cb_helper(3,0);
			balls[4] = cb_helper(0,1);
			balls[5] = cb_helper(0,2);
			balls[6] = cb_helper(1,2);
			balls[7] = cb_helper(2,2);
			balls[8] = cb_helper(3,2);
			balls[9] = cb_helper(0,3);
			balls[10] = cb_helper(0,4);
			balls[11] = cb_helper(1,4);
			balls[12] = cb_helper(2,4);
			balls[13] = cb_helper(3,4);
			break;
			
			case 'f':
			balls = new ColorBall[9];
			balls[0] = cb_helper(0,0);
			balls[1] = cb_helper(1,0);
			balls[2] = cb_helper(2,0);
			balls[3] = cb_helper(0,1);
			balls[4] = cb_helper(0,2);
			balls[5] = cb_helper(1,2);
			balls[6] = cb_helper(2,2);
			balls[7] = cb_helper(0,3);
			balls[8] = cb_helper(0,4);
			w = 3;
			break;
			
			case 'i':
			balls = new ColorBall[9];
			balls[0] = cb_helper(0,0);
			balls[1] = cb_helper(1,0);
			balls[2] = cb_helper(2,0);
			balls[3] = cb_helper(1,1);
			balls[4] = cb_helper(1,2);
			balls[5] = cb_helper(1,3);
			balls[6] = cb_helper(0,4);
			balls[7] = cb_helper(1,4);
			balls[8] = cb_helper(2,4);
			w = 3;
			break;
			
			case 'j':
			balls = new ColorBall[8];
			balls[0] = cb_helper(1,0);
			balls[1] = cb_helper(2,0);
			balls[2] = cb_helper(3,0);
			balls[3] = cb_helper(2,1);
			balls[4] = cb_helper(2,2);
			balls[5] = cb_helper(0,3);
			balls[6] = cb_helper(2,3);
			balls[7] = cb_helper(1,4);
			break;
			
			case 'k':
			balls = new ColorBall[11];
			balls[0] = cb_helper(0,0);
			balls[1] = cb_helper(2,0);
			balls[2] = cb_helper(0,1);
			balls[3] = cb_helper(1,1);
			balls[4] = cb_helper(0,2);
			balls[5] = cb_helper(1,2);
			balls[6] = cb_helper(2,2);
			balls[7] = cb_helper(0,3);
			balls[8] = cb_helper(1,3);
			balls[9] = cb_helper(0,4);
			balls[10] = cb_helper(2,4);
			w = 3;
			break;
			
			case 'l':
			balls = new ColorBall[7];
			balls[0] = cb_helper(0,0);
			balls[1] = cb_helper(0,1);
			balls[2] = cb_helper(0,2);
			balls[3] = cb_helper(0,3);
			balls[4] = cb_helper(0,4);
			balls[5] = cb_helper(1,4);
			balls[6] = cb_helper(2,4);
			w = 3;
			break;
			
			case 'm':
			balls = new ColorBall[13];
			balls[0] = cb_helper(0,0);
			balls[1] = cb_helper(4,0);
			balls[2] = cb_helper(0,1);
			balls[3] = cb_helper(1,1);
			balls[4] = cb_helper(3,1);
			balls[5] = cb_helper(4,1);
			balls[6] = cb_helper(0,2);
			balls[7] = cb_helper(2,2);
			balls[8] = cb_helper(4,2);
			balls[9] = cb_helper(0,3);
			balls[10] = cb_helper(4,3);
			balls[11] = cb_helper(0,4);
			balls[12] = cb_helper(4,4);
			w = 5;
			break;
			
			case 'o':
			balls = new ColorBall[10];
			balls[0] = cb_helper(1,0);
			balls[1] = cb_helper(2,0);
			balls[2] = cb_helper(0,1);
			balls[3] = cb_helper(3,1);
			balls[4] = cb_helper(0,2);
			balls[5] = cb_helper(3,2);
			balls[6] = cb_helper(0,3);
			balls[7] = cb_helper(3,3);
			balls[8] = cb_helper(1,4);
			balls[9] = cb_helper(2,4);
			break;
			
			case 'r':
			balls = new ColorBall[12];
			balls[0] = cb_helper(0,0);
			balls[1] = cb_helper(1,0);
			balls[2] = cb_helper(2,0);
			balls[3] = cb_helper(0,1);
			balls[4] = cb_helper(3,1);
			balls[5] = cb_helper(0,2);
			balls[6] = cb_helper(1,2);
			balls[7] = cb_helper(2,2);
			balls[8] = cb_helper(0,3);
			balls[9] = cb_helper(2,3);
			balls[10] = cb_helper(0,4);
			balls[11] = cb_helper(3,4);
			break;
			
			case 's' : 
			balls = new ColorBall[10]; 
			balls[0] = cb_helper(1,0); 
			balls[1] = cb_helper(2,0); 
			balls[2] = cb_helper(3,0); 
			balls[3] = cb_helper(0,1); 
			balls[4] = cb_helper(1,2); 
			balls[5] = cb_helper(2,2); 
			balls[6] = cb_helper(3,3); 
			balls[7] = cb_helper(0,4); 
			balls[8] = cb_helper(1,4); 
			balls[9] = cb_helper(2,4);
			break;
			
			case 't':
			balls = new ColorBall[8];
			balls[0] = cb_helper(0,0);
			balls[1] = cb_helper(1,0);
			balls[2] = cb_helper(2,0);
			balls[3] = cb_helper(3,0);
			balls[4] = cb_helper(1.5,1);
			balls[5] = cb_helper(1.5,2);
			balls[6] = cb_helper(1.5,3);
			balls[7] = cb_helper(1.5,4);
			break;
			
			case 'u':
			balls = new ColorBall[10];
			balls[0] = cb_helper(0,0);
			balls[1] = cb_helper(3,0);
			balls[2] = cb_helper(0,1);
			balls[3] = cb_helper(3,1);
			balls[4] = cb_helper(0,2);
			balls[5] = cb_helper(3,2);
			balls[6] = cb_helper(0,3);
			balls[7] = cb_helper(3,3);
			balls[8] = cb_helper(1,4);
			balls[9] = cb_helper(2,4);
			break;
		}
	}
	
	void draw()
	 {
	//  每个都画一遍
		for (int i = 0;i < balls.length;i++)
		{
			balls[i].draw();
		}
	}
	
	// 帮助画球，减少需要写的参数
	private ColorBall cb_helper(float x,float y)
	{
		return new ColorBall(new PVector(x * multiplier + pos.x,y * multiplier + pos.y),multiplier);
	}
}

class Sentence
{
	Letter[] letters; // 存储字符
	String content; // 存储需要写的字符串
	PVector pos; // 位置
	int space = 1;// 字符间的空格
	int size; // 字号
	
	Sentence(PVector _p, String _content,int _size)
	{
		pos = _p;
		content = _content;
		content = content.toLowerCase();
		size = _size;
		init();
	}
	
	// 根据content的内容初始化letters数组
	void init()
	{
		letters = new Letter[content.length()];
		PVector _pos = pos;
		for (int i = 0;i < letters.length;i++)
		{
			// 用content的第i个字符初始化
			letters[i] = new Letter(_pos,content.charAt(i),size);
			// 距离增加字符的宽度+字符间的间距
			_pos.x += (letters[i].w + space) * letters[i].multiplier;
		}
	}
	
	void draw()
	{
		for (int i = 0;i < letters.length;i++)
		{
			letters[i].draw();
		}
	}
}
