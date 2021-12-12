import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'main.dart' as main;
import 'AdvertisementServices/AdmobService.dart' as adservices;
import 'package:flutter/cupertino.dart';
import 'package:nftmarektplace/Theme.dart';
import "package:extended_image/extended_image.dart";
class OpenseaMainPAge extends StatefulWidget {
  OpenseaMainPAge({Key? key}) : super(key: key);


  ListViews createState() => ListViews();
}
@override

class ListViews extends State<OpenseaMainPAge> {
  final ScrollController _scrollController=ScrollController();
  @override
  void initState() {
    super.initState();
    refreshDatas();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent){
        print("NEW DATA CALL");
        refreshDatas();
      }
    });
  }
  void dispose(){
    super.dispose();
    _scrollController.dispose();
  }
  Future refreshDatas() async {
    final response = await http
        .get(Uri.parse('https://api.opensea.io/assets?limit=50'));
    if (response.statusCode == 200) {
      main.opensea_map = json.decode(response.body);

    }
    setState(() {
      List<dynamic> OpenseaRefresingData;
      OpenseaRefresingData = main.opensea_map["assets"];
      for (int i = 0; i <= OpenseaRefresingData.length - 1; i++) {
        if (OpenseaRefresingData[i]["image_thumbnail_url"] == null ||
            OpenseaRefresingData[i]["image_thumbnail_url"] == "NULL") {
          OpenseaRefresingData.removeAt(i);
          i=i-1;
          //print(i);
        }
      }
      main.Opensea_data.addAll(OpenseaRefresingData);
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CurrentThemeisdark ==true ? mainColor :mainColordark,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: CurrentThemeisdark==true ? textColor:textColordark),
            onPressed: () => Navigator.pop(context),
          ),
          shadowColor:CurrentThemeisdark==true ? AppbarColor:AppbarColordark,
          centerTitle: true,
          backgroundColor:CurrentThemeisdark==true ? AppbarColor:AppbarColordark,
          title: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom:0.0,top:0.0,right:20.0,left:0.0),
                child:Image.asset (
                  'images/opensea_icon.png',
                  //fit: BoxFit.contain,
                  height: 30,
                  width: 30,
                ),
              ),
              Text('Opensea Marketplace',
                style: TextStyle(
                  color:CurrentThemeisdark==true ? textColor:textColordark,
                ),)
            ],

          ),
        ),
        body:
        ListView.builder(

            itemCount: main.Opensea_data.length ,
            controller: _scrollController,
            itemBuilder: (BuildContext context, int index) {
              bool nullcondition1=main.Opensea_data[index]["image_thumbnail_url"]==null || main.Opensea_data[index]["name"]==null || main.Opensea_data[index]["collection"]['slug']==null;
              bool nullcondition2=main.Opensea_data[index]["image_thumbnail_url"]=="NULL" || main.Opensea_data[index]["name"]=="NULL" || main.Opensea_data[index]["collection"]['slug']=="NULL";
              if(index==main.Opensea_data.length-1){
                return Container(
                  width: 35,
                  height: 35,
                  child:CupertinoActivityIndicator(
                  ),
                );
              }
              // if(index%5!=0){
              if(nullcondition1 || nullcondition2){
                print("NULL catched");
                return Container(width: 0,height: 0,);
              }
              else{
                return Container(
                    margin: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end:Alignment.bottomRight,
                          colors: <Color>[
                            CurrentThemeisdark==true ? itemcolor1: itemcolor1dark,
                            CurrentThemeisdark==true ? itemcolor2: itemcolor2dark
                          ],
                        ),
                        //color:Color.fromARGB(255, 22, 22, 22),
                        border: Border.all(
                            color: CurrentThemeisdark==true ? itembordercolor:itembordercolordark)),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(5.0),
                          decoration: new BoxDecoration(
                            border: new Border.all(
                                color: Color.fromARGB(255, 200, 200, 200),
                                width: 2.5,
                                style: BorderStyle.solid),
                            borderRadius: new BorderRadius.circular(3.0),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(175, 255, 255, 255),
                                spreadRadius: 3,
                                blurRadius: 1,
                                offset:
                                Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                          child:(main.Opensea_data[index + 1]
                          ['image_thumbnail_url'] == null) ? Image.asset('images/opensea_icon.png') :
                          ExtendedImage.network(
                            main.Opensea_data[index + 1]
                            ['image_thumbnail_url'],
                            width: 100,
                            height: 100,
                            clearMemoryCacheWhenDispose: true,

                          ),
                        ),
                        Expanded(
                            child: new Column(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(bottom:5.0,top:0.0,right:0.0,left:0.0),
                                    child:(main.Opensea_data[index + 1]
                                    ['name'] == null) ? Text('NULL') :  Text(
                                      main.Opensea_data[index + 1]["name"],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: CurrentThemeisdark==true ? textColor:textColordark),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom:0.0,top:5.0,right:0.0,left:0.0),
                                    child:(main.Opensea_data[index + 1]
                                    ['collection']['slug'] == null) ? Text('NULL') :  Text(
                                      main.Opensea_data[index + 1]["collection"]["slug"],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: CurrentThemeisdark==true ? textColor:textColordark),
                                    ),
                                  ),
                                ]
                            )
                        )
                      ],
                    )
                );

              }
            }
        )

    );
  }
}