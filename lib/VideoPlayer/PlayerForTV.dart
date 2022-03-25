import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:fluttertest/Models/SingleTvModel.dart';
import 'package:fluttertest/Pages/TvPlayerPage.dart';
import 'package:wakelock/wakelock.dart';


class PlayerForTV extends StatefulWidget {
  PlayerForTV({Key? key,required this.DATA,}) : super(key: key);

  SingleTvModel DATA;

  @override
  State<PlayerForTV> createState() => _PlayerForTVState();
}

class _PlayerForTVState extends State<PlayerForTV> {

  late VlcPlayerController _controller;

  late String SD='',sdLink='';
  late String LQ='',lqLink='';
  late String Path=widget.DATA.streamUrl;

  bool hD=true,sD=false,lQ=false;

  bool mainVisible=true;


  bool tapped = false;
  bool _Wakeup = true;
  double sliderValue = 0.0;
  double volumeValue = 100;
  String position = '';
  String duration = '';
  int numberOfCaptions = 0;
  int numberOfAudioTracks = 0;
  bool validPosition = false;
  bool isFullscreen = false;

  double recordingTextOpacity = 0;
  DateTime lastRecordingShowTime = DateTime.now();
  bool isRecording = false;

  static const double _playButtonIconSize = 40;
  static const double _replayButtonIconSize = 40;
  static const Color _iconColor = Colors.white;
  static const _playerControlsBgColor = Colors.black87;

  bool tap=false;
  bool toog=true;


  @override
  void initState() {
    super.initState();
    _controller = VlcPlayerController.network(
      Path,
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
    _controller.addListener(listener);
    setWakeUp();
    setSD(widget.DATA.additionalMediaSource);
    setLQ(widget.DATA.additionalMediaSource);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

  }



  @override
  Future<void> deactivate() async {
    await _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() async {
    setAllOrientation();
    _controller.removeListener(listener);
    super.dispose();
    setWakeDown();

  }


  Future setWakeUp() async{
    await Wakelock.enable();
  }

  Future setWakeDown() async{
    await Wakelock.disable();
  }




  Future setAllOrientation() async{
    await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    await SystemChrome.setPreferredOrientations(
      DeviceOrientation.values,
    );

  }


  void listener() async {
    if (!mounted) return;
    //
    if (_controller.value.isInitialized) {
      var oPosition = _controller.value.position;
      var oDuration = _controller.value.duration;
      if (oPosition != null && oDuration != null) {
        if (oDuration.inHours == 0) {
          var strPosition = oPosition.toString().split('.')[0];
          var strDuration = oDuration.toString().split('.')[0];
          position =
          "${strPosition.split(':')[1]}:${strPosition.split(':')[2]}";
          duration =
          "${strDuration.split(':')[1]}:${strDuration.split(':')[2]}";
        } else {
          position = oPosition.toString().split('.')[0];
          duration = oDuration.toString().split('.')[0];
        }
        validPosition = oDuration.compareTo(oPosition) >= 0;
        sliderValue = validPosition ? oPosition.inSeconds.toDouble() : 0;
      }
      numberOfCaptions = _controller.value.spuTracksCount;
      numberOfAudioTracks = _controller.value.audioTracksCount;
      // update recording blink widget
      if (_controller.value.isRecording && _controller.value.isPlaying) {
        if (DateTime.now().difference(lastRecordingShowTime).inSeconds >= 1) {
          lastRecordingShowTime = DateTime.now();
          recordingTextOpacity = 1 - recordingTextOpacity;
        }
      } else {
        recordingTextOpacity = 0;
      }
      setState(() {});
    }
  }





  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(toog==true){
          return true;
        }else{
          if(tap==false) {
            tap = true;
          }else{tap=false;}
          setState(() {
            mainVisible=false;
            if(toog==false){
              toog=true;
            }else{
              toog=false;
            }

          });
          _Fullscreen();
          return false;
        }

      },
      child: Scaffold(

        body:SingleChildScrollView(
          child: Column(
            children: [
              //for top bar and top color..............
              Visibility(
                visible: mainVisible,
                child: Container(
                  // Background
                  color: Colors.red[500],
                  height: MediaQuery.of(context).size.height * 0.057,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                height: toog? 250: MediaQuery.of(context).size.height,
                child: PlayerTv(),
              ),
              Visibility(
                  visible: mainVisible,
                  child: Body(widget.DATA)),
            ],
          ),
        ),
      ),
    );
  }


  Widget Body(SingleTvModel data){
    return Column(
      children: [

        Visibility(
          visible: mainVisible,
          child: SizedBox(
            height: 50,
            child: Row(
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      lQ=false;
                      hD=true;
                      sD=false;
                    });
                    Path=data.streamUrl;
                    _controller.setMediaFromNetwork(
                      Path,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 10,right: 10),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: hD? Colors.red[500] : Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(child: Text(data.streamLabel,style: const TextStyle(fontWeight: FontWeight.bold),)),
                  ),
                ),


                getSD(),
                getLQ(),
              ],
            ),
          ),
        ),

        Visibility(
          visible: mainVisible,
          child: Container(
            height: 100,
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 20,right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(data.posterUrl,
                          fit: BoxFit.fill,height: 80,width: 90,),
                      ),
                    ),
                    Center(child: Text(data.tvName,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.flag_outlined),
                  color: Colors.red[400],
                  onPressed: () {
                    print("report button");
                  },
                ),
              ],
            ),
          ),
        ),

        Visibility(
          visible: mainVisible,
          child: Container(
            margin: const EdgeInsets.only(left: 20,top: 20),
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Now Watching",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                Text(data.currentProgramTime+"  "+data.currentProgramTitle,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
              ],
            ),
          ),
        ),

        Visibility(
          visible: mainVisible,
          child: Container(
            height: 200,
            margin: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment(-0.9, 0),
                  child: Text("Featured Tv Channel",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20)),
                ),
                SizedBox(
                  height: 155,
                  child: ListView.builder(
                      itemCount: data.allTvChannel.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>TvPlayerPage(type: 'tv', ID: data.allTvChannel[index].liveTvId)));
                          },
                          child: Card(
                            color: Colors.grey[50],
                            elevation: 0,
                            margin: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    data.allTvChannel[index].posterUrl,
                                    fit: BoxFit.fill,
                                    height: 60,
                                    width: 90,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                FittedBox(
                                  fit: BoxFit.fill,
                                  child: Text(
                                      data.allTvChannel[index].tvName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 15,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }

  void setSD(List<AdditionalMediaSource> source){
    for(int i=0;i<source.length;i++){
      if(source[i].label=='SD'){
        SD=source[i].label;
        sdLink=source[i].url;
      }
    }
  }

  void setLQ(List<AdditionalMediaSource> source){
    for(int i=0;i<source.length;i++){
      if(source[i].label=='LQ'){
        LQ=source[i].label;
        lqLink=source[i].url;
      }
    }
  }

  Widget getSD(){
    if(SD.isEmpty){
      return Container();
    }else{
      return InkWell(
        onTap: (){
          setState(() {
            lQ=false;
            hD=false;
            sD=true;
          });

          Path=sdLink;
          _controller.setMediaFromNetwork(
            Path,
          );
        },
        child: Container(
          margin: const EdgeInsets.only(left: 10,right: 10),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: sD?Colors.red[500] : Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(child: Text(SD,style: const TextStyle(fontWeight: FontWeight.bold),)),
        ),
      );
    }
  }

  Widget getLQ(){
    if(LQ.isEmpty){
      return Container();
    }else{
      return InkWell(
        onTap: (){
          setState(() {
            lQ=true;
            hD=false;
            sD=false;
          });
          Path=lqLink;
          _controller.setMediaFromNetwork(
            Path,
          );
        },
        child: Container(
          margin: const EdgeInsets.only(left: 10,right: 10),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: lQ?Colors.red[500] : Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(child: Text(LQ,style: const TextStyle(fontWeight: FontWeight.bold),)),
        ),
      );
    }
  }

  Widget PlayerTv(){
    return InkWell(
      onTap:(){
        if(!_Wakeup){

          _Wakeup=true;}else{_Wakeup=false;}
      },
      child: Container(
        color: Colors.black,
        child: Stack(
          alignment: Alignment.bottomCenter,
          fit: StackFit.expand,
          children: <Widget>[
            VlcPlayer(
              controller: _controller,
              aspectRatio: _controller.value.aspectRatio,
              placeholder: const Center(child: CircularProgressIndicator()),
            ),

            Visibility(
                visible: _Wakeup,
                child: WakeupButtons())

          ],
        ),
      ),
    );
  }


  Widget WakeupButtons() {
    if(_controller.value.isPlaying){
      return SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [


            Visibility(
              visible: _Wakeup,
              child: Container(
                width: double.infinity,
                color: _playerControlsBgColor.withOpacity(0.0),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [

                    Wrap(
                      children: [

                        IconButton(
                            tooltip: 'Back',
                            icon: const Icon(Icons.arrow_back_outlined),
                            color: Colors.white,
                            onPressed: () {
                              if (toog == true) {
                                Navigator.pop(context);
                              } else {
                                if (tap == false) {
                                  tap = true;
                                } else {
                                  tap = false;
                                }
                                setState(() {
                                  mainVisible = false;
                                  if (toog == false) {
                                    toog = true;
                                  } else {
                                    toog = false;
                                  }
                                });
                                _Fullscreen();
                              }
                            }
                        ),
                        Stack(
                          children: [
                            IconButton(
                              tooltip: 'Get Audio Tracks',
                              icon: const Icon(Icons.audiotrack),
                              color: Colors.white,
                              onPressed: _getAudioTracks,
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: IgnorePointer(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 1,
                                    horizontal: 2,
                                  ),
                                  child: Text(
                                    '$numberOfAudioTracks',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Status: ' +
                                _controller.value.playingState
                                    .toString()
                                    .split('.')[1],
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),



            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                IconButton(
                    onPressed: _play,
                    color: _iconColor,
                    iconSize: _playButtonIconSize,
                    icon: _controller.value.isPlaying
                        ? const Icon(Icons.pause)
                        : const Icon(Icons.play_arrow)),

              ],
            ),



            Visibility(
              visible: _Wakeup,
              child: Container(
                color: _playerControlsBgColor.withOpacity(0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      color: Colors.white,
                      icon: _controller.value.isPlaying
                          ? const Icon(Icons.pause_circle_outline)
                          : const Icon(Icons.play_circle_outline),
                      onPressed: _togglePlaying,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            height: 8,
                            width: 8,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const Text(
                            'LIVE',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),

                    IconButton(
                      onPressed: (){
                        if(tap==false) {
                          tap = true;
                        }else{tap=false;}
                        setState(() {
                          mainVisible=false;
                          if(toog==false){
                            toog=true;
                          }else{
                            toog=false;
                          }

                        });
                        _Fullscreen();
                      },
                      color: _iconColor,
                      icon: const Icon(Icons.zoom_out_map),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }else if(_controller.value.playingState
        .toString()
        .split('.')[1]=="buffering"){
      return const Center(child: CircularProgressIndicator());
    }else{
      return SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [


            Visibility(
              visible: _Wakeup,
              child: Container(
                width: double.infinity,
                color: _playerControlsBgColor.withOpacity(0.0),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Wrap(
                      children: [
                        IconButton(
                          tooltip: 'Back',
                          icon: const Icon(Icons.arrow_back_outlined),
                          color: Colors.white,
                          onPressed: ()=>Navigator.pop(context),
                        ),
                        Stack(
                          children: [
                            IconButton(
                              tooltip: 'Get Audio Tracks',
                              icon: const Icon(Icons.audiotrack),
                              color: Colors.white,
                              onPressed: _getAudioTracks,
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: IgnorePointer(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 1,
                                    horizontal: 2,
                                  ),
                                  child: Text(
                                    '$numberOfAudioTracks',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Status: ' +
                                _controller.value.playingState
                                    .toString()
                                    .split('.')[1],
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //centre buttons.........................................
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: _play,
                    color: _iconColor,
                    iconSize: _playButtonIconSize,
                    icon: _controller.value.isPlaying
                        ? const Icon(Icons.pause)
                        : const Icon(Icons.play_arrow)),

              ],
            ),

            //bottom buttons...........................................
            Visibility(
              visible: _Wakeup,
              child: Container(
                color: _playerControlsBgColor.withOpacity(0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      color: Colors.white,
                      icon: _controller.value.isPlaying
                          ? const Icon(Icons.pause_circle_outline)
                          : const Icon(Icons.play_circle_outline),
                      onPressed: _togglePlaying,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Text(
                            "Live",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

  }

  Future<void> _Fullscreen()async{
    if(tap==true) {
      await SystemChrome.setEnabledSystemUIOverlays([]);
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    }else{
      setState(() {
        mainVisible=true;
      });
      await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }
  }


  Future<void> _play() {
    if (_controller.value.isPlaying) {
      return _controller.pause();
    } else {
      return _controller.play();
    }
  }

  Future<void> _replay() async {
    await _controller.stop();
    await _controller.play();
  }

  void _getAudioTracks() async {
    //if (!_controller.value.isPlaying) return;

    var audioTracks = await _controller.getAudioTracks();
    //
    if (audioTracks != null && audioTracks.isNotEmpty) {
      var selectedAudioTrackId = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Select Audio'),
            content: SizedBox(
              width: 500,
              height: 200,
              child: ListView.builder(
                itemCount: audioTracks.keys.length + 1,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      index < audioTracks.keys.length
                          ? audioTracks.values.elementAt(index).toString()
                          : 'Disable',
                    ),
                    onTap: () {
                      Navigator.pop(
                        context,
                        index < audioTracks.keys.length
                            ? audioTracks.keys.elementAt(index)
                            : -1,
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      );
      if (selectedAudioTrackId != null) {
        await _controller.setAudioTrack(selectedAudioTrackId);
      }
    }
  }
  void _togglePlaying() async {
    _controller.value.isPlaying
        ? await _controller.pause()
        : await _controller.play();
  }


}
