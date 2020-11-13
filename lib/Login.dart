import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gradient_text/gradient_text.dart';
import 'main.dart';
import 'SignUp.dart';
import 'face_id.dart';
import 'Theme.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
String user="kamla",password="car120",loginUser,loginPass;
bool show=true;
class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routes: <String, WidgetBuilder>{
          'home':(BuildContext context)=> new MyApp(),
          'register':(BuildContext context)=> new SignUp(),
          'faceID':(BuildContext context)=> new FaceId(),
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
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    theme();
    Size s=MediaQuery.of(context).size;
    return Scaffold(key: scaffoldKey,
        resizeToAvoidBottomPadding: false,
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(color: bodyColor),
            child: Center(
              child: Form(key: formKey,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Spacer(),
                        Spacer(),
                        //SvgPicture.asset("imgs/myLogo.svg",height: 80,width: 100,),
                        Image(image: AssetImage("imgs/myLogo.png"), height: s.height*0.1,width: 175,),
                        GradientText("welcome".tr(),
                            gradient: LinearGradient(
                                colors: [mainColor2, mainColor1]),
                            style: TextStyle(fontSize: 37,
                                fontFamily: "Cairo",
                                fontWeight: FontWeight.w600,
                                letterSpacing: -2.6)),
                        Spacer(),
                        Spacer(),
                        //user name
                        Input(Icons.person, "enterUser", "wrongUser", user, false),
                        Spacer(),
                        //password
                        Input(Icons.lock, "enterPass", "wrongPass", password, true),
                        Spacer(),
                        //login button
                        ButtonContainer("login", (){
                          if(formKey.currentState.validate()){
                            Navigator.pushNamed(context, "home");
                          }
                        }, false,[mainColor2,mainColor1],Colors.white),
                        Spacer(),
                        //face id button
                        ButtonContainer("faceLog", (){
                          Navigator.pushNamed(context, "faceID");
                        }, true,[boxColor,boxColor],textColor),

                        Spacer(),
                        Spacer(),
                       //sign up button
                       FlatButton(
                          color: Colors.transparent,
                          child: RichText(text: TextSpan(children: [
                            TextSpan(text: "noAccount".tr(), style: TextStyle(
                                color: textColor, fontSize: 18)),
                            TextSpan(text: " " + "signUp".tr(),
                                style: TextStyle(color: mainColor1,
                                    fontSize: 20))
                          ]),),
                          onPressed: () {
                            Navigator.pushNamed(context, "register");
                          },
                        ),
                        Spacer(),
                      ])),)

        ));
  }
  Widget Input(IconData prefix,String hintTxt,String wrong,String compareVal,bool suffix) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35),
      child: TextFormField(obscureText: suffix?show:false,
        style: TextStyle(color: textColor, fontSize: 20),
        decoration: InputDecoration(fillColor: boxColor,
          filled: true,errorStyle: TextStyle(fontSize: 15),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),),
          prefixIcon: Icon(prefix, color: mainColor1,),
          hintText: hintTxt.tr(),
          hintStyle: TextStyle(
              color: textColor, fontSize: 20),
          contentPadding: EdgeInsets.symmetric(vertical: 3),
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
          else if (value != compareVal) {
            return wrong.tr();
          }
          return null;
        },
      ),
    );
  }
  Widget ButtonContainer(String buttonTxt,Function press,bool hasBorder,List<Color> color,Color btnColor){
    return Container(
      width: 340,
      height: 44,
      decoration: BoxDecoration(
        border: hasBorder?Border.all(color: greyColor, width: 1.7):null,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)],
        gradient: LinearGradient(
            colors: color)),
      child: FlatButton(
          child: Text(buttonTxt.tr(), style: TextStyle(color: btnColor, fontSize: 20),),
          onPressed: press),
    );
  }
}