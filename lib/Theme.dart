import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color mainColor1 = Colors.blue,
    mainColor2 = Color(0xff0000dd),
    mainColor3 = Color(0xff0000ff),
    bodyColor = Colors.black,
    textColor = Colors.white,
    boxColor = Color(0xFF151515),
    boxColor2 = Color(0xFF222222),
    greyColor = Color(0x99999999),
    smallTxtColor,
    btnColor = Color(0x77777777),
    carBack = Colors.black,
    batteryC = Colors.transparent,
    flashColor,
    klaxonColor,
    waitColor;
ValueNotifier<bool> switchVal = new ValueNotifier(true); //dark mode switch
ValueNotifier<Brightness> bright = new ValueNotifier(Brightness.light); //
bool faceSwitch, themeSwitch;
String car = 'myCar', control = "Controls";
FontWeight font = FontWeight.w600;
TextDirection direction = TextDirection.ltr;
void theme() {
  //dark mood
  if (switchVal.value == true) {
    car = 'blackCar';
    carBack = Colors.black;
    bodyColor = Colors.black;
    textColor = Colors.white;
    flashColor = Colors.white;
    waitColor = Colors.white;
    klaxonColor = Colors.white;
    boxColor = Color(0xFF151515);
    greyColor = Color(0x99999999);
    smallTxtColor = Color(0xaaaaaaaa);
  }
  //light mood
  else {
    car = 'lightCar';
    carBack = Colors.white;
    bodyColor = Color(0xFFEEEEEE);
    textColor = Colors.black;
    flashColor = Colors.black;
    waitColor = Colors.black;
    klaxonColor = Colors.black;
    boxColor = Colors.white;
    greyColor = Colors.black26;
    smallTxtColor = Colors.black;
  }
}

SharedPreferences prefs;
int userId;
void saveUserId(int val) async {
  prefs = await SharedPreferences.getInstance();
  prefs.setInt("UserId", val);
  userId = val;
}

getUserId() async {
  prefs = await SharedPreferences.getInstance();
  userId = await prefs.getInt("UserId");
  return userId;
}

void saveTheme(bool val) async {
  prefs = await SharedPreferences.getInstance();
  prefs.setBool("switchVal", val);
  switchVal.value = val;
  bright.value = val ? Brightness.dark : Brightness.light;
  switchVal.notifyListeners();
  bright.notifyListeners();
}

getThemeH() async {
  prefs = await SharedPreferences.getInstance();
  switchVal.value = prefs.getBool("switchVal");
  bright.value =
      prefs.getBool("switchVal") ? Brightness.dark : Brightness.light;
  await switchVal.notifyListeners();
  await bright.notifyListeners();
}
