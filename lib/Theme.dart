import 'package:flutter/material.dart';
bool switchVal=true;
Color mainColor1=Colors.blue,mainColor2=Colors.purple,bodyColor=Colors.black,textColor=Colors.white,boxColor=Color(0xFF151515),
    greyColor=Color(0x99999999),smallTxtColor,btnColor=Color(0x77777777),carBack=Colors.black,batteryC=Colors.transparent;
String car='myCar',logo="logo2";
double carScale=1.1;
void theme(){
  //dark mood
  if(switchVal){
    logo="logo2";
    car='myCar';
    carScale=1.15;
    carBack=Colors.black;
    bodyColor=Colors.black;
    textColor=Colors.white;
    boxColor=Color(0xFF151515);
    greyColor=Color(0x99999999);
    smallTxtColor=Color(0xaaaaaaaa);
  }
  //light mood
  else{
    logo="logo1";
    car='myCar2';
    carScale=1.25;
    carBack=Colors.white;
    bodyColor=Color(0xFFEEEEEE);
    textColor=Colors.black;
    boxColor=Colors.white;
    greyColor=Colors.black26;
    smallTxtColor=Colors.black;
  }
}
//class Theme extends StatefulWidget {
//  @override
//  _ThemeState createState() => _ThemeState();
//}
//
//class _ThemeState extends State<Theme> {
//  @override
//  Widget build(BuildContext context) {
//    return Container();
//  }
//}
