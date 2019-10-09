void calcFFT() {
  fft.forward(song.mix);

  avg = 0;
  max = 0;
  for (int i = 0 ; i < av.length ; i ++) {
    float temp = 0;
    for (int k = i ; k < fft.specSize() ; k += i + 1) {
      temp += fft.getBand(k);
    }
    temp /= av.length / (i + 1);
    temp = pow(temp,1.5);
    avg += temp;
    av[i] = temp;
  }
  avg /= av.length;

  float kickProp = 0;
  for (int i = 0 ; i < av.length ; i ++) {
    if (av[i] > kickThreshold) kickProp ++;
    if (av[i] < avg*1.2) {
      av[i] /= 3;
    } else {
      av[i] += (av[i] - avg * 1.2) /5;
    }
    if (av[i] > max) max = av[i];
  }
  kick = (kickProp/av.length > kickPercent);

}

void mousePressed() {
  float temp = ((float)mouseX / width) * song.length();
  song.cue((int)temp);
}

void drawPitches() {
    float w = width/(float)binCount;
  for (int i = 0 ; i < binCount ; i ++) {
    push();
    translate(i*w, height/2);
    rect(0,0,w,av[i]*10);
    pop();
  }
}

void keyPressed() {
  println(key + " " + currTime);
}