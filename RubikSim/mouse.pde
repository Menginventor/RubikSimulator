void mouseDragged() {
  float sensitivity = 1.0;
  float dx = mouseX-pmouseX; 
  float dy = mouseY-pmouseY; 
  eye_yaw -= dx*PI/360.0*sensitivity;
  eye_pitch -= dy*PI/360.0*sensitivity;
  if (eye_pitch >radians(89))eye_pitch =radians(89.99);
  if (eye_pitch <radians(-89))eye_pitch =radians(-89.99);
  //println(radians(89));
  //println(str(degrees(eye_pitch))+","+str(degrees(eye_yaw)));
}