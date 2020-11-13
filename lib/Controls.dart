import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'main.dart';
import 'Theme.dart';
double angle=100.5;
Color activeColor=boxColor;
class Controls extends StatefulWidget {
  @override
  _ControlsState createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  @override
  Widget build(BuildContext context) {
    Size s=MediaQuery.of(context).size;
    return MaterialApp(
//      localizationsDelegates: context.localizationDelegates,
//      supportedLocales: context.supportedLocales,
//      locale: context.locale,
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        'home':(BuildContext context)=> MyApp(),
      },
      home: Scaffold(backgroundColor: bodyColor,
          appBar: AppBar(title: Text("control",style: TextStyle(color:textColor,fontSize: 25),),
              backgroundColor: bodyColor,leading: IconButton(icon: Icon(Icons.arrow_back,color: textColor,),
                  onPressed: (){Navigator.pushNamed(context, 'home');})),
          body: Container(
              width: s.width,height: s.height,color: bodyColor,
              child:Column(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  myIcon(FontAwesomeIcons.angleUp, (){
                    setState(() {
                       angle=6.28;
                    });
                    //some backend code
                    print("move Up");
                  }),
                  SizedBox(height: 34,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      myIcon(FontAwesomeIcons.angleLeft, (){
                        setState(() {
                          angle=4.7;
                        });
                        //some backend code
                        print("move Left");
                      }),
                      SizedBox(width: 50,),
                      Transform.rotate(child: Image.asset('imgs/car8.png',height: s.height*0.3,),angle: angle,),
                      SizedBox(width: 50,),
                      myIcon(FontAwesomeIcons.angleRight, (){
                        setState(() {
                          angle=1.58;
                        });
                        //some backend code
                        print("move Right");
                      })
                    ],),
                  SizedBox(height: 34,),
                 myIcon(FontAwesomeIcons.angleDown, (){
                   setState(() {
                     setState(() {
                       angle=3.15;
                     });
                     //some backend code
                     print("move Down");
                   });
                 })
                ],)),
        ),

    );
  }
  Widget myIcon(IconData icon,Function press){
    return Container(
        width: 70,height: 70,
        child: Center(child: IconButton(icon: FaIcon(icon,color:textColor==Colors.black?Colors.black54:textColor,size: 35,textDirection: TextDirection.ltr,),
          onPressed: press,focusColor: Colors.deepPurpleAccent),),
        decoration: BoxDecoration(color: boxColor,borderRadius: BorderRadius.all(Radius.circular(35)),
            boxShadow: [BoxShadow(color: Colors.black26,blurRadius: 12)])
    );
  }
}
