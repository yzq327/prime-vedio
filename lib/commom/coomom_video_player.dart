import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_display_brightness/device_display_brightness.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:primeVedio/utils/commom_srting_helper.dart';
import 'package:primeVedio/utils/font_icon.dart';
import 'package:primeVedio/utils/ui_data.dart';
import 'package:video_player/video_player.dart';
import 'package:volume_controller/volume_controller.dart';

import 'commom_slider.dart';
import 'commom_text.dart';
import 'common_basic_slider.dart';

class SpeedText {
  String text;
  double speedValue;
  SpeedText(this.text, this.speedValue);
}

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
  bool _showSpeedSelect = false;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  double defaultAspectRatio = 16 / 9;
  double currentSpeed = 1.0;
  bool isLock = false;
  double currentVolume = 0.5;
  double currentBrightness = 0.0;

  List<SpeedText> get getSpeedText {
    return [
      SpeedText('正常', 1.0),
      SpeedText('1.25X', 1.25),
      SpeedText('1.5X', 1.5),
      SpeedText('1.75X', 1.75),
      SpeedText('2.0X', 2.0),
      SpeedText('3.0X', 3.0),
    ];
  }

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
    DeviceDisplayBrightness.getBrightness()
        .then((value) => currentBrightness = value);
    VolumeController().getVolume().then((volume) => currentVolume = volume);
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
    if (_videoPlayerController!.value.isInitialized) {
      _videoPlayerController!.value.isPlaying
          ? _videoPlayerController!.pause()
          : _videoPlayerController!.play();
    }
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
    // print('_videoPlayerController.value.isInitialized: ${_videoPlayerController!.value.isBuffering}');
    // print('_videoPlayerController.value.isBuffering: ${_videoPlayerController!.value.isBuffering}');
    // print('_videoPlayerController.value.isPlaying: ${_videoPlayerController!.value.isPlaying}');
    // print('currentSpeed-------: $currentSpeed');
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

  void handleChangeSlider(double value) {
    _videoPlayerController?.seekTo(Duration(seconds: value.toInt()));
    _startPlayControlTimer();
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
            image:
                CachedNetworkImageProvider(widget.vodPic!, errorListener: () {
              print('图片加载错误');
            }),
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

  Widget _buildOperationIcon(IconData icon, GestureTapCallback onTap) {
    return Padding(
      padding: EdgeInsets.only(right: UIData.spaceSizeWidth8),
      child: GestureDetector(
        child: Icon(
          icon,
          color: UIData.primaryColor,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildBackRow() {
    return Visibility(
      visible: !isLock,
      child: Container(
          alignment: Alignment.center,
          height: UIData.spaceSizeHeight44,
          color: UIData.videoSlideBgColor,
          child: Center(
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
            ),
          )),
    );
  }

  Widget _buildLockIcon() {
    return Container(
        alignment: Alignment.centerRight,
        child: IconButton(
            icon: Icon(
              isLock ? IconFont.icon_suofuben : IconFont.icon_jiesuofuben,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isLock = !isLock;
              });
              _startPlayControlTimer();
            }));
  }

  Widget _buildButtonOperateRow() {
    return Visibility(
      visible: !isLock,
      child: Container(
          height: UIData.spaceSizeHeight32,
          color: duration == Duration.zero
              ? Colors.transparent
              : UIData.videoSlideBgColor,
          child: duration == Duration.zero
              ? SizedBox()
              : Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: UIData.spaceSizeWidth8),
                      child: CommonText.text18(
                          StringsHelper.formatDuration(position)),
                    ),
                    Expanded(
                        child: CommonSlider(
                            position: position,
                            duration: duration,
                            onChangeEnd: (value) => handleChangeSlider(value))),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: UIData.spaceSizeWidth8),
                      child: CommonText.text18(
                          StringsHelper.formatDuration(duration)),
                    ),
                    _buildOperationIcon(
                      IconFont.icon_sudu___,
                      () => setState(() {
                        _showSpeedSelect = !_showSpeedSelect;
                      }),
                    ),
                    _buildOperationIcon(
                      IconFont.icon_quanping_,
                      () => setState(() {
                        _showSpeedSelect = !_showSpeedSelect;
                      }),
                    ),
                  ],
                )),
    );
  }

  Widget _buildShowTaggingContent() {
    return Positioned.fill(
      child: Offstage(
        offstage: !_showTagging,
        child: AnimatedOpacity(
          opacity: _showTagging ? 1 : 0,
          duration: Duration(milliseconds: 300),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBackRow(),
              _buildLockIcon(),
              _buildButtonOperateRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShowSpeedContent() {
    return Positioned.fill(
      child: Offstage(
        offstage: !_showSpeedSelect,
        child: AnimatedOpacity(
          opacity: _showSpeedSelect ? 1 : 0,
          duration: Duration(milliseconds: 300),
          child: Container(
            color: UIData.videoStateBgColor,
            padding: EdgeInsets.all(UIData.spaceSizeHeight40),
            child: SizedBox(
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: UIData.spaceSizeWidth16,
                ),
                itemCount: getSpeedText.length,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                  child: Center(
                      child: CommonText.text18(getSpeedText[index].text,
                          color: currentSpeed == getSpeedText[index].speedValue
                              ? UIData.hoverThemeBgColor
                              : UIData.primaryColor)),
                  onTap: () {
                    setState(() {
                      _showSpeedSelect = false;
                      currentSpeed = getSpeedText[index].speedValue;
                    });
                    Fluttertoast.showToast(
                        msg: "已切换至${getSpeedText[index].text}",
                        timeInSecForIosWeb: 2,
                        gravity: ToastGravity.CENTER);
                    _videoPlayerController!
                        .setPlaybackSpeed(getSpeedText[index].speedValue);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVolumeSlider() {
    return Positioned.fill(
        top: UIData.spaceSizeHeight50,
        bottom: UIData.spaceSizeHeight50,
        right: UIData.spaceSizeHeight10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Row(
              children: [
                Container(
                  width: UIData.spaceSizeWidth10,
                  child: CommonBasicSlider(
                    currentValue: currentVolume,
                    onChange: (double value) {
                      VolumeController().setVolume(value);
                      setState(() {
                        currentVolume = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    IconFont.icon_yinliang,
                    color: UIData.primaryColor,
                  ),
                )
              ],
            ),
          ],
        ));
  }

  Widget _buildBrightnessSlider() {
    return Positioned.fill(
        top: UIData.spaceSizeHeight50,
        bottom: UIData.spaceSizeHeight50,
        left: UIData.spaceSizeHeight10,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                IconFont.icon_liangdu,
                color: UIData.primaryColor,
              ),
            ),
            Container(
              width: UIData.spaceSizeWidth10,
              child: CommonBasicSlider(
                currentValue: currentBrightness,
                onChange: (double value) {
                  DeviceDisplayBrightness.setBrightness(value);
                  setState(() {
                    currentBrightness = value;
                  });
                },
              ),
            ),
          ],
        ));
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
              : defaultAspectRatio,
          child: WillPopScope(
            child: Stack(
              children: [
                VideoPlayer(_videoPlayerController!),
                _buildShowLoading(),
                _buildShowPauseIcon(),
                _buildShowTaggingContent(),
                _buildShowSpeedContent(),
                _buildBrightnessSlider(),
                _buildVolumeSlider(),
              ],
            ),
            onWillPop: _onWillPop,
          ),
        ),
      ),
    );
  }
}
