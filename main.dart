import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gradient_text/gradient_text.dart';
import 'dart:ui' as ui;
import 'dart:math';
import 'Settings.dart';
import 'Controls.dart';
import 'Camera.dart';
import 'GPS.dart';
import 'Login.dart';
import 'BatteryInd.dart';
import 'battery.dart';
import 'Theme.dart';


void main() {
  runApp(EasyLocalization(
    child: Login(),
    path: "translate",
    saveLocale: true,
    supportedLocales: [Locale('en', 'US'),Locale('ar', 'DZ'),Locale('fr', 'FR'),],
  ));
}

class MyApp extends StatelessWidget {
  final navKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    //var data=EasyLocalizationProvider.of(context).data;
    theme();
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        'home':(BuildContext context)=> new MyApp(),
        'controls':(BuildContext context)=> Controls(),
        'settings':(BuildContext context)=> new Settings(),
        'cam':(BuildContext context)=> new Camera(),
        'gps':(BuildContext context)=> new GPS(),
        'login':(BuildContext context)=> new Login(),

      },
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      key:navKey,
      debugShowCheckedModeBanner: false,
      home: Home(),

    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: bodyColor,leading: Padding(
          padding: const EdgeInsets.all(4),
          child: Transform.scale(child: Image.asset("imgs/myLogo.png",),scale: 1.4,),
        ),
          title: Text("logo".tr(),style: TextStyle(color: textColor,fontSize: 22,fontFamily: "Cairo"),),
          ),
        backgroundColor: bodyColor,
        body: Body()

    );
  }
}


class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Battery battery = new Battery();
  var _charging = false;
  Color _color=Colors.blue;
  Widget getColorSelector(Color color) {
    return new GestureDetector(
      onTap: () {
        setState(() {
          print(color);
          _color = color;
        });
      },
      child: new CircleAvatar(
        backgroundColor: color,
      ),);
  }
  @override
  Widget build(BuildContext context) {
    theme();
    battery.onBatteryStateChanged.listen((onData) {
      var charging = onData == BatteryState.charging;
      this.setState(() {
        _charging = charging;
      });
    });
    double w=MediaQuery.of(context).size.width;
    return Column(children: <Widget>[
      Container(padding: EdgeInsets.only(top: 20),
        width: w,height: 165,child:Transform.scale(scale: carScale,
        child: Image(image:AssetImage('imgs/'+car+'.png'),
      ),
      )),
      SizedBox(height: 15,),
      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          myIcon(Icons.location_pin, "gps"),
          SizedBox(width: 16,),
          myIcon(Icons.camera_alt, "cam"),
          SizedBox(width: 16,),
          myIcon(Icons.directions, "controls"),
          SizedBox(width: 16,),
          myIcon(Icons.settings, "settings"),

      ],),
      SizedBox(height:15),
      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 178,height: 150,
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
              Text("battery".tr(),style: TextStyle(color: textColor,fontSize: 22,fontFamily: "Cairo")),
              SizedBox(height: 5,),
              Row(//mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Column(crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(margin: EdgeInsets.only(bottom: 13,right: 4.5),
                      width: 15,height: 11,
                      decoration: BoxDecoration(color: batteryC,
                          border: Border(top: BorderSide(width: 1.4,color: Color(0xaaaaaaaa)),
                              left: BorderSide(width: 1.4,color: Color(0xaaaaaaaa)),
                              right: BorderSide(width: 1.4,color: Color(0xaaaaaaaa)),
                              bottom: BorderSide.none)
                      ),
                    ),
                    Transform.rotate(angle: 300.01,
                        child: Container(
                          child: BatteryIndicator(
                            batteryLv:100,
                            style: BatteryIndicatorStyle.values[0],
                            colorful:false,
                            showPercentNum:true,
                            mainColor: mainColor1,
                            size: 52.0,
                            ratio: 1.50,
                            showPercentSlide: true,
                          ),)
                    ),
                  ],
                ),
                Column(children: [
                  Text("100%".tr(),style: TextStyle(color: textColor,fontSize: 28),),
                  SizedBox(height: 10,),
                  Text("charge".tr(),style: TextStyle(color: smallTxtColor,fontSize: 16),),
                ],)

              ],)
            ],),
            decoration: BoxDecoration(color: boxColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [BoxShadow(color: Colors.black54,blurRadius: 12)])
          ),
          SizedBox(width: 13,),
          Container(
              width: 178,height: 150,
              padding: EdgeInsets.symmetric(horizontal: 23,vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                Text("temp".tr(),style: TextStyle(color: textColor,fontSize: 22,fontFamily: "Cairo",)),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 20,),
                  Transform.scale(scale: 1.9,
                    child: GradientText("21",
                        gradient: LinearGradient(colors: [Colors.purple, Colors.blue,]),
                        style: TextStyle(fontSize: 46,fontFamily: "Cairo",fontWeight: FontWeight.w600,letterSpacing: -2)),
                  ),
                  Text("°".tr(),style: TextStyle(color: Colors.blue,fontSize: 75,),),
                ],)



            ],),
              decoration: BoxDecoration(color: boxColor,borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [BoxShadow(color: Colors.black54,blurRadius: 12)])
          )
        ],),
        SizedBox(height: 13,),
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
        speedometer("consum".tr(), "4.5", "km".tr(),100)  ,
        SizedBox(width: 13,),
        speedometer("speed".tr(), "320", "km/h".tr(),60)  ,

    ],)]);
  }
  Widget speedometer(String txt,String val,String unit,double value){
    return Container(
        width: 178,height: 170,
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
        child:Column(mainAxisAlignment:MainAxisAlignment.center,
            children: <Widget>[
              Text(txt,style: TextStyle(color: textColor,fontSize: 22,fontFamily: "Cairo"),),
              Center(child:CustomPaint(
                  foregroundPainter:CircleProgress(value),
                  child:Container(
                      width:120,height:118,
                      child:Column(crossAxisAlignment:CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 30,),
                          Text(val,style: TextStyle(color: textColor,fontSize: 28,)),
                          Text(unit,style: TextStyle(color: smallTxtColor,)),
                        ],
                      ),
                  ))
              )]),
        decoration: BoxDecoration(color: boxColor,borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [BoxShadow(color: Colors.black54,blurRadius: 12)])
    );
  }
  Widget myIcon(IconData icon,String page){
    return Container(
        width: 60,height: 60,
        child: IconButton(icon: Icon(icon,size: 30,color:textColor==Colors.black?Colors.black54:textColor,),
          onPressed: (){Navigator.of(context).pushNamed(page);},),
        decoration: BoxDecoration(color: boxColor,borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: [BoxShadow(color: Colors.black54,blurRadius: 10)])
    );

  }
}


class CircleProgress extends CustomPainter{
  double currentProgress;
  CircleProgress(this.currentProgress);

  @override
  void paint(Canvas canvas, Size size) {

    //this is base circle
    Paint outerCircle = Paint()
      ..strokeWidth = 12
      ..color = greyColor
      ..style = PaintingStyle.stroke;

    Paint completeArc = Paint()
      ..strokeWidth = 12
      ..shader = ui.Gradient.linear(Offset(0,0),Offset(20,100),
        [
          Colors.purple,
          Colors.blue,
        ],
      )
      ..style = PaintingStyle.stroke
      ..strokeCap  = StrokeCap.round;

    Offset center = Offset(size.width/2, size.height/2);
    double radius = min(size.width/2,size.height/2) - 10;

    canvas.drawCircle(center, radius, outerCircle); // this draws main outer circle

    double angle = 2 * pi * (currentProgress/100);

    canvas.drawArc(Rect.fromCircle(center: center,radius: radius), -pi/2, angle, false, completeArc);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
