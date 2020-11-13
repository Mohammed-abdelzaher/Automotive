import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'main.dart';
import 'Theme.dart';
class FaceId extends StatefulWidget {
  @override
  _FaceIdState createState() => _FaceIdState();
}

class _FaceIdState extends State<FaceId> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size s=MediaQuery.of(context).size;
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        'home':(BuildContext context)=> MyApp(),
      },
      home:Scaffold(key: scaffoldKey,
          appBar: AppBar(backgroundColor: bodyColor,elevation: 0,
              leading: IconButton(icon: Icon(Icons.arrow_back,color: textColor,),
                  onPressed: (){Navigator.pop(context);})),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(color: bodyColor),
            child: Center(
              child: Form(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image(image: AssetImage("imgs/myLogo.png"), width: 150,height: 110,),
                        SizedBox(height: 10,),
                        //CircleAvatar(backgroundImage: AssetImage("imgs/face.jpg"),radius: 120,),
                        //face id start
                        Container(
                          width: s.width*0.8,
                          height: s.height*0.45,
                          //child: Image.asset("imgs/face.jpg"),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2.5,color: greyColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        //face id end
                        SizedBox(height: 40,),
                        Container(
                            width: s.width*0.8,
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
                                child: Text("confirm".tr(), style: TextStyle(
                                    color: Colors.white, fontSize: 20),),
                                onPressed: () {
                                    Navigator.pushNamed(context, 'home');
                                  }

                                ),
                          ),


                      ])),)

        ))

    );
  }
}
