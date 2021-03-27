import 'dart:async';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';
import 'joystick.dart';
import 'share.dart';
import 'Theme.dart';

class Controls extends StatefulWidget {
  @override
  _ControlsState createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  IconData menu = Icons.menu;
  double angle = 0, top = -160, left = 0, topLanscape = -180, leftLanscape = 0;
  bool parkLeftClicked = false, parkRightClicked = false, move = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  flashColorFun() {
    flashColor = flashColor == mainColor1 ? textColor : mainColor1;
    klaxonColor = textColor;
    waitColor = textColor;
  }

  waitColorFun() {
    waitColor = waitColor == mainColor1 ? textColor : mainColor1;
    flashColor = textColor;
    klaxonColor = textColor;
  }

  klaxonColorFun(bool on) {
    klaxonColor = on == true ? mainColor1 : textColor;
    flashColor = textColor;
    waitColor = textColor;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    double w = MediaQuery.of(context).size.width,
        h = MediaQuery.of(context).size.height;
    //getThemeH();
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
            print(waitColor);
            closeMenu();
            if (home == false) {
              Navigator.of(context).pushNamed(txt);
            }
          },
        ),
      );
    }

    //joystick method
    JoystickDirectionCallback onDirectionChanged(
        double degrees, double distance) {
      print('degree $degrees');
      print('distance $distance');
    }

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Txt(
            "control".tr(),
            titleSize,
            textColor,
          ),
          backgroundColor: bodyColor,
          leading: IconButton(
            icon: Icon(
              menu,
              color: textColor,
              size: iconSize,
            ),
            onPressed: () {
              if (menu == Icons.close) {
                closeMenu();
              } else {
                openMenu();
              }
            },
          ),
          //backgroundColor: bodyColor,
        ),
        body: Container(
            width: w,
            height: h,
            color: bodyColor,
            child: Stack(
              children: [
                Portrait(media)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              Spacer(),
                              Spacer(),
                              parkLeft(context, parkIconSize),
                              Spacer(),
                              FaIcon(
                                FontAwesomeIcons.parking,
                                color: textColor == Colors.black
                                    ? Colors.black54
                                    : textColor,
                                size: parkIconSize * 1.2,
                              ),
                              Spacer(),
                              parkRight(context, parkIconSize),
                              Spacer(),
                              Spacer(),
                              Spacer(),
                            ],
                          ),
                          Spacer(),
                          //Joystick
                          JoystickView(
                            onDirectionChanged: onDirectionChanged,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              myIcon(
                                  FontAwesomeIcons.flask,
                                  "flash",
                                  flashColor == null ? textColor : flashColor,
                                  w, () {
                                setState(() {
                                  flashColorFun();
                                });
                                flashFun();
                              }),
                              Padding(
                                  padding: EdgeInsets.only(top: h * 0.15),
                                  child: myIcon(
                                      FontAwesomeIcons.bullhorn,
                                      "klaxon",
                                      klaxonColor == null
                                          ? textColor
                                          : klaxonColor,
                                      w, () async {
                                    setState(() {
                                      klaxonColorFun(true);
                                    });
                                    Timer(Duration(seconds: 3), () {
                                      klaxonFun();
                                      setState(() {
                                        klaxonColorFun(false);
                                      });
                                    });
                                  })),
                              myIcon(FontAwesomeIcons.lightbulb, "wait",
                                  waitColor, w, () {
                                setState(() {
                                  waitColorFun();
                                });
                                waitFun();
                              }),
                            ],
                          ),
                          Spacer(),
                          ButtonContainer(
                              buttonWidth,
                              buttonHeight,
                              "getCar".tr(),
                              false,
                              [boxColor, boxColor],
                              textColor, () {
                            getCarFun();
                          }),
                          Spacer(),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  myIcon(
                                      FontAwesomeIcons.flask,
                                      "flash",
                                      flashColor == null
                                          ? textColor
                                          : flashColor,
                                      w, () {
                                    setState(() {
                                      flashColorFun();
                                    });
                                    flashFun();
                                  }),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: h * 0.3,
                                        left: w * 0.03,
                                        right: w * 0.03),
                                    child: myIcon(
                                        FontAwesomeIcons.bullhorn,
                                        "klaxon",
                                        klaxonColor == null
                                            ? textColor
                                            : klaxonColor,
                                        w, () {
                                      setState(() {
                                        klaxonColorFun(true);
                                      });
                                      Timer(Duration(seconds: 2), () {
                                        klaxonFun();
                                        setState(() {
                                          klaxonColorFun(false);
                                        });
                                      });
                                    }),
                                  ),
                                  myIcon(FontAwesomeIcons.lightbulb, "wait",
                                      waitColor, w, () {
                                    print(waitColor);
                                    setState(() {
                                      waitColorFun();
                                    });
                                    waitFun();
                                  }),
                                ],
                              ),
                              getCarButton()
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  parkLeft(context, parkIconSize),
                                  FaIcon(
                                    FontAwesomeIcons.parking,
                                    color: textColor == Colors.black
                                        ? Colors.black54
                                        : textColor,
                                    size: parkIconSize * 1.2,
                                  ),
                                  //Spacer(),
                                  parkRight(context, parkIconSize),
                                ],
                              ),
                              JoystickView(
                                onDirectionChanged: onDirectionChanged,
                              ),
                            ],
                          )
                        ],
                      ),
                AnimatedPositioned(
                  top: Portrait(media) ? top : topLanscape,
                  left: Portrait(media) ? left : leftLanscape,
                  duration: Duration(milliseconds: 600),
                  curve: Curves.linear,
                  child: TweenAnimationBuilder<double>(
                    duration: Duration(milliseconds: 600),
                    tween: Tween(begin: 0, end: angle),
                    builder: (_, double val, __) => Transform.rotate(
                      angle: val,
                      child: Transform.scale(
                        scale: menuScale,
                        child: Container(
                          width: sideWidth,
                          height: sideHeight,
                          child: checkLang(context)
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SideIcon(
                                        textColor, Icons.home, "home", false),
                                    SideIcon(mainColor1, Icons.home, "control",
                                        true),
                                    SideIcon(textColor, Icons.home, "setting",
                                        false),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SideIcon(textColor, Icons.home, "setting",
                                        false),
                                    SideIcon(mainColor1, Icons.home, "control",
                                        true),
                                    SideIcon(
                                        textColor, Icons.home, "home", false),
                                  ],
                                ),
                          decoration: BoxDec(null),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }

  //message
  Widget msg() {
    return SnackBar(
      content: Txt("carParked".tr(), 20, textColor),
      backgroundColor: boxColor,
    );
  }

  Widget getCarButton() {
    return ButtonContainer(buttonWidth * 0.85, buttonHeight * 1.1,
        "getCar".tr(), false, [boxColor, boxColor], textColor, () {
      getCarFun();
    });
  }

  //parking icon
  Widget parkIcon(IconData icon, double size, Function press) {
    return FlatButton(
        child: FaIcon(
          icon,
          color: textColor == Colors.black ? Colors.black54 : textColor,
          size: size,
        ),
        onPressed: press);
  }

  Widget parkLeft(BuildContext context, double size) {
    if (EasyLocalization.of(context).locale == Locale('ar', 'DZ')) {
      return parkIcon(FontAwesomeIcons.solidArrowAltCircleRight, size, () {
        if (parkRightClicked == false) {
          parkRightFun();
        } else {
          scaffoldKey.currentState.showSnackBar(msg());
        }
      });
    } else {
      return parkIcon(FontAwesomeIcons.solidArrowAltCircleLeft, size, () {
        if (parkLeftClicked == false) {
          parkLeftFun();
        } else {
          scaffoldKey.currentState.showSnackBar(msg());
        }
      });
    }
  }

  Widget parkRight(BuildContext context, double size) {
    if (EasyLocalization.of(context).locale == Locale('ar', 'DZ')) {
      return parkIcon(FontAwesomeIcons.solidArrowAltCircleLeft, size, () {
        if (parkLeftClicked == false) {
          parkLeftFun();
        } else {
          scaffoldKey.currentState.showSnackBar(msg());
        }
      });
    } else {
      return parkIcon(FontAwesomeIcons.solidArrowAltCircleRight, size, () {
        if (parkRightClicked == false) {
          parkRightFun();
        } else {
          scaffoldKey.currentState.showSnackBar(msg());
        }
      });
    }
  }

  Widget myIcon(
      IconData icon, String txt, Color iconColor, double w, Function press) {
    //iconColor = switchVal.value ? Colors.white : Colors.black;
    return Column(
      children: [
        Container(
            width: controlIconSize,
            height: controlIconSize,
            child: Center(
              child: FlatButton(
                child: FaIcon(
                  icon,
                  color: iconColor,
                  size: iconSize * 0.8,
                ),
                onPressed: press,
              ),
            ),
            decoration: BoxDecoration(
              color: boxColor,
              borderRadius:
                  BorderRadius.all(Radius.circular(controlIconSize / 2)),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12)],
            )),
        Txt(txt.tr(), inputTxt, textColor)
      ],
    );
  }

//========backend=============

  //parking methods
  void parkLeftFun() {
    //some backend code
    print("parking left");
    parkLeftClicked = true;
  }

  void parkRightFun() {
    //some backend code
    print("parking right");
    parkRightClicked = true;
  }

  //move methods
  void moveTopFun() {
    //some backend code
    print("move Up");
  }

  void moveDownFun() {
    //some backend code
    print("move Down");
  }

  void moveLeftFun() {
    //some backend code
    print("move left");
  }

  void moveRightFun() {
    //some backend code
    print("move right");
  }

  void flashFun() {
    //flash on
    if (flashColor == mainColor1) {
      print("flash on");
    }
    //flash on
    else {
      print("flash off");
    }
  }

  void klaxonFun() {
    print("klaxon");
  }

  void waitFun() {
    //wait on
    if (waitColor == mainColor1) {
      print("wait on");
    }
    //wait off
    else {
      print("wait off");
    }
  }

  void getCarFun() {
    print("get car");
  }
}
