import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/utils/commom_srting_helper.dart';
import 'package:primeVedio/utils/ui_data.dart';
import 'package:video_player/video_player.dart';

import 'commom_text.dart';

class CommonVideoPlayer extends StatefulWidget {
  final VideoPlayerController? controller;
  late final Duration? position;
  late final Duration? duration;
  String? vodName;

  CommonVideoPlayer({
    Key? key,
    required this.controller,
    this.position,
    this.duration,
    this.vodName = '影片名字',
  }) : super(key: key);

  _CommonVideoPlayerState createState() => _CommonVideoPlayerState();
}

class _CommonVideoPlayerState extends State<CommonVideoPlayer> {
  late Timer _timer; // 计时器，用于延迟隐藏控件ui
  bool _hidePlayControl = true; // 控制是否隐藏控件ui
  double _playControlOpacity = 0; // 通过透明度动画显示/隐藏控件ui

  VideoPlayerController get _videoPlayerController {
    return widget.controller!;
  }

  /// 记录是否全屏
  bool get _isFullScreen =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void _playOrPause() {
    _videoPlayerController.value.isPlaying
        ? _videoPlayerController.pause()
        : _videoPlayerController.play();
    _startPlayControlTimer(); // 操作控件后，重置延迟隐藏控件的timer
  }

  void _togglePlayControl() {
    setState(() {
      if (_hidePlayControl) {
        /// 如果隐藏则显示
        _hidePlayControl = false;
        _playControlOpacity = 1;
        _startPlayControlTimer(); // 开始计时器，计时后隐藏
      } else {
        /// 如果显示就隐藏
        _timer.cancel(); // 有计时器先移除计时器
        _playControlOpacity = 0;
        Future.delayed(Duration(milliseconds: 500)).whenComplete(() {
          _hidePlayControl = true; // 延迟500ms(透明度动画结束)后，隐藏
        });
      }
    });
  }

  void _startPlayControlTimer() {
    _timer.cancel();
    _timer = Timer(Duration(seconds: 3), () {
      setState(() {
        _playControlOpacity = 0;
        Future.delayed(Duration(milliseconds: 300)).whenComplete(() {
          _hidePlayControl = true;
        });
      });
    });
  }

  void _toggleFullScreen() {
    // setState(() {
    //   if (_isFullScreen) {
    //     /// 如果是全屏就切换竖屏
    //     AutoOrientation.portraitAutoMode();
    //
    //     ///显示状态栏，与底部虚拟操作按钮
    //     SystemChrome.setEnabledSystemUIOverlays(
    //         [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    //   } else {
    //     AutoOrientation.landscapeAutoMode();
    //
    //     ///关闭状态栏，与底部虚拟操作按钮
    //     SystemChrome.setEnabledSystemUIOverlays([]);
    //   }
    //   _startPlayControlTimer(); // 操作完控件开始计时隐藏
    // });
  }

  bool get showLoading {
    // return !_videoPlayerController.value.isInitialized ||
    //     (!_videoPlayerController.value.isPlaying &&
    //         _videoPlayerController.value.isBuffering);
    return !_videoPlayerController.value.isInitialized;
  }

  Widget _buildStatusIcon() {
    return Container(
      color: UIData.videoStateBgColor,
      margin: EdgeInsets.only(bottom: UIData.spaceSizeHeight40),
      child: showLoading
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(
                  strokeWidth: 2.0, color: UIData.primaryColor),
            )
          : IconButton(
              icon: Icon(
                _videoPlayerController.value.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow,
                size: UIData.spaceSizeWidth26,
                color: UIData.primaryColor,
              ),
              onPressed: () {
                _videoPlayerController.value.isPlaying
                    ? _videoPlayerController.pause()
                    : _videoPlayerController.play();
              },
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
    print(_isFullScreen);
    // 如果是全屏，点击返回键则关闭全屏，如果不是，则系统返回键

    if (_isFullScreen) {
      _toggleFullScreen();
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _playOrPause,
      onTap: _togglePlayControl,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: WillPopScope(
          child: Offstage(
            offstage: _hidePlayControl,
            child: AnimatedOpacity(
              // 加入透明度动画
              opacity: _playControlOpacity,
              duration: Duration(milliseconds: 300),
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: _buildStatusIcon(),
                    ),
                  ),
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            height: UIData.spaceSizeHeight44,
                            color: widget.duration == Duration.zero
                                ? Colors.transparent
                                : UIData.videoSlideBgColor,
                            child: widget.duration == Duration.zero
                                ? SizedBox()
                                : Row(
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
                            color: widget.duration == Duration.zero
                                ? Colors.transparent
                                : UIData.videoSlideBgColor,
                            child: widget.duration == Duration.zero
                                ? SizedBox()
                                : Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.zero,
                                        width: UIData.spaceSizeWidth80,
                                        alignment: Alignment.center,
                                        child: CommonText.text18(
                                            StringsHelper.formatDuration(
                                                widget.position)),
                                      ),
                                      Slider(
                                        value: widget.position!.inSeconds
                                            .toDouble(),
                                        min: 0,
                                        max: widget.duration!.inSeconds
                                            .toDouble(),
                                        divisions: widget.duration!.inSeconds,
                                        activeColor: UIData.primaryColor,
                                        inactiveColor:
                                            UIData.videoStateDefaultColor,
                                        label:
                                            '${StringsHelper.formatDuration(widget.position)}',
                                        onChanged: (double value) {
                                          _videoPlayerController.seekTo(
                                              Duration(seconds: value.toInt()));
                                        },
                                      ),
                                      CommonText.text18(
                                          StringsHelper.formatDuration(
                                              widget.duration)),
                                    ],
                                  )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          onWillPop: _onWillPop,
        ),
      ),
    );
  }
}
