import 'package:flutter/material.dart';
import 'package:primeVedio/commom/videoPlayer/video_player_controller.dart';
import 'package:video_player/video_player.dart';


class ControllerWidget extends InheritedWidget {
  final GlobalKey<VideoPlayerControlState> controlKey;
  final VideoPlayerController controller;
  final bool videoInit;
  final String title;
  final String vodPic;
  final Widget child;


  ControllerWidget({
    Key? key,
    required this.controlKey,
    required this.controller,
    required this.videoInit,
    required this.title,
    required this.vodPic,
    required this.child,
  }) : super(key: key, child: child);



  //定义一个便捷方法，方便子树中的widget获取共享数据
  static ControllerWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ControllerWidget>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return false;
  }

}