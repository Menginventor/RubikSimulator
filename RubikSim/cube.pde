class Rubik {
  boolean animate = false;
  PVector face [][][] = new PVector[6][3][3];//W,G,R,B,0,Y //position of center face
  PVector face_rect [][][][] = new PVector[6][3][3][4];//W,G,R,B,0,Y position of  face corner for draw vertex
  PGraphics cube_view;
  PGraphics face_view;
  float rotate_thresh = 5;
  float face_width = 10;
  PVector face_ref [][][]= new PVector[6][3][3];
  int face_color [][][]= new int[6][3][3];
  int face_id [][][]= new int[6][3][3];
  color[] side_color = {WHITE, GREEN, RED, BLUE, ORANGE, YELLOW};

  int vec_to_face(PVector vec) {
    float face_thresh = 12.5;
    if (vec.x <= -face_thresh)return 1;
    else if (vec.x >= face_thresh)return 3;
    else if (vec.y <= -face_thresh)return 0;
    else if (vec.y >= face_thresh)return 5;
    else if (vec.z <= -face_thresh)return 4;
    else if (vec.z >= face_thresh)return 2;
    else return -1;
  }
  Rubik() {
    normalize();
    for (int i = 0; i<6; i++) {
      for (int j = 0; j<3; j++) {
        for (int k = 0; k<3; k++) {
          face_ref[i][j][k] =  face[i][j][k].copy();
        }
      }
    }
    cube_view = createGraphics(500, 500, P3D);
    face_view = createGraphics(500, 500, P2D);
  }
  //z-axis
  Rubik rotate_orange ( float theta) {

    Rubik result = new Rubik();

    result.set(this);

    for (int i = 0; i<6; i++) {
      for (int j = 0; j<3; j++) {
        for (int k = 0; k<3; k++) {

          if (face[i][j][k].z <= -rotate_thresh) {
            result.face[i][j][k] = PVectorrotateZ(face[i][j][k], theta);
            for (int m = 0; m<4; m++) {
              result.face_rect[i][j][k][m] = PVectorrotateZ(face_rect[i][j][k][m], theta);
            }
          }
        }
      }
    }
    return result;
  }
  Rubik rotate_red ( float theta) {

    Rubik result = new Rubik();

    result.set(this);

    for (int i = 0; i<6; i++) {
      for (int j = 0; j<3; j++) {
        for (int k = 0; k<3; k++) {

          if (face[i][j][k].z >= rotate_thresh) {
            result.face[i][j][k] = PVectorrotateZ(face[i][j][k], -theta);
            for (int m = 0; m<4; m++) {
              result.face_rect[i][j][k][m] = PVectorrotateZ(face_rect[i][j][k][m], -theta);
            }
          }
        }
      }
    }
    return result;
  }
  //z-axis
  //x-axis
  Rubik rotate_green ( float theta) {

    Rubik result = new Rubik();

    result.set(this);

    for (int i = 0; i<6; i++) {
      for (int j = 0; j<3; j++) {
        for (int k = 0; k<3; k++) {

          if (face[i][j][k].x <= -rotate_thresh) {
            result.face[i][j][k] = PVectorrotateX(face[i][j][k], theta);
            for (int m = 0; m<4; m++) {
              result.face_rect[i][j][k][m] = PVectorrotateX(face_rect[i][j][k][m], theta);
            }
          }
        }
      }
    }
    return result;
  }
  Rubik rotate_blue ( float theta) {

    Rubik result = new Rubik();

    result.set(this);

    for (int i = 0; i<6; i++) {
      for (int j = 0; j<3; j++) {
        for (int k = 0; k<3; k++) {

          if (face[i][j][k].x >= rotate_thresh) {
            result.face[i][j][k] = PVectorrotateX(face[i][j][k], -theta);
            for (int m = 0; m<4; m++) {
              result.face_rect[i][j][k][m] = PVectorrotateX(face_rect[i][j][k][m], -theta);
            }
          }
        }
      }
    }
    return result;
  }
  //x-axis
  //y-axis
  Rubik rotate_white ( float theta) {

    Rubik result = new Rubik();

    result.set(this);

    for (int i = 0; i<6; i++) {
      for (int j = 0; j<3; j++) {
        for (int k = 0; k<3; k++) {

          if (face[i][j][k].y <= -rotate_thresh) {
            result.face[i][j][k] = PVectorrotateY(face[i][j][k], theta);
            for (int m = 0; m<4; m++) {
              result.face_rect[i][j][k][m] = PVectorrotateY(face_rect[i][j][k][m], theta);
            }
          }
        }
      }
    }
    return result;
  }
  Rubik rotate_yellow ( float theta) {

    Rubik result = new Rubik();

    result.set(this);
    //
    for (int i = 0; i<6; i++) {
      for (int j = 0; j<3; j++) {
        for (int k = 0; k<3; k++) {

          if (face[i][j][k].y >= rotate_thresh) {
            result.face[i][j][k] = PVectorrotateY(face[i][j][k], -theta);
            for (int m = 0; m<4; m++) {
              result.face_rect[i][j][k][m] = PVectorrotateY(face_rect[i][j][k][m], -theta);
            }
          }
        }
      }
    }
    return result;
  }
  //y-axis
  void set(Rubik ref) {
    for (int i = 0; i<6; i++) {
      for (int j = 0; j<3; j++) {
        for (int k = 0; k<3; k++) {
          face[i][j][k] = ref.face[i][j][k].copy();
          for (int m = 0; m<4; m++) {

            face_rect[i][j][k][m] = ref.face_rect[i][j][k][m].copy();
          }
        }
      }
    }
  }
  void round_value() {
    for (int i = 0; i<6; i++) {
      for (int j = 0; j<3; j++) {
        for (int k = 0; k<3; k++) {
          face[i][j][k].set(round(face[i][j][k].x), round(face[i][j][k].y), round(face[i][j][k].z));
          for (int m = 0; m<4; m++) {
            face_rect[i][j][k][m].set(round(face_rect[i][j][k][m].x), round(face_rect[i][j][k][m].y), round(face_rect[i][j][k][m].z));
          }
        }
      }
    }
  }
  void draw_cube_view() {

    cube_view.beginDraw();
    cube_view.background(127);
    cube_view.camera(eyeX, eyeY, eyeZ, 0, 0, 0, 0, 1, 0);
    for (int i = 0; i<6; i++) {
      draw_3dface(face[i], face_rect[i], side_color[i]);
    }
    cube_view.endDraw();
  }
  void update_facecolor() {
    for (int f1 = 0; f1<6; f1++) {
      for (int r1 = 0; r1<3; r1++) {
        for (int c1 = 0; c1<3; c1++) {
          for (int f2 = 0; f2<6; f2++) {
            for (int r2 = 0; r2<3; r2++) {
              for (int c2 = 0; c2<3; c2++) {
                if (PVector.dist(face[f1][r1][c1], face_ref[f2][r2][c2])<5) {
                  face_color[f2][r2][c2] = f1;
                  face_id[f2][r2][c2] = r1*3+c1;
                }
              }
            }
          }
        }
      }
    }
  }

  void draw_face_view() {
    float side_rect_pos[][] = {{150, 100}, {50, 200}, {150, 200}, {250, 200}, {350, 200}, {150, 300}};
    float face_rect_size = 100;
    update_facecolor();
    face_view.beginDraw();
    face_view.background(127);
    face_view.stroke(0);
    face_view.textAlign(CENTER, CENTER);
    for (int f1 = 0; f1<6; f1++) {
      for (int r1 = 0; r1<3; r1++) {
        for (int c1 = 0; c1<3; c1++) {
          face_view.strokeWeight(1);
          face_view.fill(side_color[face_color[f1][r1][c1]]);
          float rx = side_rect_pos[f1][0] + c1*face_rect_size/3.0;
          float ry =  side_rect_pos[f1][1] + r1*face_rect_size/3.0;
          face_view.rect(rx,ry, face_rect_size/3.0, face_rect_size/3.0);

          face_view.fill(0);
          face_view.text(str(face_id[f1][r1][c1]),rx+face_rect_size/3.0/2.0,ry+face_rect_size/3.0/2.0);
        }
      }
      face_view.strokeWeight(5);
      face_view.noFill();
      face_view.rect(side_rect_pos[f1][0], side_rect_pos[f1][1], face_rect_size, face_rect_size);
    }
    face_view.endDraw();
  }

  void draw_3dface(PVector[][] _face, PVector[][][] _face_rect, color c) {
    for (int i = 0; i<3; i++) {
      for (int j = 0; j<3; j++) {
        //rubik_face[0][i][j]
        cube_view.stroke(0);
        cube_view.strokeWeight(5);
        cube_view.fill(c);
        cube_view.beginShape();
        vect_vertex( cube_view, _face_rect[i][j]);
        cube_view.endShape(CLOSE);
        cube_view.textAlign(CENTER, CENTER);
        cube_view.fill(0);
        cube_view.textSize(5);
        cube_view.textMode(SHAPE);
        cube_view.pushMatrix();
        cube_view.translate( _face[i][j].x, _face[i][j].y, _face[i][j].z);
        switch(vec_to_face(_face[i][j])) {
        case 1:
          cube_view.rotateY(-HALF_PI);
          break;
        case 3:
          cube_view.rotateY(HALF_PI);
          break;
        case 0:
          cube_view.rotateX(HALF_PI);
          break;
        case 5:
          cube_view.rotateX(-HALF_PI);
          break;
        case 4:
          cube_view.rotateY(PI);
          break;
        case 2:
          //cube_view.rotateY(PI);
          break;
        }


        cube_view.text(str(i*3+j), 0, 0, 0.1);
        cube_view.popMatrix();
      }
    }
  }
  void normalize() {
    PVector z_rect[] = new PVector[4]; 
    for (int i = 0; i<4; i++) {
      z_rect[i] = new PVector(0, 0, 0);
    }
    z_rect[0].set(-5.0, -5.0, 0);
    z_rect[1].set(5.0, -5.0, 0);
    z_rect[2].set(5.0, 5.0, 0);
    z_rect[3].set(-5.0, 5.0, 0);
    for (int i = 0; i<3; i++) {
      for (int j = 0; j<3; j++) {
        PVector main_face = new PVector((j-1)*face_width, (i-1)*face_width, face_width*1.5);
        face[2][i][j] = main_face;//main read face
        face[0][i][j] = PVectorrotateX(main_face, HALF_PI);//WHITE FACE
        face[5][i][j] = PVectorrotateX(main_face, -HALF_PI);//YELLOW FACE
        face[4][i][j] = PVectorrotateY(main_face, PI);//ORANGE FACE
        face[1][i][j] = PVectorrotateY(main_face, -HALF_PI);//GREEN FACE
        face[3][i][j] = PVectorrotateY(main_face, HALF_PI);//BLUE FACE

        for (int k = 0; k<4; k++) {
          PVector main_face_rect = PVector.add(main_face, z_rect[k]);
          face_rect[2][i][j][k] = main_face_rect.copy();
          face_rect[0][i][j][k] = PVectorrotateX(main_face_rect, HALF_PI);
          face_rect[5][i][j][k] = PVectorrotateX(main_face_rect, -HALF_PI);
          face_rect[4][i][j][k] = PVectorrotateY(main_face_rect, PI);
          face_rect[1][i][j][k] = PVectorrotateY(main_face_rect, -HALF_PI);
          face_rect[3][i][j][k] = PVectorrotateY(main_face_rect, HALF_PI);
        }
      }
    }
    round_value();
  }
  void print_face() {
    update_facecolor();
    for (int i = 0; i<6; i++) {
      println("face "+str(i));
      for (int j = 0; j<3; j++) {
        for (int k = 0; k<3; k++) {

          print(face_color[i][j][k]);
          print(" ");
        }
        println("");
      }
    }
  }
}





void vect_vertex(PGraphics pg, PVector[] vec) {
  for (int i = 0; i<vec.length; i++) {
    pg.vertex(vec[i].x, vec[i].y, vec[i].z);
  }
}

PVector PVectorrotateX(PVector v, float a) {
  float cs = cos(a);
  float sn = sin(a);
  float [][] R = {{1, 0, 0}, {0, cs, -sn}, {0, sn, cs}};
  float [][] vm = {{v.x}, {v.y}, {v.z}};
  float [][] rm = {{0}, {0}, {0}};

  for (int i = 0; i<3; i++) {
    for (int j = 0; j<3; j++) {
      rm[i][0] += R[i][j]*vm[j][0];
    }
  }
  PVector result = new PVector (rm[0][0], rm[1][0], rm[2][0]);
  return result;
}
PVector PVectorrotateY(PVector v, float a) {
  float cs = cos(a);
  float sn = sin(a);
  float [][] R = {
    {cs, 0, sn}, 
    {0, 1, 0}, 
    {-sn, 0, cs}
  };
  float [][] vm = {{v.x}, {v.y}, {v.z}};
  float [][] rm = {{0}, {0}, {0}};

  for (int i = 0; i<3; i++) {
    for (int j = 0; j<3; j++) {
      rm[i][0] += R[i][j]*vm[j][0];
    }
  }
  PVector result = new PVector (rm[0][0], rm[1][0], rm[2][0]);
  return result;
}
PVector PVectorrotateZ(PVector v, float a) {
  float cs = cos(a);
  float sn = sin(a);
  float [][] R = {
    {cs, -sn, 0}, 
    {sn, cs, 0}, 
    {0, 0, 1}
  };
  float [][] vm = {{v.x}, {v.y}, {v.z}};
  float [][] rm = {{0}, {0}, {0}};

  for (int i = 0; i<3; i++) {
    for (int j = 0; j<3; j++) {
      rm[i][0] += R[i][j]*vm[j][0];
    }
  }
  PVector result = new PVector (rm[0][0], rm[1][0], rm[2][0]);
  return result;
}