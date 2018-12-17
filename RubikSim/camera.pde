float rotation = 0;
float eyeX, eyeY, eyeZ;
float eye_distance = 100;
float eye_yaw = 0;
float eye_pitch = 0;

void update_eye() {
  eyeY = eye_distance*sin(eye_pitch);
  float eyeD = eye_distance*cos(eye_pitch);
  eyeX = eyeD*sin(eye_yaw);
  eyeZ = eyeD*cos(eye_yaw);
  
}