import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'user.dart';
import 'dbHelper.dart';
import 'share.dart';
import 'Theme.dart';

bool show1 = true, show2 = true;

class ChangePass extends StatefulWidget {
  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  //State
  String _newPass = '';
  String _oldPass = '';
  String _error = '';
  var inputC1 = TextEditingController(), inputC2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    Size s = MediaQuery.of(context).size;
    double w = s.width, h = s.height;
    setting(media, w, h);
    theme();
    return Scaffold(
        key: scaffoldKey,
        //resizeToAvoidBottomPadding: false,
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: textColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Txt("chPass".tr(), titleSize, textColor),
            backgroundColor: bodyColor),
        body: ListView(
          children: [Body(media, w, h)],
        ));
  }

  Widget Body(MediaQueryData media, double w, double h) {
    return Container(
      width: w,
      height: h,
      color: bodyColor,
      child: Center(
        child: Container(
          width: Portrait(media) ? buttonWidth : buttonWidth * 1.2,
          height: passBoxHeight,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: boxColor.withOpacity(0.8),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)],
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Transform.translate(
                    offset: Offset(0, -passIcon / 2),
                    child: Container(
                      width: passIcon,
                      height: passIcon,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: textColor,
                      ),
                      decoration: BoxDecoration(
                          color: boxColor,
                          boxShadow: [
                            BoxShadow(color: Colors.black38, blurRadius: 3)
                          ],
                          borderRadius: BorderRadius.circular(passIcon * 0.5)),
                    )),
                //old pass
                Input(
                    inputC1,
                    show1,
                    "enterPass".tr(),
                    Icons.lock,
                    IconButton(
                      icon: Icon(
                        show1 ? Icons.visibility : Icons.visibility_off,
                        color: textColor,
                        size: inputIconSize,
                      ),
                      onPressed: () {
                        setState(() {
                          show1 = !show1;
                        });
                      },
                    ), (value) {
                  setState(() => _oldPass = value);
                }, (value) {
                  if (value.isEmpty) {
                    return "enterPass".tr();
                  } else if (value.isNotEmpty && value.length >= 8) {
                    return null;
                  } else {
                    return 'passLength'.tr();
                  }
                }),

                Spacer(),
                //new pass
                Input(
                  inputC2,
                  show2,
                  "nPass".tr(),
                  Icons.lock,
                  IconButton(
                    icon: Icon(
                      show2 ? Icons.visibility : Icons.visibility_off,
                      color: textColor,
                      size: inputIconSize,
                    ),
                    onPressed: () {
                      setState(() {
                        show2 = !show2;
                      });
                    },
                  ),
                  (value) {
                    setState(() => _newPass = value);
                  },
                  (value) {
                    if (value.isEmpty) {
                      return "enterPass".tr();
                    } else if (value.isNotEmpty) {
                      return null;
                    } else {
//                      return "passNotMatch".tr();
                    }
                  },
                ),
                Spacer(),
                Text(
                  _error.tr(),
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                ButtonContainer(
                  buttonWidth * 0.9,
                  buttonHeight * 0.95,
                  "confirm".tr(),
                  false,
                  [mainColor2, mainColor1],
                  Colors.white,
                  () async {
                    int id = await getUserId();
                    print('user id: ${id}');
                    if (formKey.currentState.validate()) {
                      var oPass = await getOldPass(id);
                      if (_oldPass == oPass.first["pass"]) {
                        var result = await updatePass(id, _newPass);
                        if (result != null) {
                          setState(() {
                            _oldPass = " ";
                            _newPass = " ";
                            inputC1.clear();
                            inputC2.clear();
                          });
                          scaffoldKey.currentState
                              .showSnackBar(showMsg("updateSuccess".tr()));
                        } else {
                          scaffoldKey.currentState
                              .showSnackBar(showMsg("updateFailed".tr()));
                        }
                      } else {
                        scaffoldKey.currentState
                            .showSnackBar(showMsg("wrongPass".tr()));
                      }
                    }
                  },
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Input(controller, bool secure, String hintTxt, IconData prefix,
      Widget suffix, Function chang, Function validate) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: inputMargin * 0.26),
      child: TextFormField(
          controller: controller,
          obscureText: secure,
          style: TextStyle(color: textColor, fontSize: inputTxt),
          decoration: InputDecoration(
              fillColor: boxColor,
              filled: true,
              errorStyle: TextStyle(fontSize: inputTxt * 0.6),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: inputPadding),
              prefixIcon: Icon(
                prefix,
                color: Colors.blue,
                size: inputIconSize,
              ),
              hintText: hintTxt.tr(),
              hintStyle: TextStyle(color: textColor, fontSize: inputTxt),
              suffixIcon: suffix),
          onChanged: chang,
          validator: validate),
    );
  }
}
