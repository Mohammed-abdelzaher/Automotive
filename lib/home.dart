import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:app/paint.dart';
import 'dart:math';
import 'package:app/share.dart';
import 'package:app/BatteryInd.dart';
import 'package:app/Theme.dart';
import 'package:provider/provider.dart';

String translateNum(arVal, enVal, BuildContext contxt) {
  if (EasyLocalization.of(contxt).locale == Locale('ar', 'DZ')) {
    return arVal;
  } else {
    return enVal;
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  IconData menu = Icons.menu;
  var batteryLv = 100;
  double angle = 0, top = -160, left = 0, topLanscape = -180, leftLanscape = 0;
  bool move = false;
  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    double w = MediaQuery.of(context).size.width,
        h = MediaQuery.of(context).size.height;
    theme();
    setting(media, w, h);
    openMenu() {
      setState(() {
        menu = Icons.close;
        angle = pi / 2;
        top = Mobile0(media) == "mobile"
            ? h * 0.12
            : (Mobile0(media) == "tablet" ? h * 0.11 : h * 0.085);
        topLanscape = Mobile0(media) == "mobile"
            ? h * 0.22
            : (Mobile0(media) == "tablet" ? h * 0.15 : h * 0.21);
        if (checkLang(context)) {
          left = Mobile0(media) == "mobile"
              ? -w * 0.2
              : (Mobile0(media) == "tablet" ? -w * 0.118 : -w * 0.32);
          leftLanscape = Mobile0(media) == "mobile"
              ? -w * 0.13
              : (Mobile0(media) == "tablet" ? -w * 0.092 : -w * 0.17);
        } else {
          left = Mobile0(media) == "mobile"
              ? w * 0.56
              : (Mobile0(media) == "tablet" ? w * 0.72 : w * 0.43);
          leftLanscape = Mobile0(media) == "mobile"
              ? w * 0.72
              : (Mobile0(media) == "tablet" ? w * 0.775 : w * 0.67);
        }
      });
    }

    closeMenu() {
      setState(() {
        angle = 0;
        if (menu == Icons.close) {
          menu = Icons.menu;
          top = -h * 0.2;
          topLanscape = -h * 0.24;
          if (checkLang(context)) {
            left = 0;
            leftLanscape = 0;
          } else {
            left = w * 0.2;
            leftLanscape = w * 0.2;
          }
        }
      });
    }

    Widget SideIcon(Color color, IconData icon, String txt, home) {
      return Transform.rotate(
        angle: 4.71,
        child: FlatButton(
          padding: EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
                size: inputIconSize,
              ),
              Txt(txt.tr(), smallFontSize, color),
            ],
          ),
          onPressed: () {
            closeMenu();
            if (home == false) {
              Navigator.of(context).pushNamed(txt);
            }
          },
        ),
      );
    }

    return Scaffold(
        //backgroundColor: bodyColor,
        appBar: AppBar(
          backgroundColor: bodyColor,
          leading: IconButton(
            icon: Icon(
              menu,
              color: textColor,
              size: iconSize,
            ),
            onPressed: () {
              print(Mobile0(media));
              if (menu == Icons.close) {
                closeMenu();
              } else {
                openMenu();
              }
            },
          ),
          title: Txt(
            "logo".tr(),
            titleSize,
            textColor,
          ),
        ),
        body: Container(
          width: w,
          height: h,
          color: bodyColor,
          child: Stack(children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Center(
                    child: Transform.scale(
                      scale: switchVal.value == true
                          ? carBlackScale
                          : carWhiteScale,
                      child: Image(
                        image: AssetImage('imgs/$car.png'),
                        width: w * 0.8,
                        height: Portrait(media) ? h * 0.26 : h * 0.21,
                      ),
                    ),
                  ),
                  //Spacer(),
                  Portrait(media)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //battery
                                BatteryBox(context, w, h),
                                //temperature
                                TempBox(media, context, w),
                              ],
                            ),
                            SizedBox(
                              height: h * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //consumption
                                Speedometer(
                                    "consum",
                                    translateNum("٦", "6", context),
                                    "km".tr(),
                                    100,
                                    Mobile(media) ? 12 : 25,
                                    homeBoxWidth * 0.75,
                                    BoxDec(sideBorder1())),
                                //speed
                                Speedometer(
                                    "speed",
                                    translateNum("٢٢٠", "220", context),
                                    "km/h".tr(),
                                    60,
                                    Mobile(media) ? 12 : 25,
                                    homeBoxWidth * 0.75,
                                    BoxDec(sideBorder2())),
                              ],
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //battery
                            BatteryBox(context, w, h),
                            //temperature
                            TempBox(media, context, w),
                            //consumption
                            Speedometer(
                                "consum",
                                translateNum("٦", "6", context),
                                "km".tr(),
                                100,
                                Mobile(media) ? 12 : 25,
                                homeBoxWidth * 0.8,
                                BoxDec(sideBorder1())),
                            //speed
                            Speedometer(
                                "speed",
                                translateNum("٢٢٠", "220", context),
                                "km/h".tr(),
                                60,
                                Mobile(media) ? 12 : 25,
                                homeBoxWidth * 0.8,
                                BoxDec(sideBorder2())),
                          ],
                        ),
                ]),
            AnimatedPositioned(
              top: Portrait(media) ? top : topLanscape,
              left: Portrait(media) ? left : leftLanscape,
              duration: Duration(milliseconds: 600),
              //width: w*0.65 ,height: h*0.12,
              curve: Curves.linear,
              child: TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 600),
                tween: Tween(begin: 0, end: angle),
                builder: (_, double val, __) => Transform.rotate(
                  angle: val,
                  child: Transform.scale(
                    scale: menuScale,
                    child: Container(
                        padding: EdgeInsets.all(0),
                        width: sideWidth,
                        height: sideHeight,
                        child: checkLang(context)
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SideIcon(
                                      mainColor1, Icons.home, "home", true),
                                  SideIcon(textColor, Icons.directions_car,
                                      "control", false),
                                  SideIcon(textColor, Icons.settings, "setting",
                                      false),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SideIcon(textColor, Icons.settings, "setting",
                                      false),
                                  SideIcon(textColor, Icons.directions_car,
                                      "control", false),
                                  SideIcon(
                                      mainColor1, Icons.home, "home", true),
                                ],
                              ),
                        decoration: BoxDec(null)),
                  ),
                ),
              ),
            ),
          ]),
        ));
  }

  Widget BatteryBox(BuildContext contxt, double w, double h) {
    return Container(
        width: homeBoxWidth,
        height: homeBoxHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Txt("battery".tr(), fontSize, textColor),
            Padding(
              padding: EdgeInsets.only(
                  left: checkLang(contxt) ? 0 : w * 0.04,
                  right: checkLang(contxt) ? w * 0.011 : 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            bottom: h * 0.02, right: w * 0.01 / 2),
                        width: batteryTopW,
                        height: batteryTopH,
                        decoration: BoxDecoration(
                            color: batteryC,
                            border: Border(
                                top: BorderSide(
                                    width: 1.4, color: Color(0xaaaaaaaa)),
                                left: BorderSide(
                                    width: 1.4, color: Color(0xaaaaaaaa)),
                                right: BorderSide(
                                    width: 1.4, color: Color(0xaaaaaaaa)),
                                bottom: BorderSide.none)),
                      ),
                      Transform.rotate(
                          angle: 300.01,
                          child: Container(
                            child: BatteryIndicator(
                              batteryLv: batteryLv,
                              style: BatteryIndicatorStyle.values[0],
                              colorful: false,
                              showPercentNum: true,
                              mainColor: mainColor1,
                              size: batterySize,
                              ratio: batteryRatio,
                              showPercentSlide: true,
                            ),
                          )),
                    ],
                  ),
                  Column(
                    children: [
                      Txt(translateNum("١٠٠%", "$batteryLv%", context),
                          fontSize, textColor),
                      SizedBox(
                        height: 10,
                      ),
                      Txt("charge".tr(), smallFontSize * 0.9, smallTxtColor),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            )
          ],
        ),
        decoration: BoxDec(sideBorder2()));
  }

  Widget TempBox(MediaQueryData media, BuildContext contxt, double w) {
    return Container(
        width: homeBoxWidth,
        height: homeBoxHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Txt("temp".tr(), fontSize, textColor),
            Padding(
              padding: EdgeInsets.only(
                  left: checkLang(contxt) ? w * 0.045 : 0,
                  right: checkLang(contxt) ? 0 : w * 0.025),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.scale(
                    scale: tempScale,
                    child: GradientText(translateNum("٢١", "21", context),
                        gradient: LinearGradient(colors: [
                          mainColor2,
                          mainColor1,
                        ]),
                        style: TextStyle(
                            fontSize:
                                Mobile(media) ? fontSize * 2.5 : fontSize * 3.3,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.w600,
                            letterSpacing: Mobile(media) ? -5 : -10)),
                  ),
                  SizedBox(
                    width: tempSpacer,
                  ),
                  Transform.scale(
                      scale: tempScale,
                      child: Txt(
                          "°".tr(),
                          Mobile(media) ? fontSize * 2.4 : fontSize * 3,
                          checkLang(context) ? mainColor1 : mainColor2))
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDec(sideBorder1()));
  }

  Widget Speedometer(String txt, String val, String unit, double value,
      double width, double size, Decoration border) {
    return Container(
        width: homeBoxWidth,
        height: homeBoxHeight,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Txt(txt.tr(), fontSize, textColor),
          CustomPaint(
              foregroundPainter: CircleProgress(value, width),
              child: Container(
                padding: EdgeInsets.only(top: 5, bottom: 10),
                width: speedoSize,
                height: speedoSize,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 7,
                    ),
                    Txt(val, fontSize * 1.3, textColor),
                    Transform.translate(
                      child: Txt(unit, smallFontSize * 0.9, smallTxtColor),
                      offset: Offset(0, -8),
                    ),
                  ],
                ),
              ))
        ]),
        decoration: border);
  }
}
