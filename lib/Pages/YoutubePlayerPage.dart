import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerPage extends StatefulWidget {
  const YoutubePlayerPage({Key? key,required this.Url}) : super(key: key);

  final String Url;
  @override
  State<YoutubePlayerPage> createState() => _YoutubePlayerPageState();
}

class _YoutubePlayerPageState extends State<YoutubePlayerPage> {
  late YoutubePlayerController _controller;

  String getVideoID(String url) {
    url = url.replaceAll("https://www.youtube.com/watch?v=", "");
    url = url.replaceAll("https://m.youtube.com/watch?v=", "");
    return url;
  }


  @override
  void dispose() {
    super.dispose();
    if(_controller.value.isFullScreen){
      SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    }
    print(_controller.value.isFullScreen);
    _controller.dispose();
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,);
    //
  }

  @override
  void deactivate() {
    _controller.pause();
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.deactivate();
  }

  @override
  void initState(){
    _controller = YoutubePlayerController(
      initialVideoId: getVideoID(widget.Url),
      flags: const YoutubePlayerFlags(
        enableCaption: false,
        controlsVisibleAtStart: true,
        autoPlay: true,
      ),
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    //SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    //SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.bottom]);
    return YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        onReady: () {
        },
    );
  }
}
