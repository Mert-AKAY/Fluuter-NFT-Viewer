import 'dart:convert';
import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'main.dart' as main;
import 'AdvertisementServices/AdmobService.dart' as adservices;
import 'package:flutter/cupertino.dart';
import 'package:nftmarektplace/Theme.dart';
import 'package:nftmarektplace/videoview.dart';
import "package:extended_image/extended_image.dart";
List<dynamic> current_ngw_data = [];
late int listcounter=0,maincounter=2;
class NiftygatewayMainPAge extends StatefulWidget {
  NiftygatewayMainPAge({Key? key}) : super(key: key);


  ListViews createState() => ListViews();
}
@override

class ListViews extends State<NiftygatewayMainPAge> {
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
    listcounter=listcounter+10;
    final response = await http
        .get(Uri.parse('https://api.niftygateway.com/marketplace/nifty-types/?page=%7B%22current%22:${maincounter},%22size%22:20%7D&filter=%7B%22listing_type%22:[%22curated%22,%22verified%22]%7D&sort=%7B%7D'));
    if (response.statusCode == 200) {
      main.ngw_map  = json.decode(response.body);
    }
    setState(() {
      maincounter+=1;
      List<dynamic> ngwRefresingData;
      ngwRefresingData = main.ngw_map["data"]["results"];
      for (int i = 0; i <= ngwRefresingData.length - 1; i++) {
        String Currentpath=ngwRefresingData[i]['niftyDisplayImage'].toString().replaceAll("https://res.cloudinary.com/nifty-gateway/image/upload/", "https://media.niftygateway.com/image/upload/q_auto:good,w_500/");
        ngwRefresingData[i]['niftyDisplayImage']=Currentpath;
        if (ngwRefresingData[i]["niftyDisplayImage"] == null ||
        ngwRefresingData[i]["niftyDisplayImage"] == nullptr ||
            ngwRefresingData[i]["niftyDisplayImage"] == "NULL" ||
          ngwRefresingData[i]["niftyDisplayImage"].toString().split(".").last.compareTo("jpg")!=0) {
          ngwRefresingData.removeAt(i);
          i=i-1;
        }
      }
      for (int i = 0; i <= ngwRefresingData.length - 1; i++) {

        print(ngwRefresingData[i]["niftyDisplayImage"]);
      }

      main.niftygateway_data.addAll(ngwRefresingData);
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
                  'images/ng_icon.png',
                  //fit: BoxFit.contain,
                  height: 30,
                  width: 30,
                ),
              ),
              Text('Nifty Gateway Marketplace',
                style: TextStyle(
                  color:CurrentThemeisdark==true ? textColor:textColordark,
                ),)
            ],

          ),
        ),
        body:
        ListView.builder(
            itemCount:main.niftygateway_data.length ,
            controller: _scrollController,
            itemBuilder: (BuildContext context, int index) {
              bool nullcondition1=main.niftygateway_data[index]["niftyDisplayImage"]==null || main.niftygateway_data[index]["niftyTitle"]==null || main.niftygateway_data[index]["lowestSalePrice"]==null;
              bool nullcondition2=main.niftygateway_data[index]["niftyDisplayImage"]=="NULL" || main.niftygateway_data[index]["niftyTitle"]=="NULL" || main.niftygateway_data[index]["lowestSalePrice"]=="NULL";
              if(index==main.niftygateway_data.length-1){

                 return Container(
                   width: 35,
                  height: 35,
                  child:CupertinoActivityIndicator(),
                );
              }
              // if(index%5!=0){
              if(nullcondition1 || nullcondition2 /*|| main.niftygateway_data[index + 1]['niftyDisplayImage'].toString().split(".").last.compareTo("jpg")!=0*/){
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
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 200, 200, 200),
                                width: 2.5,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(3.0),
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
                          child:/*(main.niftygateway_data[index + 1]
                          ['niftyDisplayImage'].toString().split(".").last.compareTo("mp4")==0) ?
                          /*VideoScreen(name: "name", meidaUrl: main.niftygateway_data[index + 1]
                          ['niftyDisplayImage'])*/
                          /*Image.asset
                            ('images/ng_icon.png',
                            height: 100,
                            width: 100,)*/
                          Container(width: 0,height: 0,)
                              :*/
                              ExtendedImage.network(
                                main.niftygateway_data[index + 1]
                                ['niftyDisplayImage'],
                                width: 100,
                                height: 100,
                                clearMemoryCacheWhenDispose: true,
                                clearMemoryCacheIfFailed: true,
                               handleLoadingProgress: true,

                              ),
                          /*CachedNetworkImage(

                            width: 100,
                            height: 100,
                            imageUrl: main.niftygateway_data[index + 1]
                            ['niftyDisplayImage'],
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, error, stackTrace) {
                              return Container(
                                width: 0,
                                height: 0,
                              );
                            },
                            /*errorWidget: (context, url, error) =>
                                Icon(Icons.error),*/
                          ),*/
                        ),
                        Expanded(
                            child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(bottom:5.0,top:0.0,right:0.0,left:0.0),
                                    child:(main.niftygateway_data[index + 1]
                                    ['niftyTitle'] == null) ? Text('NULL') :  Text(
                                      main.niftygateway_data[index + 1]["niftyTitle"],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: CurrentThemeisdark==true ? textColor:textColordark),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom:0.0,top:5.0,right:0.0,left:0.0),
                                    child:(main.niftygateway_data[index + 1]
                                    ['lowestSalePrice'] == null) ? Text('NULL') :  Text(

                                      (main.niftygateway_data[index + 1]["lowestSalePrice"]/100).toString(),
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
