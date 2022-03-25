
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';


class PlayerForMovies extends StatefulWidget {
  final VlcPlayerController controller;
  final bool showControls;

  const PlayerForMovies({
    required Key key,
    required this.controller,
    this.showControls = true,
  })  : assert(controller != null, 'You must provide a vlc controller'),
        super(key: key);

  @override
  PlayerForMoviesState createState() => PlayerForMoviesState();
}

class PlayerForMoviesState extends State<PlayerForMovies>
    with AutomaticKeepAliveClientMixin {
  static const _playerControlsBgColor = Colors.black87;

  late VlcPlayerController _controller;

  //
  final double initSnapshotRightPosition = 10;
  final double initSnapshotBottomPosition = 10;
  late OverlayEntry _overlayEntry;

  //
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
  static const double _seekButtonIconSize = 40;
  static const Color _iconColor = Colors.white;

  static const Duration _seekStepForward = Duration(seconds: 10);
  static const Duration _seekStepBackward = Duration(seconds: -10);

  //
  List<double> playbackSpeeds = [0.5, 1.0, 2.0];
  int playbackSpeedIndex = 1;

  bool tapped = false;
  bool _Wakeup = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _controller.addListener(listener);

  }

  @override
  void dispose() {
    _controller.removeListener(listener);

    super.dispose();
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

    super.build(context);
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




  Widget ControlsOverlay() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 50),
      reverseDuration: const Duration(milliseconds: 200),
      child: Builder(
        builder: (ctx) {
          if (_controller.value.isEnded || _controller.value.hasError) {
            return Center(
              child: FittedBox(
                child: IconButton(
                  onPressed: _replay,
                  color: _iconColor,
                  iconSize: _replayButtonIconSize,
                  icon: Icon(Icons.replay),
                ),
              ),
            );
          }

          switch (_controller.value.playingState) {
            case PlayingState.initialized:

            case PlayingState.stopped:

            case PlayingState.paused:
              // return SizedBox.expand(
              //   child: Container(
              //     color: Colors.black45,
              //     child: FittedBox(
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         mainAxisAlignment: MainAxisAlignment.spaceAround,
              //         children: [
              //           IconButton(
              //             onPressed: () => _seekRelative(_seekStepBackward),
              //             color: _iconColor,
              //             iconSize: _seekButtonIconSize,
              //             icon: Icon(Icons.replay_10),
              //           ),
              //           IconButton(
              //               onPressed: _play,
              //               color: _iconColor,
              //               iconSize: _playButtonIconSize,
              //               icon: _controller.value.isPlaying
              //                   ? Icon(Icons.pause)
              //                   : Icon(Icons.play_arrow)),
              //           IconButton(
              //             onPressed: () => _seekRelative(_seekStepForward),
              //             color: _iconColor,
              //             iconSize: _seekButtonIconSize,
              //             icon: Icon(Icons.forward_10),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // );

            case PlayingState.buffering:

            case PlayingState.playing:

            case PlayingState.ended:
            case PlayingState.error:
              // return Center(
              //   child: FittedBox(
              //     child: IconButton(
              //       onPressed: _replay,
              //       color: _iconColor,
              //       iconSize: _replayButtonIconSize,
              //       icon: Icon(Icons.replay),
              //     ),
              //   ),
              // );
            default:
              return SizedBox.shrink();
          }
        },
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
                          onPressed: ()=>Navigator.pop(context),
                        ),

                        Stack(
                          children: [
                            IconButton(
                              tooltip: 'Get Subtitle Tracks',
                              icon: const Icon(Icons.closed_caption),
                              color: Colors.white,
                              onPressed: _getSubtitleTracks,
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
                                    '$numberOfCaptions',
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
                        Stack(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.timer),
                              color: Colors.white,
                              onPressed: _cyclePlaybackSpeed,
                            ),
                            Positioned(
                              bottom: 7,
                              right: 3,
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
                                    '${playbackSpeeds.elementAt(playbackSpeedIndex)}x',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 8,
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
                            'Size: ' +
                                (_controller.value.size.width.toInt())
                                    .toString() +
                                'x' +
                                (_controller.value.size.height.toInt())
                                    .toString(),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white, fontSize: 10),
                          ),
                          const SizedBox(height: 5),
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
                  onPressed: () => _seekRelative(_seekStepBackward),
                  color: _iconColor,
                  iconSize: _seekButtonIconSize,
                  icon: const Icon(Icons.replay_10),
                ),
                IconButton(
                    onPressed: _play,
                    color: _iconColor,
                    iconSize: _playButtonIconSize,
                    icon: _controller.value.isPlaying
                        ? const Icon(Icons.pause)
                        : const Icon(Icons.play_arrow)),
                IconButton(
                  onPressed: () => _seekRelative(_seekStepForward),
                  color: _iconColor,
                  iconSize: _seekButtonIconSize,
                  icon: const Icon(Icons.forward_10),
                ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            position,
                            style: const TextStyle(color: Colors.white),
                          ),
                          Expanded(
                            child: Slider(
                              activeColor: Colors.redAccent,
                              inactiveColor: Colors.white70,
                              value: sliderValue,
                              min: 0.0,
                              max: (!validPosition &&
                                  _controller.value.duration == null)
                                  ? 1.0
                                  : _controller.value.duration.inSeconds.toDouble(),
                              onChanged:
                              validPosition ? _onSliderPositionChanged : null,
                            ),
                          ),
                          Text(
                            duration,
                            style: const TextStyle(color: Colors.white),
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
                              tooltip: 'Get Subtitle Tracks',
                              icon: const Icon(Icons.closed_caption),
                              color: Colors.white,
                              onPressed: _getSubtitleTracks,
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
                                    '$numberOfCaptions',
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
                        Stack(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.timer),
                              color: Colors.white,
                              onPressed: _cyclePlaybackSpeed,
                            ),
                            Positioned(
                              bottom: 7,
                              right: 3,
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
                                    '${playbackSpeeds.elementAt(playbackSpeedIndex)}x',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 8,
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
                            'Size: ' +
                                (_controller.value.size.width.toInt())
                                    .toString() +
                                'x' +
                                (_controller.value.size.height.toInt())
                                    .toString(),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white, fontSize: 10),
                          ),
                          const SizedBox(height: 5),
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
                  onPressed: () => _seekRelative(_seekStepBackward),
                  color: _iconColor,
                  iconSize: _seekButtonIconSize,
                  icon: const Icon(Icons.replay_10),
                ),
                IconButton(
                    onPressed: _play,
                    color: _iconColor,
                    iconSize: _playButtonIconSize,
                    icon: _controller.value.isPlaying
                        ? const Icon(Icons.pause)
                        : const Icon(Icons.play_arrow)),
                IconButton(
                  onPressed: () => _seekRelative(_seekStepForward),
                  color: _iconColor,
                  iconSize: _seekButtonIconSize,
                  icon: const Icon(Icons.forward_10),
                ),
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
                        children: [
                          Text(
                            position,
                            style: const TextStyle(color: Colors.white),
                          ),
                          Expanded(
                            child: Slider(
                              activeColor: Colors.redAccent,
                              inactiveColor: Colors.white70,
                              value: sliderValue,
                              min: 0.0,
                              max: (!validPosition &&
                                  _controller.value.duration == null)
                                  ? 1.0
                                  : _controller.value.duration.inSeconds.toDouble(),
                              onChanged:
                              validPosition ? _onSliderPositionChanged : null,
                            ),
                          ),
                          Text(
                            duration,
                            style: const TextStyle(color: Colors.white),
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


  Future getHide()async{
    Future.delayed(const Duration(seconds: 5),(){
      setState(() {
        _Wakeup=false;
      });
    });
  }


  void _cyclePlaybackSpeed() async {
    playbackSpeedIndex++;
    if (playbackSpeedIndex >= playbackSpeeds.length) {
      playbackSpeedIndex = 0;
    }
    return await _controller
        .setPlaybackSpeed(playbackSpeeds.elementAt(playbackSpeedIndex));
  }

  void _setSoundVolume(value) {
    setState(() {
      volumeValue = value;
    });

    _controller.setVolume(volumeValue.toInt());
  }

  void _togglePlaying() async {
    _controller.value.isPlaying
        ? await _controller.pause()
        : await _controller.play();
  }

  void _onSliderPositionChanged(double progress) {
    setState(() {
      sliderValue = progress.floor().toDouble();
    });
    //convert to Milliseconds since VLC requires MS to set time
    _controller.setTime(sliderValue.toInt() * 1000);
  }

  void _getSubtitleTracks() async {
    // if (!_controller.value.isPlaying) return;

    var subtitleTracks = await _controller.getSpuTracks();
    //
    if (subtitleTracks != null && subtitleTracks.isNotEmpty) {
      var selectedSubId = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Select Subtitle'),
            backgroundColor: Colors.white.withOpacity(1),
            content: SizedBox(
              width: 500,
              height: 200,
              child: ListView.builder(
                itemCount: subtitleTracks.keys.length + 1,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      index < subtitleTracks.keys.length
                          ? subtitleTracks.values.elementAt(index).toString()
                          : 'Disable',
                    ),
                    onTap: () {
                      Navigator.pop(
                        context,
                        index < subtitleTracks.keys.length
                            ? subtitleTracks.keys.elementAt(index)
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
      if (selectedSubId != null) await _controller.setSpuTrack(selectedSubId);
    }
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

  Future<void> _pause() async {
    if (_controller.value.isPlaying) {
      await _controller.pause();
    }
  }

  Future<void> _seekRelative(Duration seekStep) async {
    if (_controller.value.duration != null) {
      await _controller.seekTo(_controller.value.position + seekStep);
    }
  }
}
