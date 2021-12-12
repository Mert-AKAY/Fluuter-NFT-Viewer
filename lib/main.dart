// main.dart
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nftmarektplace/MainOpensea.dart' as Opensea;
import 'package:nftmarektplace/niftygateway.dart' as Niftygateway;
import 'package:nftmarektplace/Theme.dart';
import 'package:nftmarektplace/settings.dart' as settingspage;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:html/parser.dart';
import 'package:path_provider/path_provider.dart';

Map<String, dynamic> opensea_map = new Map<String, dynamic>();
Map<String, dynamic> ngw_map = new Map<String, dynamic>();
List<dynamic> Opensea_data = [], niftygateway_data = [];

void main() {
  runApp(NFTApp());
}

class NFTApp extends StatefulWidget {
  @override
  State<NFTApp> createState() => _NFTAppState();

}

class _NFTAppState extends State<NFTApp> {
  @override
  late bool isSwitched = false;

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              shadowColor:
                  CurrentThemeisdark == true ? AppbarColor : AppbarColordark,
              centerTitle: true,
              backgroundColor:
                  CurrentThemeisdark == true ? AppbarColor : AppbarColordark,
              actions: [
                PopupMenuButton(
                  color:CurrentThemeisdark == true ? mainColor : mainColordark ,
                    itemBuilder: (context) => [
                          PopupMenuItem(

                            child: Row(
                              children: [
                                Text(
                                  'Settings',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: CurrentThemeisdark == true
                                        ? textColor
                                        : textColordark,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 0.0,
                                      top: 0.0,
                                      right: 0.0,
                                      left: 0.0),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    padding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                                    child: IconButton(
                                      icon: Icon(
                                          Icons.settings,
                                      color: CurrentThemeisdark == true ? textColor : textColordark,
                                      ),
                                      onPressed: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => settingspage.Setting()),
                                        );
                                       /* setState(() {
                                          if (CurrentThemeisdark == true) {
                                            Set_CurrentThemeisDark(false);
                                          } else {
                                            Set_CurrentThemeisDark(true);
                                          }
                                        });*/
                                      },
                                    ),
                                  ),
                                  /*
                                  Switch(
                                    value: isSwitched,
                                    activeTrackColor: Colors.lightBlueAccent,
                                    activeColor: Colors.blue,
                                    onChanged: (value1) async {

                                      setState(()  {
                                        if(CurrentThemeisdark==true){
                                          Set_CurrentThemeisDark(false);
                                        }else{
                                          Set_CurrentThemeisDark(true);
                                        }
                                      });
                                    },
                                  ),*/
                                ),
                              ],
                            ),
                          )
                        ])
              ],
              title: Text(
                'Welcome NFT Viewer',
                style: TextStyle(
                  color: CurrentThemeisdark == true ? textColor : textColordark,
                ),
              ),
            ),
            body: NFTMPlaceButtonsContainer()));
  }
}

class NFTMPlaceButtonsContainer extends StatefulWidget {
  @override
  State<NFTMPlaceButtonsContainer> createState() =>
      _NFTMPlaceButtonsContainerState();
}

class _NFTMPlaceButtonsContainerState extends State<NFTMPlaceButtonsContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            CurrentThemeisdark == true ? mainColor : mainColordark,
            CurrentThemeisdark == true ? mainColor : mainColordark
            //Color.fromARGB(255, 205, 222, 245)
          ])),
      child: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        // Generate 100 widgets that display their index in the List.
        crossAxisCount: 2,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () async {
                final response = await http
                    .get(Uri.parse('https://api.opensea.io/assets?limit=50'));
                if (response.statusCode == 200) {
                  String htmlToParse = response.body;
                  opensea_map = json.decode(response.body);
                  Opensea_data = opensea_map["assets"];
                  for (int i = 0; i <= Opensea_data.length - 1; i++) {
                    if (Opensea_data[i]["image_thumbnail_url"] == null ||
                        Opensea_data[i]["image_thumbnail_url"] == "null") {
                      Opensea_data.removeAt(i);
                      i = i - 1;
                    }
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Opensea.OpenseaMainPAge()),
                  );
                }
              },
              child: Text('OPENSEA',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: CurrentThemeisdark == true
                          ? textColor
                          : textColordark)),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                primary: CurrentThemeisdark == true
                    ? openseaButtonColor
                    : openseaButtonColordark,
                onPrimary: buttonsColoronprimary,
                shadowColor: CurrentThemeisdark == true
                    ? openseaButtonColor
                    : openseaButtonColordark,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () async {
                final response = await http.get(Uri.parse(
                    'https://api.niftygateway.com/marketplace/nifty-types/?page=%7B%22current%22:1,%22size%22:20%7D&filter=%7B%22listing_type%22:[%22curated%22,%22verified%22]%7D&sort=%7B%7D'));
                if (response.statusCode == 200) {
                  String body = response.body;
                  ngw_map = json.decode(response.body);
                  niftygateway_data = ngw_map["data"]["results"];
                  for (int i = 0; i <= niftygateway_data.length - 1; i++) {
                    String Currentpath = niftygateway_data[i]
                            ['niftyDisplayImage']
                        .toString()
                        .replaceAll(
                            "https://res.cloudinary.com/nifty-gateway/image/upload/v1638894155/",
                            "https://media.niftygateway.com/image/upload/q_auto:good,w_500/v1638894155/");
                    niftygateway_data[i]['niftyDisplayImage'] = Currentpath;
                    print(niftygateway_data[i]['niftyDisplayImage']
                        .toString()
                        .split(".")
                        .last
                        .compareTo("mp4"));
                    if (niftygateway_data[i]["niftyDisplayImage"] == null ||
                        niftygateway_data[i]["niftyDisplayImage"] == "null" ||
                        niftygateway_data[i]["niftyDisplayImage"]
                                .toString()
                                .split(".")
                                .last
                                .compareTo("jpg") !=
                            0) {
                      niftygateway_data.removeAt(i);
                      i = i - 1;
                    }
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Niftygateway.NiftygatewayMainPAge()),
                  );
                }
              },
              child: Text('NIFTYGATEWAY',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: CurrentThemeisdark == true
                          ? textColor
                          : textColordark)),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                primary: CurrentThemeisdark == true
                    ? ngwButtonColor
                    : ngwButtonColordark,
                onPrimary: buttonsColoronprimary,
                shadowColor: CurrentThemeisdark == true
                    ? ngwButtonColor
                    : ngwButtonColordark,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: Text('RARIBLE',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: CurrentThemeisdark == true
                          ? textColor
                          : textColordark)),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                primary: CurrentThemeisdark == true
                    ? raribleButtonColor
                    : raribleButtonColordark,
                onPrimary: buttonsColoronprimary,
                shadowColor: CurrentThemeisdark == true
                    ? raribleButtonColor
                    : raribleButtonColordark,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('MINTABLE',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: CurrentThemeisdark == true
                          ? textColor
                          : textColordark)),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                primary: CurrentThemeisdark == true
                    ? mintableButtonColor
                    : mintableButtonColordark,
                onPrimary: buttonsColoronprimary,
                shadowColor: CurrentThemeisdark == true
                    ? mintableButtonColor
                    : mintableButtonColordark,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('SOLANART',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: CurrentThemeisdark == true
                          ? textColor
                          : textColordark)),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                primary: CurrentThemeisdark == true
                    ? solonartButtonColor
                    : solonartButtonColordark,
                onPrimary: buttonsColoronprimary,
                shadowColor: CurrentThemeisdark == true
                    ? solonartButtonColor
                    : solonartButtonColordark,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('DIGITALEYES',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: CurrentThemeisdark == true
                          ? textColor
                          : textColordark)),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                primary: CurrentThemeisdark == true
                    ? digitaleyesButtonColor
                    : digitaleyesButtonColordark,
                onPrimary: buttonsColoronprimary,
                shadowColor: CurrentThemeisdark == true
                    ? digitaleyesButtonColor
                    : digitaleyesButtonColordark,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('SOLIBLE',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: CurrentThemeisdark == true
                          ? textColor
                          : textColordark)),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                primary: CurrentThemeisdark == true
                    ? solibleButtonColor
                    : solibleButtonColordark,
                onPrimary: buttonsColoronprimary,
                shadowColor: CurrentThemeisdark == true
                    ? solibleButtonColor
                    : solibleButtonColordark,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('NPATOBSHOP',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: CurrentThemeisdark == true
                          ? textColor
                          : textColordark)),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                primary: CurrentThemeisdark == true
                    ? npatobshopButtonColor
                    : npatobshopButtonColordark,
                onPrimary: buttonsColoronprimary,
                shadowColor: CurrentThemeisdark == true
                    ? npatobshopButtonColor
                    : npatobshopButtonColordark,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
