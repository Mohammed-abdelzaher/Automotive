import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'changePass.dart';
import 'language.dart';
import 'Theme.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    //double myWidth=MediaQuery.of(context).size.width;
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        'home':(BuildContext context)=> MyApp(),
        'pass':(BuildContext context)=> new ChangePass(),
        'lang':(BuildContext context)=> new Language(),
      },
        home:SettingHome()


    );
  }
}
class SettingHome extends StatefulWidget {
  @override
  _SettingHomeState createState() => _SettingHomeState();
}

class _SettingHomeState extends State<SettingHome> {
//  SharedPreferences sp;
//  saveData(bool val) async{
//    sp=await SharedPreferences.getInstance();
//    sp.setBool("theme", val);
//  }
//  getData() async{
//    sp=await SharedPreferences.getInstance();
//    setState(() {
//      switchVal=sp.getBool("theme")?? true;
//    });
//  }
  @override
  Widget build(BuildContext context) {
    theme();
    double w=MediaQuery.of(context).size.width;
    //getData();
    return Scaffold(backgroundColor: bodyColor,
      appBar: AppBar(title: Text("setting".tr(),style: TextStyle(fontSize: 25,fontFamily: "Cairo",color: textColor),),
        backgroundColor: bodyColor,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: textColor,),
          onPressed: (){Navigator.of(context).popAndPushNamed('home');},),),
      body: Column(children: <Widget>[
        Container(padding: EdgeInsets.only(top: 20),
            width: w,height: 170,child:Transform.scale(scale: carScale,
          child: Image(image:AssetImage('imgs/'+car+'.png'),
          ),
        )),
        SizedBox(height: 25,),
        //theme
        ListTile(
            leading:Icon(Icons.brightness_3,color: mainColor1,size: 30),
            title:Text("mood".tr(),style: TextStyle(color: textColor,fontSize: 22,fontFamily: "Cairo")),
            trailing:Switch(focusColor: mainColor2,
              value:switchVal,
              onChanged: (val){
                setState((){
                  switchVal=val;
                });
                //saveData(val);
              },
            ),
            onTap:(){}
        ),
        //language
        ListTile(
            leading:Icon(Icons.language,color: mainColor1,size: 30),
            title:Text("lang".tr(),style: TextStyle(color: textColor,fontSize: 22,fontFamily: "Cairo")),
            onTap:(){Navigator.pushNamed(context, 'lang');}
        ),
        //change password
        ListTile(
            leading:Icon(Icons.lock,color: mainColor1,size: 30,),
            title:Text("chPass".tr(),style: TextStyle(color: textColor,fontSize: 22,fontFamily: "Cairo")),
            onTap:(){Navigator.pushNamed(context, 'pass');}
        ),
        //logout
        ListTile(
            leading:Icon(Icons.exit_to_app,color: mainColor1,size: 30),
            title:Text("logout".tr(),style: TextStyle(color: textColor,fontSize: 22,fontFamily: "Cairo")),
            onTap:(){Navigator.of(context).pop(context);}
        ),


          ],)
    );
  }
}
