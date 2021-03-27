import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'share.dart';
import 'Theme.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  IconData menu = Icons.menu;
  double angle = 0, top = -160, left = 0, topLanscape = -180, leftLanscape = 0;
  bool move = false;
  double carScale = themeSwitch == true ? carBlackScale : carWhiteScale;
  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    double w = MediaQuery.of(context).size.width,
        h = MediaQuery.of(context).size.height;
//    getThemeSwitch();
    setting(media, w, h);
//    theme();
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
      backgroundColor: bodyColor,
      appBar: AppBar(
        title: Txt("setting".tr(), titleSize, textColor),
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
        backgroundColor: bodyColor,
      ),
      body: ListView(children: [
        Stack(children: [
          Column(
            children: <Widget>[
              // Portrait(media)?SizedBox(height: 0,):Spacer(),
              Center(
                child: Container(
                    padding: EdgeInsets.only(top: w * 0.01),
                    width: w * 0.8,
                    height: h * 0.25,
                    child: Transform.scale(
                      scale: switchVal.value == true
                          ? carBlackScale
                          : carWhiteScale,
                      child: Image(
                        image: AssetImage('imgs/$car.png'),
                        width: w * 0.8,
                        height: h * 0.23,
                      ),
                    )),
              ),
              SizedBox(
                height: h * 0.04,
              ),
              //theme
              ListTile(
                leading:
                    Icon(Icons.brightness_3, color: mainColor1, size: iconSize),
                title: Text("mood".tr(),
                    style: TextStyle(
                        color: textColor,
                        fontSize: fontSize,
                        fontFamily: "Cairo")),
                trailing: SizedBox(
                  width: switchSize,
                  child: Switch(
                    focusColor: mainColor2,
                    value: switchVal.value != null ? switchVal.value : false,
                    onChanged: (val) {
                      DynamicTheme.of(context).setBrightness(
                          val == true ? Brightness.dark : Brightness.light);
                      setState(() {
                        saveTheme(val);
                      });
                    },
                  ),
                ),
              ),

              //language
              ListItem(Icons.language, "lang", iconSize, fontSize, () {
                closeMenu();
                Navigator.of(context).pushNamed("language");
              }),
              //change password
              ListItem(Icons.lock, "chPass", iconSize, fontSize, () {
                closeMenu();
                Navigator.of(context).pushNamed("password");
              }),
              //logout
              ListItem(Icons.exit_to_app, "logout", iconSize, fontSize, () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              })
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SideIcon(textColor, Icons.home, "home", false),
                              SideIcon(textColor, Icons.home, "control", false),
                              SideIcon(mainColor1, Icons.home, "setting", true),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SideIcon(mainColor1, Icons.home, "setting", true),
                              SideIcon(textColor, Icons.home, "control", false),
                              SideIcon(textColor, Icons.home, "home", false),
                            ],
                          ),
                    decoration: BoxDec(null),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ]),
    );
  }

  Widget ListWithSwitch(IconData icon, String txt, bool val, double w,
      double iconS, double fontS, MediaQueryData media, Function change) {
    return ListTile(
      leading: Icon(icon, color: mainColor1, size: iconS),
      title: Txt(txt.tr(), fontS, textColor),
      trailing: SizedBox(
          child: Switch(value: val != null ? val : false, onChanged: change),
          width: switchSize),
    );
  }

  Widget ListItem(
      IconData icon, String txt, double iconS, double fontS, Function press) {
    return ListTile(
        leading: Icon(icon, color: mainColor1, size: iconS),
        title: Txt(txt.tr(), fontS, textColor),
        onTap: press);
  }
}
