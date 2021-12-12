import 'package:flutter/material.dart';
import 'package:nftmarektplace/main.dart';
import 'package:nftmarektplace/Theme.dart' ;
import 'package:flutter_switch/flutter_switch.dart';
class Setting extends StatefulWidget {
  Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}
class _SettingState extends State<Setting> {
   @override
   void dispose(){
     super.dispose();
   }
   @override
   void initState() {
     super.initState();
   }
   Future refreshUI(bool value) async
   {
     setState(() {
       if(Get_CurrentThemeisDark()==true){
         print(Get_CurrentThemeisDark());
         Set_CurrentThemeisDark(false);
         print(Get_CurrentThemeisDark());
       }else{
         print(Get_CurrentThemeisDark());
         Set_CurrentThemeisDark(true);
         print(Get_CurrentThemeisDark());
       }
     });
   }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,

        home: Scaffold(
          backgroundColor: CurrentThemeisdark==true ?mainColor:mainColordark,
    appBar: AppBar(

      leading: IconButton(
        icon: Icon(Icons.arrow_back,
          color: CurrentThemeisdark == true ? textColor : textColordark,),
        //onPressed: () => Navigator.pop(context),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NFTApp()),
          );

        },
      ),
      shadowColor: CurrentThemeisdark==true ? AppbarColor : AppbarColordark,
      centerTitle: true,
      backgroundColor: CurrentThemeisdark == true ? AppbarColor : AppbarColordark,
      title:
          Text('Settings',
            style: TextStyle(
              color: CurrentThemeisdark == true ? textColor : textColordark,
            ),)
    ),
          body:Container(
            margin: const EdgeInsets.only(bottom:0.0,top:20.0,right:0.0,left:20.0),
            child: Row(
            children: [

              Text('Dark Mode',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color:CurrentThemeisdark==true ? textColor:textColordark,

                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom:0.0,top:0.0,right:0.0,left:20.0),
                width: 70,
                height: 38,
                child:FlutterSwitch
                  (
                activeColor: Color.fromARGB(255, 31, 30, 38),
                inactiveColor: Color.fromARGB(255, 250, 100, 2),
                activeIcon:new Image.asset('images/thumbdarkmode.png'),
                inactiveIcon:new Image.asset('images/thumbdarkmodeclose.png'),
                width: 70.0,
                height: 38.0,
                valueFontSize: 25.0,
                toggleSize: 30.0,
                value: !Get_CurrentThemeisDark(),
                borderRadius: 25.0,
                padding: 3.0,
                onToggle: (value) {
                refreshUI(value);
                  },
                ), /*Switch(
                  value: !Get_CurrentThemeisDark(),
                  onChanged: (value) {
                   refreshUI(value);
                  },
                  activeTrackColor: Colors.lightBlueAccent,
                  activeColor: Colors.blue,
                ),*/
              ),
            ],

          ),
        )
        ),
    );
    throw UnimplementedError();
  }
}