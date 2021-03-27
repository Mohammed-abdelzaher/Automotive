import 'package:app/share.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gradient_text/gradient_text.dart';
import 'SignUp.dart';
import 'resetpassword.dart';
import 'user.dart';
import 'dbHelper.dart';
import 'Theme.dart';

bool show = true; //show password
bool data = true; //check user data

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool splash = false;
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 3500), () {
      if (mounted)
        setState(() {
          splash = true;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    theme();
    Size s = MediaQuery.of(context).size;
    return Scaffold(
        key: scaffoldKey, body: data && splash ? LoginBody() : Loader(s));
  }

  Widget Loader(Size s) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "imgs/logo.png",
            width: s.width * 0.4,
            height: s.height * 0.15,
          ),
          //SpinKitThreeBounce(color: mainColor1,size: 40,)
          SpinKitPulse(
            color: mainColor1,
            size: s.width * 0.15,
          )
        ],
      ),
    );
  }
}

class LoginBody extends StatefulWidget {
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  //State
  String _loginEmail = '';
  String _loginPass = '';
  String _erorr = '';
  List users = [];
//  getIUserFromDb() async {
//    List data = await getUsers();
//    setState(() {
//      users = data;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    setting(media, w, h);
    if (Portrait(media)) {
      w = MediaQuery.of(context).size.width;
    } else {
      w = MediaQuery.of(context).size.height;
    }
    return Scaffold(
        key: scaffoldKey,
        //backgroundColor: bodyColor,
        //resizeToAvoidBottomPadding: false,
        body: ListView(children: [
          Container(
            width: w,
            height: h,
            color: bodyColor,
            child: Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Spacer(),
                      Spacer(),
                      Portrait(media)
                          ? Image(
                              image: AssetImage("imgs/logo.png"),
                              height: h * 0.1,
                              width: w * 0.4,
                            )
                          : Text(""),
                      //Spacer(),
                      GradientText("welcome".tr(),
                          gradient:
                              LinearGradient(colors: [mainColor2, mainColor1]),
                          style: TextStyle(
                              fontSize: largeFontSize,
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.w600,
                              letterSpacing: -2.6)),
                      Spacer(),
                      Spacer(),
                      //user name
                      Input(
                          Icons.email,
                          "enterMail",
                          "wrongUser",
                          (value) {
                            if (value.isEmpty) {
                              return "Enter An Email".tr();
                            } else if (value.isNotEmpty &&
                                RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                              return null;
                            } else {
                              return "Enter Valide Email";
                            }
                          },
                          false,
                          (value) {
                            setState(() {
                              _loginEmail = value;
                            });
                          }),
                      Spacer(),
                      //password
                      Input(
                          Icons.lock,
                          "enterPass",
                          "wrongPass",
                          (value) {
                            if (value.isEmpty) {
                              return "enterPass".tr();
                            } else if (value.isNotEmpty && value.length >= 8) {
                              return null;
                            } else {
                              return "validPass".tr();
                            }
                          },
                          true,
                          (value) {
                            setState(() {
                              _loginPass = value;
                            });
                          }),
                      Spacer(),
                      //login button
                      ButtonContainer(
                          buttonWidth,
                          buttonHeight,
                          "login".tr(),
                          false,
                          [mainColor2, mainColor1],
                          Colors.white, () async {
                        if (formKey.currentState.validate()) {
                          User user =
                              new User(email: _loginEmail, pass: _loginPass);
                          var result = await login(user);
                          print(result);
                          if (result.length >= 1) {
                            //int id = result.last['id'];
                            setState(() {
                              saveUserId(result.last['id']);
                            });
                            Navigator.of(context).pushReplacementNamed("home");
                          } else {
                            print("failed");
                            scaffoldKey.currentState
                                .showSnackBar(showMsg("failed".tr()));
                          }
                        }
                      }),
                      Spacer(),
                      Text(
                        _erorr.tr(),
                        style: TextStyle(color: Colors.red, fontSize: 15.0),
                      ),
                      Spacer(),
                      FlatButton(
                        color: Colors.transparent,
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "forgetPass".tr(),
                                style: TextStyle(
                                    color: textColor, fontSize: fontSize)),
                            TextSpan(
                                text: " " + "reset".tr(),
                                style: TextStyle(
                                    color: mainColor1, fontSize: fontSize))
                          ]),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed("reset");
                        },
                      ),

                      //sign up button
                      FlatButton(
                        color: Colors.transparent,
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "noAccount".tr(),
                                style: TextStyle(
                                    color: textColor, fontSize: fontSize)),
                            TextSpan(
                                text: " " + "signUp".tr(),
                                style: TextStyle(
                                    color: mainColor1, fontSize: fontSize))
                          ]),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed("register");
                        },
                      ),
                      Spacer(),
                    ])),
          )
        ]));
  }

  Widget Input(IconData prefix, String hintTxt, String wrong, Function valid,
      bool suffix, Function chan) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: inputMargin),
      child: TextFormField(
        obscureText: suffix ? show : false,
        style: TextStyle(color: textColor, fontSize: fontSize),
        decoration: InputDecoration(
            fillColor: boxColor,
            filled: true,
            errorStyle: TextStyle(fontSize: fontSize),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20),
            ),
            prefixIcon: Icon(
              prefix,
              color: mainColor1,
              size: inputIconSize,
            ),
            hintText: hintTxt.tr(),
            hintStyle: TextStyle(color: textColor, fontSize: fontSize),
            contentPadding: EdgeInsets.symmetric(vertical: inputPadding),
            suffixIcon: suffix
                ? IconButton(
                    icon: Icon(show ? Icons.visibility : Icons.visibility_off,
                        color: textColor, size: inputIconSize),
                    onPressed: () {
                      setState(() {
                        show = !show;
                      });
                    },
                  )
                : null),
        onChanged: chan,
        validator: valid,
      ),
    );
  }
}
