import 'package:app/dbHelper.dart';
import 'package:app/share.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gradient_text/gradient_text.dart';
//import 'package:flutter_email_sender/flutter_email_sender.dart';
//import 'package:random_string/random_string.dart';
//import 'package:mailer/mailer.dart';
//import 'package:mailer/smtp_server.dart';

import 'package:app/Theme.dart';

class Reset extends StatefulWidget {
  @override
  _ResetState createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  //State
  String _email = '';
  String _erorr = '';
  String mailMsg = "";
  String code = "";
  bool mailSent = false;
  String platformResponse = "";
  //Email myEmail;

//  sendMail() async {
//    String username = 'kokysaad833@gmail.com';
//    String password = 'koxsaad123';
//    final smtpServer = yahoo(username, password);
//    final message = Message()
//      ..from = Address(username, 'Admin')
//      ..recipients.add(_email)
//      ..subject = 'Automotive Verification Code is: ${mailMsg}'
//      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
//      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";
//    try {
//      var response = await send(message, smtpServer);
//      print(response);
////      setState(() {
////        mailSent = true;
////      });
//    } on MailerException catch (e) {
//      print('Message not sent.');
////      setState(() {
////        mailSent = false;
////      });
//      for (var p in e.problems) {
//        print('Problem: ${p.code}: ${p.msg}');
//      }
//    }
//    var connection = PersistentConnection(smtpServer);
//    await connection.send(message);
//    await connection.close();
//  }

//  Future<void> sendM() async {
//    myEmail = Email(
//      body: mailMsg,
//      subject: "resetPass".tr(),
//      recipients: [_email],
//      isHTML: false,
//    );
//
//    var platformResponse;
//
//    try {
//      await FlutterEmailSender.send(myEmail);
//      platformResponse = 'success';
//    } catch (error) {
//      platformResponse = error.toString();
//    }
//
//    if (!mounted) return;
//    print("Response :" + platformResponse);
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
        body: Portrait(media) ? Body(w, h) : ListView(children: [Body(w, h)]));
  }

  Widget Body(double w, double h) {
    return Container(
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
                Image(
                  image: AssetImage("imgs/logo.png"),
                  height: h * 0.1,
                  width: w * 0.4,
                ),
                //Spacer(),
                GradientText("resetPass".tr(),
                    gradient: LinearGradient(colors: [mainColor2, mainColor1]),
                    style: TextStyle(
                        fontSize: largeFontSize,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w500,
                        letterSpacing: -2.6)),
                Spacer(),
                mailSent
                    ?
                    //verification code
                    Input(Icons.verified_user, "enterVC", "wrongUser", (value) {
                        if (value.isEmpty) {
                          return "enterVC".tr();
                        } else if (value != mailMsg) {
                          return "validMail".tr();
                        } else {
                          return null;
                        }
                      }, (value) {
                        setState(() {
                          mailMsg = value;
                        });
                      })
                    : //user mail
                    Input(Icons.email, "enterMail", "wrongUser", (value) {
                        if (value.isEmpty) {
                          return "enterMail".tr();
                        } else if (value.isNotEmpty &&
                            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return null;
                        } else {
                          return "validMail".tr();
                        }
                      }, (value) {
                        setState(() {
                          _email = value;
                        });
                      }),

                Spacer(),
                //reset button
                ButtonContainer(
                  buttonWidth,
                  buttonHeight,
                  "confirm".tr(),
                  false,
                  [mainColor2, mainColor1],
                  Colors.white,
                  () async {
                    if (formKey.currentState.validate()) {
                      //var sent = await FlutterEmailSender.send(myEmail);
                      //sendMail();
                      var userId = await findEmail(_email);
                      if (userId.last['id'] > 0) {
//                        if (mailSent) {
//                          showMsg("We have send you a verification code");
//                          setState(() {
//                            mailMsg = randomNumeric(6);
//                          });
//                          print(mailMsg);
//                          if (code == mailMsg) {
//                            print("done");
//                          }
//                        }
                      } else {
                        showMsg("Your Email isn't registered");
                      }

                      print("id : ${userId.last['id']}");
                    }
                  },
                ),
                Spacer(),
                Text(
                  _erorr.tr(),
                  style: TextStyle(color: Colors.red, fontSize: 15.0),
                ),
                Spacer(),
                Spacer(),
                Spacer(),
              ])),
    );
  }

  Widget Input(IconData prefix, String hintTxt, String wrong, Function valid,
      Function chan) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: inputMargin),
      child: TextFormField(
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
        ),
        onChanged: chan,
        validator: valid,
      ),
    );
  }
}
