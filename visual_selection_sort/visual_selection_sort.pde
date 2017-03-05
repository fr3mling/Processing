int[] data;
int amount = 300;
int column_width;
int height_multiplier;
int current = 0;
int swaps = 0;
int comps = 0;
int smallest;

void setup() {
  size(1200, 900);
  data = new int[amount];
  
  column_width = width/amount;
  height_multiplier = height/amount;
  
  for(int i = 0; i < amount; i++) {
    data[i] = i+1;
  }
  
  for(int i = 0; i < amount; i++) {
    int swap_index = floor(random(amount));
    swap(i, swap_index);
  }
  rectMode(CORNERS);
  //frameRate(20);
}

void draw() {
  background(51);
  
  selection_sort();
  
  for(int i = 0; i < amount; i++) {
    int a = i * column_width;
    int b = height;
    int c = a + column_width;
    int d = b - data[i] * height_multiplier;
    
    if (i == current) {
      fill(0,255,0);
    } else if (i == smallest) {
      fill(255, 0, 0);
    } else {
      fill(255);
    }
    
    rect(a,b,c,d);
  }

  
  if (current >= amount) {
    noLoop();
    println(comps);
    println(swaps);
  }
}

void selection_sort(){
  smallest = current;
  for (int i = current; i < amount; i++) {
    comps++;
    if(data[i] < data[smallest]) {
      smallest = i;
    }
  }
  if(smallest != current) {
    swap(current, smallest);
    swaps++;
  }
  current++;
}

void swap(int a, int b) {
  int tmp = data[a];
  data[a] = data[b];
  data[b] = tmp;
}

void mousePressed() {
  comps = swaps = current = 0;
  
  for(int i = 0; i < amount; i++) {
    int swap_index = floor(random(amount));
    swap(i, swap_index);
  }
  
  loop();
}