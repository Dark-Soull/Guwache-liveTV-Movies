

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:fluttertest/VideoPlayer/PlayerForMovies.dart';
import 'package:wakelock/wakelock.dart';



class MoviePlayer extends StatefulWidget {
   MoviePlayer({Key? key,required this.path}) : super(key: key);
  
  String path;
  
  @override
  _SingleTabState createState() => _SingleTabState();
}




class _SingleTabState extends State<MoviePlayer> {
  late VlcPlayerController _controller;
  final _key = GlobalKey<PlayerForMoviesState>();


  @override
  void initState() {
    super.initState();

    setLandscape();



        _controller = VlcPlayerController.network(
          widget.path,
          hwAcc: HwAcc.FULL,
          autoPlay: true,
          options: VlcPlayerOptions(
            advanced: VlcAdvancedOptions([
              VlcAdvancedOptions.networkCaching(2000),
            ]),
            subtitle: VlcSubtitleOptions([
              VlcSubtitleOptions.boldStyle(true),
              VlcSubtitleOptions.fontSize(30),
              VlcSubtitleOptions.outlineColor(VlcSubtitleColor.yellow),
              VlcSubtitleOptions.outlineThickness(VlcSubtitleThickness.normal),
              // works only on externally added subtitles
              VlcSubtitleOptions.color(VlcSubtitleColor.navy),
            ]),
            http: VlcHttpOptions([
              VlcHttpOptions.httpReconnect(true),
            ]),
            rtp: VlcRtpOptions([
              VlcRtpOptions.rtpOverRtsp(true),
            ]),
          ),
        );


  }
  @override
  Future<void> deactivate() async {
    await _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() async {
    setAllOrientation();
    super.dispose();

    await _controller.dispose();

  }
  
  

  
  

  Future setLandscape() async{
    await SystemChrome.setEnabledSystemUIOverlays([]);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    await Wakelock.enable();
  }


  Future setAllOrientation() async{
    await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    await SystemChrome.setPreferredOrientations(
      DeviceOrientation.values,
    );
    await Wakelock.disable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlayerForMovies(
        key: _key,
        controller: _controller,
      ),
    );
  }

}
