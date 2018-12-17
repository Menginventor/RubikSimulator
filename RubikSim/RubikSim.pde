Rubik current;

boolean animating = false;
int animate_step = 10;
int current_step = 0;
char last_command = ' ';
void setup() {
  size(1000, 500, P2D);
  current = new Rubik();
}

void draw() {
  update_eye();

  background(255);

  animate_cube();
  current.draw_face_view();
  image(current.face_view, 500, 0);
}
void   animate_cube() {

  if (animating) {
    current_step++;
    float theta = HALF_PI*float(current_step)/float(animate_step);
    Rubik animate_cube = new Rubik();
    switch(last_command) {
    case 'Q':
      animate_cube = current.rotate_white(theta);
      break;
    case 'A':
      animate_cube = current.rotate_white(-theta);
      break;
      //
    case 'W':
      animate_cube = current.rotate_green(theta);
      break;
    case 'S':
      animate_cube = current.rotate_green(-theta);
      break;
      //
    case 'E':
      animate_cube = current.rotate_red(theta);
      break;
    case 'D':
      animate_cube = current.rotate_red(-theta);
      break;
      //
    case 'R':
      animate_cube = current.rotate_blue(theta);
      break;
    case 'F':
      animate_cube = current.rotate_blue(-theta);
      break;
      //
    case 'T':
      animate_cube = current.rotate_orange(theta);
      break;
    case 'G':
      animate_cube = current.rotate_orange(-theta);
      break;
      //
    case 'Y':
      animate_cube = current.rotate_yellow(theta);
      break;
    case 'H':
      animate_cube = current.rotate_yellow(-theta);
      break;
      //
    }
    animate_cube.draw_cube_view();
    image(animate_cube.cube_view, 0, 0);

    if (current_step >=animate_step) {
      animating = false;
      update_cube();
      current_step = 0;
    }
  } else {
    current.draw_cube_view();
    image(current.cube_view, 0, 0);
  }
}
void keyPressed() {
  char k = char(keyCode);
  char[] cmd = {'Q', 'A', 'W', 'S', 'E', 'D', 'R', 'F', 'T', 'G', 'Y', 'H'};
  boolean is_cmd = false;
  for (int i = 0; i<12; i++) {
    if (k == cmd[i])is_cmd = true;
  }

  if (!animating && is_cmd) {
    animating = true;
    last_command = k;
  }
}
void update_cube() {

  switch(last_command) {
  case 'Q':
    current = current.rotate_white(HALF_PI);
    break;
  case 'A':
    current = current.rotate_white(-HALF_PI);
    break;
    //
  case 'W':
    current = current.rotate_green(HALF_PI);
    break;
  case 'S':
    current = current.rotate_green(-HALF_PI);
    break;
    //
  case 'E':
    current = current.rotate_red(HALF_PI);
    break;
  case 'D':
    current = current.rotate_red(-HALF_PI);
    break;
    //
  case 'R':
    current = current.rotate_blue(HALF_PI);
    break;
  case 'F':
    current = current.rotate_blue(-HALF_PI);
    break;
    //
  case 'T':
    current = current.rotate_orange(HALF_PI);
    break;
  case 'G':
    current = current.rotate_orange(-HALF_PI);
    break;
    //
  case 'Y':
    current = current.rotate_yellow(HALF_PI);
    break;
  case 'H':
    current = current.rotate_yellow(-HALF_PI);
    break;
    //
  }
  current.round_value();
  current.print_face() ;
}