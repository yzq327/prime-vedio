import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/utils/commom_srting_helper.dart';
import 'package:primeVedio/utils/ui_data.dart';
import 'package:video_player/video_player.dart';

import 'commom_text.dart';

class CommonVideoPlayer extends StatefulWidget {
  final String url;
  late final String? vodName;

  CommonVideoPlayer({
    Key? key,
    required this.url,
    this.vodName,
  }) : super(key: key);

  _CommonVideoPlayerState createState() => _CommonVideoPlayerState();
}

class _CommonVideoPlayerState extends State<CommonVideoPlayer> {
  VideoPlayerController? _videoPlayerController;
  late Timer? _timer;
  bool _hidePlayControl = true;
  bool _hidePauseIcon = true;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  late double tempDuration;

  playByUrl (String url) {
    _videoPlayerController?.dispose();
    _videoPlayerController = VideoPlayerController.network(url)
      ..initialize()
      ..addListener(() {
        position = _videoPlayerController?.value.position ?? Duration.zero;
        duration = _videoPlayerController?.value.duration ?? Duration.zero;
        setState(() {});
      })
      ..play();
  }

  /// 是否全屏
  bool get _isFullScreen =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  @override
  void initState() {
    super.initState();
    playByUrl(widget.url);
  }

  @override
  void didUpdateWidget(covariant CommonVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.url != widget.url) {
      playByUrl(widget.url);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController!.dispose();
    _timer?.cancel();
  }

  void _playOrPause() {
    _videoPlayerController!.value.isPlaying
        ? _videoPlayerController!.pause()
        : _videoPlayerController!.play();
    setState(() {
      _hidePauseIcon = _videoPlayerController!.value.isPlaying ? true : false;
    });
  }

  void _togglePlayControl() {
    if (_hidePlayControl) {
      _startPlayControlTimer();
    }
    setState(() {
      _hidePlayControl = !_hidePlayControl;
    });
  }

  void _startPlayControlTimer() {
       // _timer?.cancel();
    _timer = Timer(Duration(seconds: 3), () {
      setState(() {
        Future.delayed(Duration(milliseconds: 300)).whenComplete(() {
          _hidePlayControl = true;
        });
      });
    });
  }

  void _toggleFullScreen() {}

  bool get showLoading {
    // print('_videoPlayerController.value.isBuffering: ${_videoPlayerController.value.isBuffering}');
    // print('_videoPlayerController.value.isPlaying: ${_videoPlayerController.value.isPlaying}');
    // return !_videoPlayerController.value.isInitialized ||
    //     (!_videoPlayerController.value.isPlaying &&
    //         _videoPlayerController.value.isBuffering);
    return !_videoPlayerController!.value.isInitialized;
  }

  Widget _buildStatusIcon() {
    return Container(
      color: UIData.videoStateBgColor,
      padding: EdgeInsets.all(UIData.spaceSizeWidth8),
      child: showLoading
          ? CircularProgressIndicator(
              strokeWidth: 2.0, color: UIData.primaryColor)
          : Icon(
              _videoPlayerController!.value.isPlaying
                  ? Icons.pause
                  : Icons.play_arrow,
              size: UIData.spaceSizeWidth26,
              color: UIData.primaryColor,
            ),
    );
  }

  // 拦截返回键
  Future<bool> _onWillPop() async {
    if (_isFullScreen) {
      _toggleFullScreen();
      return false;
    }
    return true;
  }

  void backPress() {
    // 如果是全屏，点击返回键则关闭全屏，如果不是，则系统返回键
    if (_isFullScreen) {
      _toggleFullScreen();
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: AspectRatio(
                aspectRatio: _videoPlayerController!.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController!),
              ),
            ),
          ),
          Positioned.fill(
            child: Center(
              child: showLoading ? _buildStatusIcon() : SizedBox(),
            ),
          ),
          GestureDetector(
            onDoubleTap: _playOrPause,
            onTap: _togglePlayControl,
            child: Container(

              // width: double.infinity,
              // height: double.infinity,
              color: Colors.transparent,
              child: WillPopScope(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: AnimatedOpacity(
                        opacity: _hidePauseIcon ? 0 : 1,
                        duration: Duration(milliseconds: 300),
                        child: Center(
                          child: _buildStatusIcon(),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: AnimatedOpacity(
                        opacity: _hidePlayControl ? 0 : 1,
                        duration: Duration(milliseconds: 300),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                alignment: Alignment.center,
                                height: UIData.spaceSizeHeight44,
                                color: UIData.videoSlideBgColor,
                                child: Row(
                                  children: <Widget>[
                                    IconButton(
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.white,
                                        ),
                                        onPressed: backPress),
                                    CommonText.text18(
                                      widget.vodName ?? '',
                                      color: UIData.primaryColor,
                                    ),
                                  ],
                                )
                            ),
                            Container(
                                height: UIData.spaceSizeHeight32,
                                color: duration == Duration.zero
                                    ? Colors.transparent
                                    : UIData.videoSlideBgColor,
                                child: duration == Duration.zero
                                    ? SizedBox()
                                    : Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.zero,
                                            width: UIData.spaceSizeWidth80,
                                            alignment: Alignment.center,
                                            child: CommonText.text18(
                                                StringsHelper.formatDuration(
                                                   position)),
                                          ),
                                          Slider(
                                            value: position.inSeconds
                                                .toDouble(),
                                            min: 0,
                                            max: duration.inSeconds
                                                .toDouble(),
                                            divisions:
                                                duration.inSeconds,
                                            activeColor: UIData.primaryColor,
                                            inactiveColor:
                                                UIData.videoStateDefaultColor,
                                            label:
                                                '${StringsHelper.formatDuration(position)}',
                                            // onChanged: (double value) {
                                            //   _videoPlayerController.seekTo(
                                            //       Duration(
                                            //           seconds: value.toInt()));
                                            // },
                                            onChangeStart: (double value) {
                                              tempDuration =  value;
                                            },
                                            onChangeEnd: (double value) {
                                              _videoPlayerController?.seekTo(
                                                  Duration(
                                                      seconds: value.toInt()));
                                            }, onChanged: (double value) {
                                              setState(() {
                                                tempDuration = value;
                                              });
                                          },
                                          ),
                                          CommonText.text18(
                                              StringsHelper.formatDuration(
                                                  duration)),
                                        ],
                                      )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                onWillPop: _onWillPop,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
