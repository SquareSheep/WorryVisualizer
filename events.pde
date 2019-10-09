class Event {
	boolean finished = false;
	boolean spawned = false;
	int time;
	int timeEnd;

	void update() {

	}

	void spawn() {

	}
}

class SpawnText extends Event {
	float x;
	float y;
	String string;
	int lifeSpan;

	SpawnText(int time, int lifeSpan, float x, float y, String string) {
		this.time = time;
		this.timeEnd = time + 100;
		this.x = x;
		this.y = y;
		this.string = string;
		this.lifeSpan = lifeSpan;
	}

	SpawnText(int time, int lifeSpan, String string) {
		this.time = time;
		this.timeEnd = time + 100;
		this.x = width/2;
		this.y = height/2+100;
		this.string = string;
		this.lifeSpan = lifeSpan;
	}

	void spawn() {
		tboxes.add(new TextBox(string, x, y, lifeSpan));
	}
}