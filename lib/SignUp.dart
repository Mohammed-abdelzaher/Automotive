import 'package:app/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'main.dart';
import 'Theme.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}
String signUser,signPass,signMail;

bool show=true;
class _SignUpState extends State<SignUp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routes: <String, WidgetBuilder>{
          'home':(BuildContext context)=> new MyApp(),
          'login':(BuildContext context)=> new Login()
        },
        debugShowCheckedModeBanner: false,
        home:LoginHome());
  }
}
class LoginHome extends StatefulWidget {
  @override
  _LoginHomeState createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  final scaffoldKey=GlobalKey<ScaffoldState>();
  final formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    theme();
    return Scaffold(key:scaffoldKey,
        //appBar: AppBar(title: Text("logo".tr(),style: TextStyle(fontSize: 22,color: textColor)),backgroundColor: boxColor),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(color: bodyColor),
            child: Center(child:Form(key: formKey,
              child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Spacer(),
                  GradientText("account".tr(),
                      gradient: LinearGradient(
                          colors: [mainColor2, mainColor1]),
                      style: TextStyle(fontSize: 37,
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w600,
                          letterSpacing: -1)),
                  Spacer(),
                  Spacer(),
                  //user name
                  Input(Icons.person,"enterUser", signUser,false),
                  Spacer(),
                  Input(Icons.mail,"enterMail", signMail,false),
                  Spacer(),
                  Input(Icons.lock,"enterPass", signPass,true),
                  Spacer(),
                  //login button
                  Center(
                    child: Container(
                      width: 316,
                      height: 44,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12, blurRadius: 12)
                          ],
                          gradient: LinearGradient(
                              colors: [mainColor2, mainColor1])),
                      child: FlatButton(
                          child: Text("confirm".tr(),style: TextStyle(color: Colors.white,fontSize: 20),),
                          onPressed: (){
                            setState((){
                              if (formKey.currentState.validate()) {
                                Navigator.pushNamed(context, 'home');
                              }
                            });
                          }),
                    ),
                  ),
                  Spacer(),
                  Spacer(),
                  Center(
                    child: FlatButton(
                      color: Colors.transparent,
                      child: RichText(text: TextSpan(children: [
                        TextSpan(text: "registered".tr(),style: TextStyle(color: textColor,fontSize: 18)),
                        TextSpan(text: " "+"login".tr(),style: TextStyle(color: mainColor1,fontSize: 20))
                      ]),),
                      onPressed: (){
                        Navigator.pushNamed(context, "login");
                      },
                    ),
                  ),
                  Spacer(),
                ]),))

        ));
  }
  Widget Input(IconData prefix,String hintTxt,String storeVal,bool suffix){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50,),
      child: TextFormField(obscureText: suffix?show:false,
        style: TextStyle(color: textColor,fontSize: 20),
        decoration: InputDecoration(
            errorStyle: TextStyle(fontSize: 15),
          fillColor: boxColor,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),),
          contentPadding: EdgeInsets.symmetric(vertical: 3),
          prefixIcon: Icon(prefix,color: mainColor1,),
          hintText: hintTxt.tr(),
          hintStyle: TextStyle(color: textColor,fontSize: 20),
          suffixIcon: suffix? IconButton(icon: Icon(
            show ? Icons.visibility : Icons
                .visibility_off,
            color: textColor,),
            onPressed: () {
              setState(() {
                show = !show;
              });
            },
          ):null
        ),

        validator: (value) {
          if (value.isEmpty) {
            return hintTxt.tr();
          }
          setState(() {
            storeVal=value;
          });
          return null;
        },
      ),
    );
  }
}


