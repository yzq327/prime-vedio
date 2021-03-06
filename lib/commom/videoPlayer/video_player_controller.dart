import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_display_brightness/device_display_brightness.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:primeVedio/utils/commom_srting_helper.dart';
import 'package:primeVedio/utils/font_icon.dart';
import 'package:primeVedio/utils/ui_data.dart';

import 'package:video_player/video_player.dart';
import 'package:volume_controller/volume_controller.dart';

import '../commom_slider.dart';
import '../commom_text.dart';
import '../common_basic_slider.dart';
import 'controller_widget.dart';

class SpeedText {
  String text;
  double speedValue;
  SpeedText(this.text, this.speedValue);
}

class VideoPlayerControl extends StatefulWidget {
  final Widget child;

  VideoPlayerControl({
    Key? key,
    required this.child,
  }): super(key: key);

  @override
  VideoPlayerControlState createState() => VideoPlayerControlState();
}


class VideoPlayerControlState extends State<VideoPlayerControl> {
  VideoPlayerController get _videoPlayerController => ControllerWidget.of(context)!.controller;
  bool get videoInit => ControllerWidget.of(context)!.videoInit;
  String get title=>ControllerWidget.of(context)!.title;
  String get vodPic=>ControllerWidget.of(context)!.vodPic;
  /// 记录是否全屏
  bool get _isFullScreen =>
      MediaQuery.of(context).orientation == Orientation.landscape;

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
  double _dragTop = 0.0;
  double _dragStartY = 0.0;
  bool changeBrightness = false;
  bool changeVolume = false;
  double tempValue = 0.0;

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

  bool get showLoading {
    return !_videoPlayerController.value.isInitialized;
  }

  @override
  void initState() {
    super.initState();
    DeviceDisplayBrightness.getBrightness()
        .then((value) => currentBrightness = value);
    VolumeController().getVolume().then((volume) => currentVolume = volume);
  }


  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  void _playOrPause() {
    if (_videoPlayerController.value.isInitialized) {
      _videoPlayerController.value.isPlaying
          ? _videoPlayerController.pause()
          : _videoPlayerController.play();
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

  void _toggleFullScreen() {
    // print('-----点击了_isFullScreen： $_isFullScreen');
  //   setState(() {
  //     if (_isFullScreen) {
  //       /// 如果是全屏就切换竖屏
  //       AutoOrientation.portraitAutoMode();
  //
  //       ///显示状态栏，与底部虚拟操作按钮
  //       SystemChrome.setEnabledSystemUIOverlays(
  //           [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  //     } else {
  //       AutoOrientation.landscapeAutoMode();
  //
  //       ///关闭状态栏，与底部虚拟操作按钮
  //       SystemChrome.setEnabledSystemUIOverlays([]);
  //     }
  //     _startPlayControlTimer(); // 操作完控件开始计时隐藏
  //   });
  // }
    setState(() {
      if (_isFullScreen) {
        // Navigator.push(context, MaterialPageRoute(builder: (context)  {
        //   return Material(child: build(context),);
        // }));
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

      } else {
        SystemChrome.setPreferredOrientations([
          // DeviceOrientation.portraitUp,
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft
        ]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
      }
      _startPlayControlTimer(); // 操作完控件开始计时隐藏
    });
  }


  // 供父组件调用刷新页面，减少父组件的build
  void setPosition({position, totalDuration}) {
    // print('res----: $position');
    setState(() {
      position = position;
      duration = totalDuration;
    });
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
    _videoPlayerController.seekTo(Duration(seconds: value.toInt()));
    _startPlayControlTimer();
  }

  void _handleOnPanDown(DragDownDetails e) {
    double widgetWidth = StringsHelper.getWidgetSize(context).width;
    setState(() {
      _dragStartY = e.globalPosition.dy;
      _dragTop = e.globalPosition.dy;
      tempValue = e.globalPosition.dx < widgetWidth / 2
          ? currentBrightness
          : currentVolume;
    });
  }

  void _handleOnPanUpdate(DragUpdateDetails e) {
    double widgetWidth = StringsHelper.getWidgetSize(context).width;
    setState(() {
      changeBrightness = e.globalPosition.dx < widgetWidth / 2;
      changeVolume = !changeBrightness;
      _dragTop += e.delta.dy;
      double changedHeight = (_dragStartY - _dragTop) / 140;
      double tempChange = tempValue + changedHeight;
      tempChange = tempChange < 0
          ? 0.0
          : tempChange > 1
          ? 1.0
          : tempChange;
      if (changeBrightness) {
        currentBrightness = tempChange;
        DeviceDisplayBrightness.setBrightness(currentBrightness);
      } else {
        currentVolume = tempChange;
        VolumeController().setVolume(currentVolume);
      }
    });
  }

  void _handleOnPanEnd(DragEndDetails e) {
    setState(() {
      changeBrightness = false;
      changeVolume = false;
    });
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
                CachedNetworkImageProvider(vodPic, errorListener: () {
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
        opacity: _videoPlayerController.value.isPlaying ? 0 : 1,
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
                  title,
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
          // color:  UIData.videoSlideBgColor,
          child:
          duration == Duration.zero
              ? SizedBox()
              :
          Row(
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
                    () {
                  _toggleFullScreen();
                },
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
                        _videoPlayerController
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
    return Offstage(
      offstage: !changeVolume,
      child: AnimatedOpacity(
        opacity: changeVolume ? 1 : 0,
        duration: Duration(milliseconds: 300),
        child: Row(
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
              padding: EdgeInsets.all(UIData.spaceSizeWidth10),
              child: Icon(
                IconFont.icon_yinliang,
                color: UIData.primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBrightnessSlider() {
    return Offstage(
        offstage: !changeBrightness,
        child: AnimatedOpacity(
            opacity: changeBrightness ? 1 : 0,
            duration: Duration(milliseconds: 300),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(UIData.spaceSizeWidth10),
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
            )));
  }

  Widget _buildPanContent() {
    return Positioned.fill(
        top: UIData.spaceSizeHeight40,
        bottom: UIData.spaceSizeHeight40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildBrightnessSlider(),
            _buildVolumeSlider(),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _playOrPause,
      onTap: _togglePlayControl,
      onPanDown: _handleOnPanDown,
      onPanUpdate: _handleOnPanUpdate,
      onPanEnd: _handleOnPanEnd,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: Hero(
          tag: "player",
          child: AspectRatio(
            aspectRatio: _videoPlayerController.value.isInitialized
                ? _videoPlayerController.value.aspectRatio
                : defaultAspectRatio,
            child: WillPopScope(
              child: Stack(
                children: [
                  widget.child,
                  _buildShowLoading(),
                  _buildShowPauseIcon(),
                  _buildShowTaggingContent(),
                  _buildShowSpeedContent(),
                  _buildPanContent(),
                ],
              ),
              onWillPop: _onWillPop,
            ),
          ),
        ),
      ),
    );
  }


}
