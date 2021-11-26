import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/utils/commom_srting_helper.dart';
import 'package:primeVedio/utils/ui_data.dart';
import 'package:video_player/video_player.dart';

import 'commom_text.dart';

class CommonVideoPlayer extends StatefulWidget {
  final String url;
  late final String? vodName;
  late final String? vodPic;

  CommonVideoPlayer({Key? key, required this.url, this.vodName, this.vodPic})
      : super(key: key);

  _CommonVideoPlayerState createState() => _CommonVideoPlayerState();
}

class _CommonVideoPlayerState extends State<CommonVideoPlayer> {
  VideoPlayerController? _videoPlayerController;
  Timer? _timer;
  bool _showTagging = false;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  late double tempDuration;

  playByUrl(String url) {
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
    if (oldWidget.url != widget.url) {
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
  }

  void _togglePlayControl() {
    if (!_showTagging) {
      _startPlayControlTimer();
    }
    setState(() {
      _showTagging = !_showTagging;
    });
  }

  void _startPlayControlTimer() {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: 3), () {
      setState(() {
        Future.delayed(Duration(milliseconds: 300)).whenComplete(() {
          _showTagging = false;
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

  Widget _buildShowLoading() {
    return Positioned.fill(
      child: AnimatedOpacity(
        opacity: showLoading ? 1 : 0,
        duration: Duration(milliseconds: 300),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: CachedNetworkImageProvider(widget.vodPic!),
            alignment: Alignment.topLeft,
            fit: BoxFit.cover,
          )),
          child: Container(
            color: UIData.videoStateBgColor,
            padding: EdgeInsets.all(UIData.spaceSizeWidth8),
            child: CircularProgressIndicator(
                strokeWidth: 2.0, color: UIData.primaryColor),
          ),
        ),
      ),
    );
  }

  Widget _buildShowPauseIcon() {
    return Positioned.fill(
      child: AnimatedOpacity(
        opacity: _videoPlayerController!.value.isPlaying ? 0 : 1,
        duration: Duration(milliseconds: 300),
        child: Center(
          child: Container(
            color: UIData.videoStateBgColor,
            padding: EdgeInsets.all(UIData.spaceSizeWidth8),
            child: Icon(
              Icons.play_arrow,
              size: UIData.spaceSizeWidth26,
              color: UIData.primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShowTaggingContent() {
    return Positioned.fill(
      child: AnimatedOpacity(
        opacity: _showTagging ? 1 : 0,
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
                )),
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
                                StringsHelper.formatDuration(position)),
                          ),
                          Slider(
                            value: position.inSeconds.toDouble(),
                            min: 0,
                            max: duration.inSeconds.toDouble(),
                            divisions: duration.inSeconds,
                            activeColor: UIData.primaryColor,
                            inactiveColor: UIData.videoStateDefaultColor,
                            label: '${StringsHelper.formatDuration(position)}',
                            onChangeStart: (double value) {
                              tempDuration = value;
                            },
                            onChangeEnd: (double value) {
                              _videoPlayerController
                                  ?.seekTo(Duration(seconds: value.toInt()));
                            },
                            onChanged: (double value) {
                              setState(() {
                                tempDuration = value;
                              });
                            },
                          ),
                          CommonText.text18(
                              StringsHelper.formatDuration(duration)),
                        ],
                      )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _playOrPause,
      onTap: _togglePlayControl,
      child: Container(
        color: Colors.transparent,
        child: AspectRatio(
          aspectRatio: _videoPlayerController!.value.isInitialized
              ? _videoPlayerController!.value.aspectRatio
              : (16 / 9),
          child: WillPopScope(
            child: Stack(
              children: [
                VideoPlayer(_videoPlayerController!),
                _buildShowLoading(),
                _buildShowPauseIcon(),
                _buildShowTaggingContent(),
              ],
            ),
            onWillPop: _onWillPop,
          ),
        ),
      ),
    );
  }
}
