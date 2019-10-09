static String songName = "worry";
static int bpm = 94;

import ddf.minim.analysis.*;
import ddf.minim.*;

Minim mim;
AudioPlayer song;
FFT fft;
static int binCount = 144;
float[] av = new float[binCount];
float max;
float avg;
boolean kick = false;
float kickThreshold = 60;
float kickPercent = 0.95;

ArrayList<Event> events = new ArrayList<Event>();
ArrayList<Mob> mobs = new ArrayList<Mob>();
ArrayList<TextBox> tboxes = new ArrayList<TextBox>();

// GLOBAL ANIMATION VARIABLES -------------------
AColor mobStroke = new AColor(255,255,255,255,0.5,10);
AColor mobFill = new AColor(255,255,255,255,0.5,10);
APoint mobPoint = new APoint(new PVector(0,0,0), 0.5, 10);

PVector gridCenter;

TextBox textBox;

static int de; //width of screen de*2
static int aw; //Animation depth
static int gridW;
static int gridX;
static int gridY;
static int gridZ;
static float defaultMass = 3;
static float defaultVMult = 0.5;


BeatTimer timer;
int currTime;
int offset;

// ---------------------------------------------


void setup() {
  frameRate(60);
  //fullScreen(P3D);
  size(1000,1000);

  textSize(width/10);
  rectMode(CENTER);
  textAlign(CENTER);

  mim = new Minim(this);
  song = mim.loadFile("../Music/" + songName + ".mp3", 1024);
  fft = new FFT(song.bufferSize(), song.sampleRate());

  addEvents();


  song.loop();

  offset = millis();
  timer = new BeatTimer(50,-offset,bpm);
  mouseX = 0;
  mouseY = 0;
}

void draw() {
  update();

  background(0);
  fill(255);
  //drawPitches();

  for (Mob mob : mobs) {
    mob.render();
  }

  for (TextBox tbox : tboxes) {
    tbox.render();
  }

}

void update() {
  calcFFT();

  currTime = song.position();

  mobFill.update();
  mobStroke.update();
  mobPoint.update();
  timer.update();
  updateEvents();
  updateMobs();
}

void updateEvents() {
  for (int i = 0 ; i < events.size() ; i ++) {
    Event event = events.get(i);
    if (!event.finished && currTime > event.time && currTime < event.timeEnd) {
      if (!event.spawned) {
        event.spawn();
        event.spawned = true;
      }
      event.update();
    }
  }
}

void updateMobs() {
  for (Mob mob : mobs) {
    mob.update();
  }

  for (TextBox tbox : tboxes) {
    tbox.update();
  }

  for (int i = 0 ; i < mobs.size() ; i ++) {
    if (mobs.get(i).finished) mobs.remove(i);
  }

  for (int i = 0 ; i < tboxes.size() ; i ++) {
    if (tboxes.get(i).finished) tboxes.remove(i);
  }
}