// import 'package:better_player/better_player.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class VideoScreen extends StatefulWidget{
//   late final String name,meidaUrl;
//   VideoScreen({required this.name,required this.meidaUrl});
//
//   @override
//   _VideoScreenState createState()=>_VideoScreenState();
// }
//
// class _VideoScreenState extends State<VideoScreen> {
//   late BetterPlayerController _betterPlayerController;
//   GlobalKey _betterPlayerKey=GlobalKey();
//
//   @override
//   void initState() {
//     BetterPlayerConfiguration betterPlayerConfiguration=BetterPlayerConfiguration(
//       aspectRatio: 16/9,
//       fit: BoxFit.contain
//     );
//     BetterPlayerDataSource datasource=BetterPlayerDataSource
//       (BetterPlayerDataSourceType.network, widget.meidaUrl);
//     _betterPlayerController =BetterPlayerController(betterPlayerConfiguration);
//     _betterPlayerController.setupDataSource(datasource);
//     _betterPlayerController.setBetterPlayerGlobalKey(_betterPlayerKey);
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container
//       (
//       width: 100,
//       height: 100,
//       margin: const EdgeInsets.all(5.0),
//       decoration: new BoxDecoration(
//         border: new Border.all(
//             color: Color.fromARGB(255, 200, 200, 200),
//             width: 2.5,
//             style: BorderStyle.solid),
//         borderRadius: new BorderRadius.circular(3.0),
//         boxShadow: [
//           BoxShadow(
//             color: Color.fromARGB(175, 255, 255, 255),
//             spreadRadius: 3,
//             blurRadius: 1,
//             offset:
//             Offset(0, 0), // changes position of shadow
//           ),
//         ],
//       ),
//       child: BetterPlayer
//         (
//
//         key: _betterPlayerKey,
//         controller: _betterPlayerController,
//       ),
//     );
//   }
// }


/*
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Flutter Video Player Demo'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          VideoItems(
            videoPlayerController: VideoPlayerController.asset(
              'assets/video_6.mp4',
            ),
            looping: true,
            autoplay: true,
          ),
          VideoItems(
            videoPlayerController: VideoPlayerController.network(
                'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4'
            ),
            looping: false,
            autoplay: true,
          ),
          VideoItems(
            videoPlayerController: VideoPlayerController.asset(
              'assets/video_3.mp4',
            ),
            looping: false,
            autoplay: false,
          ),
          VideoItems(
            videoPlayerController: VideoPlayerController.asset(
              'assets/video_2.mp4',
            ),
            autoplay: true,
          ),
          VideoItems(
            videoPlayerController: VideoPlayerController.network(
                "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4"
            ),
            looping: true,
            autoplay: false,
          ),
        ],
      ),
    );
  }
}
*/
