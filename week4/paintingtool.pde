Panel panel;
boolean lock = false;
void setup()
{
	size(1000,1000);
	background(255);
	//Circle c = new Circle(new PVector(500,500),100,color(255,0,0,100)); 
	//s = new HoverCircle(new PVector(500,500),200,color(255,0,0));
	panel = new Panel();
}

void draw()
{
	// background(255,0,0);
	panel.draw();
}

void mouseReleased() {
	lock = false; // release the locker
}

color change_alpha(color c,int alpha)
{
	return color(c>>16 & 0xFF,c>>8 & 0xFF,c & 0xFF,alpha);
}

class Shape
{
	PVector pos;
	color c;
	Shape(PVector _pos,color _c)
	{
		pos = _pos;
		c = _c;
	}
	void draw()
	{
		fill(c);
		noStroke();
	}
	/// Hover
	// boolean onHover(){}
	// boolean onPress(){}
	// boolean onClick(){}
}

class Square extends Shape
{
	int w,h; // 长宽
	Square(PVector _pos,int _w,int _h,color _c)
	 {
		super(_pos,_c);
		w = _w;
		h = _h;
	}
	void draw()
	{
		super.draw();
		rectMode(CENTER);  
		rect(pos.x ,pos.y,w ,h);
	}
}

class Circle extends Shape
{
	int r; // 半径 
	Circle(PVector _pos,int _r,color _c)
	 {
		super(_pos,_c);
		r = _r;
	}
	void draw()
	 {
		super.draw();
		ellipse(pos.x ,pos.y,2 * r ,2 * r);
	}
}

class HoverSquare extends Square
{
	HoverSquare(PVector _pos,int _w,int _h,color _c)
	 {
		super(_pos,_w,_h,_c);
	}
	boolean onHover()
	 {
		//  判断鼠标位置是否在图形上
		if (mouseX >= pos.x - w / 2 && mouseX <= pos.x + w / 2  // x
			&& mouseY >= pos.y - h / 2 && mouseY <= pos.y + h / 2) // y
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	boolean onPress()
	{
		return onHover() && mousePressed;
	}
	void draw()
	{
		super.draw();
	}
	void draw(boolean has_stroke)
	{
		if (has_stroke)
		{
			rectMode(CENTER);
			stroke(0);
			strokeWeight(1);
			fill(c);
			rect(pos.x ,pos.y,w ,h);
		}
		else {super.draw();}
	}
}

class HoverCircle extends Circle
{
	HoverCircle(PVector _pos,int _r,color _c)
	 {
		super(_pos,_r,_c);
	}
	boolean onHover()
	 {
		//  判断鼠标位置是否在图形上
		float d = dist(pos.x, pos.y, mouseX, mouseY);
		if (d <= r)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	boolean onPress()
	{
		return onHover() && mousePressed;
	}
}

class HoverButton extends HoverCircle
{
	PImage icon;
	static final int BASE_SIZE = 10;
	static final float RATE = 0.6,RATE_HOVER = 0.7,RATE_PRESS = 0.5;
	int asize; // 绝对大小
	HoverButton(PVector _pos,float size,String icon_path)
	{
		super(_pos,(int)(BASE_SIZE * size) / 2,color(255)); // 白圆
		asize = (int)(BASE_SIZE * size);
		icon = loadImage(icon_path);
	}
	void draw()
	 {
		if (!lock)
		{
			//	清空区域颜色
			fill(255);
			rectMode(CENTER);
			noStroke();
			rect(pos.x,pos.y,asize,asize);
			
			if (onPress())
			{
				image(icon ,pos.x - RATE_PRESS * asize / 2,pos.y - RATE_PRESS * asize / 2,RATE_PRESS * asize ,RATE_PRESS * asize);
			}
			else if (onHover())
			{
				image(icon ,pos.x - RATE_HOVER * asize / 2 ,pos.y - RATE_HOVER * asize / 2,RATE_HOVER * asize ,RATE_HOVER * asize);
			}
			else
			{
				image(icon ,pos.x - RATE * asize / 2,pos.y - RATE * asize / 2,RATE * asize,RATE * asize);
			} 
		}
	}
}

class	Panel 
{
	HoverButton brush;
	private int brush_btn_counter = 0;
	boolean brush_has_locker = false;
	HoverButton rubber;
	HoverButton save;
	ScrollBar size_bar;
	ScrollBar op_bar;
	ColorPicker color_picker;
	ScrollBar saturation_picker;
	ScrollBar brightness_picker;
	HoverSquare[] palette;
	color[] palette_color;
	int cursor_state = 0; // 0 for none, 1 for brush
	int opacity = 255;
	static final int MAX_OPACITY = 255;
	color brush_color = color(0);
	int stroke_weight = 8;
	static final int MAX_STROKE_WEIGHT = 50;
	Panel()
	 {
		brush = new HoverButton(new PVector(950,50),8,"brush.png");
		rubber = new HoverButton(new PVector(850,50),8,"rubber.png");
		save = new HoverButton(new PVector(750,50),8,"save.png");
		size_bar = new ScrollBar(new PVector(50,250),80,300,(float)stroke_weight / (float)MAX_STROKE_WEIGHT);
		op_bar = new ScrollBar(new PVector(50,600),80,300,(float)opacity / (float)MAX_OPACITY);
		init(); //initialize the panel view
	}
	void init()
	{
		stroke(0);
		strokeWeight(4);	
		line(100,100,100,1000);
		line(100,100,1000,100);
		// initialize palette
		palette_color = new int[6];
		palette_color[0] = color(0);
		palette_color[1] = color(255);
		palette_color[2] = color(140);
		palette_color[3] = color(255,0,0);
		palette_color[4] = color(255,153,19);
		palette_color[5] = color(0,0,255);
		int base_x = 150;
		palette = new HoverSquare[palette_color.length];
		for (int i = 0;i < palette.length;i++)
		{
			palette[i] = new HoverSquare(new PVector(base_x + i / 2 * 40,30 + i % 2 * 40),35,35,palette_color[i]);
		}
		base_x = base_x + palette_color.length * 20 + 20;
		color_picker = new ColorPicker(new PVector(base_x,50),40,90,0.5);
		saturation_picker = new ScrollBar(new PVector(base_x + 50,50),40,90,1);
		brightness_picker = new ScrollBar(new PVector(base_x + 100,50),40,90,1);
	}
	void draw()
	{
		draw_elements(); //画面板上的元素
		handle_rubber();
		handle_save();
		handle_brush();
		handle_bars();
		handle_palette();
		handle_color_picker();
		use_brush();
	}
	private void draw_elements()
	{
		brush.draw();
		rubber.draw();
		save.draw();
		size_bar.draw();
		op_bar.draw();
		color_picker.draw();
		saturation_picker.draw();
		brightness_picker.draw();
		draw_indicator();
		for (int i = 0;i < palette.length;i++)
		{
			palette[i].draw(true);
		}
	}
	private void handle_color_picker()
	{
		if (color_picker.has_locker || saturation_picker.has_locker || brightness_picker.has_locker)
		{
			float hue = color_picker.val * 180;
			float sat = saturation_picker.val * 100;
			float bri = brightness_picker.val * 100;
			colorMode(HSB,180,100,100);
			brush_color = color(hue,sat,bri);
			colorMode(RGB,255);
		}
	}
	private void handle_palette()
	{
		for (int i = 0;i < palette.length;i++)
		{
			if (!lock && palette[i].onPress())
			{
				brush_color = palette_color[i];
			}
		}
	}
	private void handle_bars()
	{
		if (size_bar.has_locker || op_bar.has_locker)
		{
			stroke_weight = (int)(size_bar.val * MAX_STROKE_WEIGHT);
			opacity = (int)(op_bar.val * MAX_OPACITY);
			brush_color = change_alpha(brush_color,opacity);
		}
	}
	private void handle_rubber()
	{
		if (!lock && rubber.onPress())
		{
			background(255);
			init();
			draw_elements();
		}
	}
	private void handle_save()
	{
		if (!lock && save.onPress())
		{
			PImage s = get(102,102,900,900);
			s.save("MasterPiece.jpg");
		}
	}
	private void handle_brush()
	{
		if (brush_btn_counter!= 0)
		{
			brush_btn_counter --;
		}
		else
		{
			if (!lock && brush.onPress())
			{
				brush_btn_counter = 10;
				if (cursor_state == 0)
				{
					cursor_state = 1;
					cursor(1);
				}
				else
				{
					cursor_state = 0;
					cursor(0);
				}
			}
		}
	}
	private void use_brush()
	 {
		if (mousePressed)
		{
			// mouse pressed and within the range
			if (!lock) // get the locker
			{
				brush_has_locker = true;
				lock = true;
			}
			else if (!brush_has_locker) // if no locker, return
			{
				return;
			}
			if (mouseX > 100 && mouseY > 100)
			{
				if (cursor_state == 0)
				{
					int x = constrain(mouseX,101,1000);
					int y = constrain(mouseY,101,1000);
					int px = constrain(pmouseX, 101, 1000);
					int py = constrain(pmouseY, 101, 1000);
					stroke(brush_color);
					strokeWeight(stroke_weight);
					line(x,y,px,py);
				}
				else if (cursor_state == 1)
				{
					needle();
				}
			}
		}
		else // release the locker
		{
			brush_has_locker = false;
		}
	}
	void needle()
	{
		if (dist(pmouseX,pmouseY,mouseX,mouseY)<20)
		{
			return;
		}
		final int needle_l = 20;
		int real_l = stroke_weight * needle_l;
		// 画针
		int x = constrain(mouseX,101,1000);
		int y = constrain(mouseY,101,1000);
		int px = constrain(pmouseX, 101, 1000);
		int py = constrain(pmouseY, 101, 1000);
		float angle = random(180);
		int x1 = x + (int)((float)real_l * cos(angle));
		int y1 = y + (int)((float)real_l * sin(angle));
		int x2 = 2 * x - x1;
		int y2 = 2 * y - y1;
		x1 = constrain(x1,101,1000);
		y1 = constrain(y1,101,1000);
		x2 = constrain(x2,101,1000);
		y2 = constrain(y2,101,1000);
		stroke(change_alpha(brush_color,(int)random(opacity)));
		strokeWeight(stroke_weight);
		line(x1,y1,x2,y2);
	}
	// 在左上角画笔刷的造型
	private void draw_indicator()
	{
		fill(255);
		stroke(0);
		strokeWeight(stroke_weight / 4);
		ellipse(50, 50, 50, 50);
		fill(brush_color);
		noStroke();
		ellipse(50, 50, 30, 30);
	}
}

class ScrollBar extends HoverSquare
{
	Square bar;
	float val;
	boolean has_locker = false;
	ScrollBar(PVector _pos,int _w,int _h, float _val)
	{
		super(_pos,_w,_h,color(204));
		val = _val;
		int h_bar = (int)((float)_h * val);
		bar = new Square(new PVector(_pos.x,_pos.y + _h / 2 - h_bar / 2),_w,h_bar,color(102));
	}
	void draw()
	{
		rectMode(CENTER);
		fill(255);
		noStroke();
		rect(pos.x, pos.y, w, h);
		stroke(0);
		strokeWeight(1);
		rectMode(CENTER);
		rect(pos.x, pos.y, w, h);
		bar.draw();
		handle_change();
	}
	private void handle_change()
	{
		if (has_locker || onPress())
		{
			if (!lock) // get the locker
			{
				lock = true;
				has_locker = true;
			}
			else if (!has_locker) // if no locker, do not act
			{
				return;
			}
			int y_bottom = (int)pos.y + (int)(h / 2);
			int length = y_bottom - mouseY;
			length = constrain(length, 0, h); // handle out of bound
			bar.h = length;
			bar.pos.y = y_bottom - length / 2;
			val = (float)length / (float)h;
		}
		
		if (!mousePressed)// release the locker
		{
			has_locker = false;
			lock = false;
		}
	}
}

class ColorPicker extends HoverSquare
{
	Square bar;
	float val;
	boolean has_locker = false;
	ColorPicker(PVector _pos,int _w,int _h, float _val)
	{
		super(_pos,_w,_h,color(204));
		val = _val;
		int h_bar = (int)((float)_h * val);
		bar = new Square(new PVector(_pos.x,_pos.y + _h / 2 - h_bar),_w,5,color(255,0));
		rainbow();
	}
	void draw()
	{
		fill(255,0);
		stroke(0);
		strokeWeight(1);
		rectMode(CENTER);
		rect(pos.x, pos.y, w, h);
		bar.draw();
		handle_change();
	}
	private void rainbow()
	{
		colorMode(HSB,180,100,100);
		int y_bottom = (int)pos.y + (int)(h / 2);
		float step = 180.0 / (float)h;
		for (int i = 0;i < h;i++)
		{
			rectMode(CENTER);
			fill(color(i * step,100,100));
			noStroke();
			rect(pos.x,y_bottom - i,w,1);
		}
		colorMode(RGB,255);
	}
	private void handle_change()
	{
		if (has_locker || onPress())
		{
			if (!lock) // get the locker
			{
				lock = true;
				has_locker = true;
			}
			else if (!has_locker) // if no locker, do not act
			{
				return;
			}
			int y_bottom = (int)pos.y + (int)(h / 2);
			int length = y_bottom - mouseY;
			length = constrain(length, 0, h); // handle out of bound
			bar.pos.y = y_bottom - length;
			val = (float)length / (float)h;
			rainbow();
		}
		
		if (!mousePressed)// release the locker
		{
			has_locker = false;
			lock = false;
		}
	}
}