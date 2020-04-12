import 'package:flutter/material.dart';
import 'package:mashghal_co/widgets/loader.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoURl;

  VideoPlayerScreen({@required this.videoURl});

  @override
  VideoState createState() => VideoState();
}

class VideoState extends State<VideoPlayerScreen> {
  VideoPlayerController playerController;
  VoidCallback listener;

  @override
  void initState() {
    super.initState();
    listener = () {
      setState(() {});
    };
  }

  void createVideo() {
    if (playerController == null) {
      playerController = VideoPlayerController.network(
          'https://mashghllkw.com/cdn/' + widget.videoURl)
        ..addListener(listener)
        ..setVolume(10.0)
        ..initialize()
        ..play();
    } else {
      if (playerController.value.isPlaying) {
        playerController.pause();
      } else {
        playerController.initialize();
        playerController.play();
      }
    }
  }

  @override
  void deactivate() {
    playerController.setVolume(0.0);
    playerController.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(235, 218, 241, 10),
          title: Text(
            'تشغيل الفيديو',
            style: TextStyle(
              color: Color.fromRGBO(104, 57, 120, 10),
              fontSize: 20.0,
              fontFamily: 'beINNormal',
            ),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color.fromRGBO(104, 57, 120, 10),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 2 / 3,
              child: Container(
                child: playerController != null
                    ? VideoPlayer(
                        playerController,
                      )
                    : Center(
                        child: ColorLoader(
                          dotRadius: 5.0,
                          radius: 15.0,
                        ),
                      ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(235, 218, 241, 10),
          onPressed: () {
            createVideo();
            playerController.play();
          },
          child: Icon(
            Icons.play_arrow,
            color: Color.fromRGBO(104, 57, 120, 10),
          ),
        ),
      ),
    );
  }
}
