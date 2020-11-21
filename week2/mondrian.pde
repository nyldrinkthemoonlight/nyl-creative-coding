void setup()
{
	size(1024,1024);
	background(loadImage("cao.jpg")); 
	draw_invert_rec(200,200,300,300,178,100,100);
  draw_invert_rec(200,50,150,150,0,0,100);
  draw_invert_rec(350,50,200,150,274,100,100);
	draw_invert_rec(200,500,100,500,178,100,0);
	draw_invert_rec(550,50,100,200,0,0,100);
  draw_invert_rec(500,200,50,200,0,0,100);
	draw_invert_rec(600,300,150,100,178,100,100);
  draw_invert_rec(550,250,100,50,178,100,0);
	draw_invert_rec(400,700,200,100,178,100,100);
	draw_invert_rec(650,750,200,200,66,100,100);
  draw_invert_rec(550,300,50,100,66,100,100);
  draw_invert_rec(300,500,100,300,274,100,100);
  draw_invert_rec(400,500,100,100,66,100,100);
  draw_invert_rec(300,800,250,200,0,0,100);
  draw_invert_rec(500,400,300,300,274,100,100);
  draw_invert_rec(550,800,100,200,0,0,100);
  draw_invert_rec(600,700,50,100,66,100,100);
  draw_invert_rec(650,700,200,50,0,100,0);
  draw_invert_rec(650,100,100,50,66,100,100);  
  draw_invert_rec(650,150,100,150,66,0,100); 
  draw_invert_rec(750,100,50,300,274,0,100);
}

void draw_invert_rec(final int px, final int py, final int x, final int y,final int  h,final int s,final int b)
{
	colorMode(HSB,360,100,100);
	color c = color(h,s,b); // get color input
	color c_inverse = color(h + 180,s,b); // get inverse color
	
	for (int i = px;i < px + x;i++)
	{
		for (int j = py;j < py + y;j++)
		{
			color c_bg = get(i,j);
			// color stores as int, the hex of rgb
			if (c_bg >= #CCCCCC)
			{
				fill(c);
				noStroke();
				rect(i,j,1,1);
			}
			else 
			{
				fill(c_inverse);
				noStroke();
				rect(i,j,1,1);
			}
		}
		// rect(0, 0, x, y);
	}
	
		noFill();
		stroke(0);
		strokeWeight(10);
		rect(px,py,x,y);
}
