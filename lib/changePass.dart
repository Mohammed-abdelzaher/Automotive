import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'Theme.dart';
String password="car120",oldPass,newPass;
bool show1=true,show2=true;
class ChangePass extends StatefulWidget {
  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  final scaffoldKey=GlobalKey<ScaffoldState>();
  final formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size s=MediaQuery.of(context).size;
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        home:Scaffold(key:scaffoldKey,
            //resizeToAvoidBottomPadding: false,
            appBar: AppBar(
                leading: IconButton(icon: Icon(Icons.arrow_back,color: textColor,),
                    onPressed: (){Navigator.pop(context);}),
                title: Text("chPass".tr(),style: TextStyle(fontSize: 21,color: textColor)),backgroundColor: bodyColor),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(color: bodyColor),
              child: Center(
                child:Container(width: 320,height: s.height*0.5,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: boxColor.withOpacity(0.8),
                  boxShadow: [BoxShadow(color: Colors.black26,blurRadius: 12)],
                  borderRadius: BorderRadius.all(Radius.circular(16)),),
                child:Form(key: formKey,
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Transform.translate(
                        offset:Offset(0,-65),
                        child: Container(
                          width: 100,height: 100,
                          child: Icon(Icons.person,size: 50,color: textColor,),
                          decoration: BoxDecoration(color: boxColor,
                              boxShadow: [BoxShadow(color: Colors.black38,blurRadius: 3)],
                              borderRadius: BorderRadius.circular(50)),
                        )
                    ),
                    //old pass
                    Input(show1,"oPass",
                        IconButton(icon: Icon(show1?Icons.visibility:Icons.visibility_off,color: textColor,),
                      onPressed: (){
                        setState(() {
                          show1=!show1;
                        });
                      },
                    ),(value) {
                      if (value.isEmpty) {
                      return "enterPass".tr();
                      }
                      else if(value!=password){
                      return "wrongPass".tr();
                      }
                      oldPass=value;
                      return null;}),

                    Spacer(),
                    //new pass
                    Input(show2,"nPass",
                      IconButton(icon: Icon(show2?Icons.visibility:Icons.visibility_off,color: textColor,),
                      onPressed: (){
                        setState(() {
                          show2=!show2;
                        });
                      },
                    ),(value) {
                      if (value.isEmpty) {
                        return "enterPass".tr();
                      }
                      newPass=value;
                      return null;
                    },),
                    Spacer(),
                    Container(
                        width: 280,
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
                                if(formKey.currentState.validate()){
                                  scaffoldKey.currentState.showSnackBar(
                                      SnackBar(content:Text("updateSuccess".tr(),style: TextStyle(color:textColor,fontSize: 20),),
                                        backgroundColor: bodyColor,));
                                }
                                else{scaffoldKey.currentState.showSnackBar(
                                    SnackBar(content:Text("updateFailed".tr(),style: TextStyle(color:textColor,fontSize: 20),),
                                      backgroundColor: bodyColor,));

                                }});}
                        )),
                    Spacer(),

                  ],),),

              ),),
            )));
  }
  Widget Input(bool secure,String hintTxt,Widget suffix,Function validate){
    return TextFormField(
      obscureText: secure,
      style: TextStyle(color: textColor,fontSize: 20),
      decoration: InputDecoration(fillColor: boxColor,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),),
          contentPadding: EdgeInsets.symmetric(vertical: 3),
          prefixIcon: Icon(Icons.lock,color: Colors.blue,),
          hintText: hintTxt.tr(),
          hintStyle: TextStyle(color: textColor,fontSize: 20),
          suffixIcon: suffix
      ),
      validator:validate
    );
  }
}
