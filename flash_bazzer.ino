int flash[] = {14, 15};
int num_of_flash;
int bazzer = 16;

void setup() {
  num_of_flash = sizeof(flash) / sizeof(int);
  for (int i = 0; i < num_of_flash; i++) {
    pinMode(flash[i], OUTPUT);
  }
   pinMode(bazzer, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:

}
//TURN ON flash
void flashonn() {
  for (int i = 0; i < num_of_flash; i++) {
    digitalWrite(flash[i], HIGH);
  }
}
//TURN OFF flash
void flashoff() {
  for (int i = 0; i < num_of_flash; i++) {
    digitalWrite(flash[i], LOW);
  }
}
//TURN ON bazzer
void bazzeroff() {
  digitalWrite(bazzer, LOW);
}
//TURN OFF bazzer
void bazzeron() {
  digitalWrite(bazzer, HIGH);
}
