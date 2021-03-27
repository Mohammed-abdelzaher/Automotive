import 'package:app/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:math';
import 'user.dart';
import 'dbHelper.dart';
import 'share.dart';
import 'Theme.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  User user;
  String _userEmail = '';
  String _userName = '';
  String _userPass = '';
  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    setting(media, w, h);
    return Scaffold(
      key: scaffoldKey,
      //backgroundColor: bodyColor,
      resizeToAvoidBottomInset: true,
      appBar: null,
      body: ListView(children: [
        Container(
            width: w,
            height: h,
            color: bodyColor,
            child: Center(
                child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    Spacer(),
                    GradientText("account".tr(),
                        gradient:
                            LinearGradient(colors: [mainColor2, mainColor1]),
                        style: TextStyle(
                            fontSize: largeFontSize,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.w600,
                            letterSpacing: -1)),
                    Spacer(),
                    //user name
                    Input(
                        Icons.person,
                        "enterUser",
                        (value) {
                          setState(() => _userName = value);
                        },
                        false,
                        (value) {
                          if (value.isEmpty) {
                            return "enterUser".tr();
                          } else if (value.length < 4) {
                            return "userLength".tr();
                          } else {
                            return null;
                          }
                        }),
                    Spacer(),
                    Portrait(media)
                        ? SizedBox(
                            height: 0,
                          )
                        : Spacer(),
                    Input(
                        Icons.mail,
                        "enterMail".tr(),
                        (value) {
                          setState(() => _userEmail = value);
                        },
                        false,
                        (value) {
                          if (value.isEmpty) {
                            return "enterMail".tr();
                          } else if (value.isNotEmpty &&
                              RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return null;
                          } else {
                            return "validMail".tr();
                          }
                        }),
                    Spacer(),
                    Portrait(media) ? Text("") : Spacer(),
                    Input(
                        Icons.lock,
                        "enterPass".tr(),
                        (val) {
                          setState(() => _userPass = val);
                        },
                        true,
                        (value) {
                          if (value.isEmpty) {
                            return "enterPass".tr();
                          } else if (value.length < 8) {
                            return "passLength".tr();
                          } else {
                            return null;
                          }
                        }),
                    Spacer(),
                    Portrait(media) ? SizedBox(height: 0) : Spacer(),
                    //sign button
                    Center(
                      child: ButtonContainer(
                          buttonWidth,
                          buttonHeight,
                          "confirm".tr(),
                          false,
                          [mainColor2, mainColor1],
                          Colors.white, () async {
                        if (formKey.currentState.validate()) {
//                          Random rand = new Random();
//                          int id = rand.nextInt(100);
                          User userLogin =
                              new User(email: _userEmail, pass: _userPass);
                          var result1 = await login(userLogin);
                          user = new User(
                              name: _userName,
                              email: _userEmail,
                              pass: _userPass);
                          var result2 = createUser(user);
                          if (result1.length == 1) {
                            scaffoldKey.currentState
                                .showSnackBar(showMsg("accountExist"));
                          } else if (result2 != null) {
                            int id = await result2;
                            setState(() {
                              saveUserId(id);
                            });
                            Navigator.of(context).pushReplacementNamed("home");
                          } else {
                            scaffoldKey.currentState
                                .showSnackBar(showMsg("failed".tr()));
                          }
                        }
                      }),
                    ),
//                    Text(
//                      _erorr.tr(),
//                      style: TextStyle(color: Colors.red, fontSize: 16),
//                    ),
                    Spacer(),
                    Spacer(),
                    Center(
                      child: FlatButton(
                        color: Colors.transparent,
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "registered".tr(),
                                style: TextStyle(
                                    color: textColor, fontSize: fontSize)),
                            TextSpan(
                                text: " " + "login".tr(),
                                style: TextStyle(
                                    color: mainColor1, fontSize: fontSize))
                          ]),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed("login");
                        },
                      ),
                    ),
                    Spacer(),
                  ]),
            )))
      ]),
    );
  }

  Widget Input(IconData prefix, String hintTxt, Function chang, bool suffix,
      Function valid) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: inputMargin,
      ),
      child: TextFormField(
        obscureText: suffix ? show : false,
        style: TextStyle(color: textColor, fontSize: inputTxt),
        decoration: InputDecoration(
            errorStyle: TextStyle(fontSize: inputTxt),
            fillColor: boxColor,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: inputPadding),
            prefixIcon: Icon(prefix, color: mainColor1, size: inputIconSize),
            hintText: hintTxt.tr(),
            hintStyle: TextStyle(color: textColor, fontSize: inputTxt),
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
        onChanged: chang,
        validator: valid,
      ),
    );
  }
}
