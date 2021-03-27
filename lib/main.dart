import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'Login.dart';
import 'SignUp.dart';
import 'home.dart';
import 'Controls.dart';
import 'Settings.dart';
import 'language.dart';
import 'resetpassword.dart';
import 'changePass.dart';
import 'Theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(EasyLocalization(
    child: MyApp(),
    path: "translate",
    saveLocale: true,
    supportedLocales: [
      Locale('en', 'US'),
      Locale('ar', 'DZ'),
      Locale('fr', 'FR'),
    ],
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getThemeH();
    //theme();
    return DynamicTheme(
        defaultBrightness: bright.value,
        data: (brightness) {
          if (brightness == Brightness.light) {
            return ThemeData(accentColor: Colors.blue);
          } else {
            return ThemeData(accentColor: Colors.blue);
          }
        },
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: ThemeData(
                unselectedWidgetColor:
                    switchVal.value==true ? Colors.white : Colors.black),
            routes: {
              'login': (context) => LoginBody(),
              'register': (context) => SignUp(),
              'home': (context) => Home(),
              'setting': (context) => Setting(),
              'language': (context) => Language(),
              'control': (context) => Controls(),
              'password': (context) => ChangePass(),
              'reset': (BuildContext context) => Reset(),
            },
            home: Login(),
          );
        });
  }
}
