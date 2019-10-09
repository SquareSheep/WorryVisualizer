abstract class Mob {
	boolean finished = false;

	
	abstract void update();

	abstract void render();
}

class Ellipse2d extends Mob {
	Point p;
	Point w;
	AColor fillStyle = new AColor(100,100,100,100);
	AColor strokeStyle = new AColor(100,100,100,100);
	int index;

	Ellipse2d(float x, float y, float w) {
		this.p = new Point(x, y);
		this.w = new Point(w, w);
	}
}

class Box2d extends Mob {
	Point p;
	Point w;
	float ang = 0;
	AColor fillStyle = new AColor(100,100,100,100);
	AColor strokeStyle = new AColor(100,100,100,100);
	int index;


	Box2d(Point p, Point w) {
		this.p = p;
		this.w = w;
	}

	Box2d(Point p, Point w, float ang) {
		this.p = p;
		this.w = w;
		this.ang = ang;
	}

	void update() {
		p.update();
		w.update();
		fillStyle.update();
		strokeStyle.update();
	}

	void render() {
		push();
		fillStyle.fillStyle();
		strokeStyle.strokeStyle();
		translate(p.p.x, p.p.y);
		rotate(ang);
		rect(0,0, w.p.x, w.p.y);
		pop();
	}
}

class TextBox extends Mob {
	String string = "";
	Point p;
	Point w;
	float ang = 0;
	AColor fillStyle = new AColor(255,255,255,255);
	AColor strokeStyle = new AColor(255,255,255,255);
	int timeEnd;

	TextBox(String string, Point p, int timeEnd) {
		this.string = string;
		this.p = p.copy();
		this.timeEnd = timeEnd;
	}

	TextBox(String string, float x, float y, int timeEnd) {
		this.string = string;
		this.p = new Point(x, y);
		this.timeEnd = timeEnd;
	}

	void update() {
		p.update();
		if (currTime > timeEnd) finished = true;
	}

	void render() {
		push();
		fillStyle.fillStyle();
		strokeStyle.strokeStyle();
		translate(p.p.x, p.p.y);
		rotate(ang);
		text(string, 0,0);
		pop();
	}

	void addText(String string) {
		this.string += string;
	}
};