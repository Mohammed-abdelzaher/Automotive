import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'Theme.dart';
int langVal=1;
class Language extends StatefulWidget {
  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(unselectedWidgetColor:textColor
        ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      home: Scaffold(backgroundColor: bodyColor,
          appBar: AppBar(title: Text("lang".tr(),style: TextStyle(color:textColor,fontSize: 23),),
              backgroundColor: bodyColor,leading: IconButton(icon: Icon(Icons.arrow_back,color: textColor,),
                  onPressed: (){Navigator.pop(context);})),
          body: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                RadioIcon("English", 1,Locale('en', 'US')),
                RadioIcon("العربية", 2,Locale('ar', 'DZ')),
                RadioIcon("Français", 3,Locale('fr', 'FR')),

              ],
            ),
          ),
        )
    );
  }
  Widget RadioIcon(String txt,int val,Locale locale){
    return ListTile(
        leading: Text(txt,style: TextStyle(color: textColor,fontSize: 20),),
        trailing: Radio(
            value: val,
            groupValue: langVal,
            onChanged: (value) {
              setState(() {
                langVal=value;
                EasyLocalization.of(context).locale=locale;
              });
            }
        ),
        onTap: (){setState(() {
          EasyLocalization.of(context).locale=locale;
        });}
    );

  }
}
