import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'Theme.dart';
class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      home: Scaffold(backgroundColor: bodyColor,
            appBar: AppBar(title: Text("cam".tr(),style: TextStyle(color:textColor,fontSize: 25,fontFamily: "Cairo",),),
                backgroundColor: bodyColor,leading: IconButton(icon: Icon(Icons.arrow_back,color: textColor,),
                    onPressed: (){Navigator.pop(context);})),
            body:null
        ),

    );
  }
}
