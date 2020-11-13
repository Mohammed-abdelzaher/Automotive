import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'main.dart';
import 'Theme.dart';
class GPS extends StatefulWidget {
  @override
  _GPSState createState() => _GPSState();
}

class _GPSState extends State<GPS> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        'home':(BuildContext context)=> MyApp(),
      },
      home: Scaffold(backgroundColor: bodyColor,
          appBar: AppBar(title: Text("gps".tr(),style: TextStyle(color:textColor,fontSize: 25,fontFamily: "Cairo"),),
              backgroundColor: bodyColor,leading: IconButton(icon: Icon(Icons.arrow_back,color: textColor,),
                  onPressed: (){Navigator.pop(context);})),
          body:null
      ),

    );
  }
}
