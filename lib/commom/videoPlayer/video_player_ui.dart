import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:primeVedio/commom/videoPlayer/video_player_controller.dart';
import 'package:primeVedio/utils/ui_data.dart';
import 'package:video_player/video_player.dart';
import 'controller_widget.dart';

enum VideoPlayerType { network, asset, file }

class VideoPlayerUI extends StatefulWidget {
  final String url;
  late final String? vodName;
  late final String? vodPic;
  late final double? width;
  late final double? height;

  VideoPlayerUI(
      {Key? key,
      required this.url,
      this.vodName,
      this.vodPic,
        this.width = double.infinity,
        this.height = double.infinity,
      })
      : super(key: key);

  @override
  _VideoPlayerUIState createState() => _VideoPlayerUIState();
}

class _VideoPlayerUIState extends State<VideoPlayerUI> {
  final GlobalKey<VideoPlayerControlState> _key =
      GlobalKey<VideoPlayerControlState>();

  ///指示video资源是否加载完成，加载完成后会获得总时长和视频长宽比等信息
  bool _videoInit = false;
  bool _videoError = false;

  VideoPlayerController? _controller; // video控件管理器

  /// 记录是否全屏
  bool get _isFullScreen =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  Size get _window => MediaQueryData.fromWindow(window).size;

  @override
  void initState() {
    super.initState();
    _urlChange(); // 初始进行一次url加载
  }

  @override
  void didUpdateWidget(VideoPlayerUI oldWidget) {
    if (oldWidget.url != widget.url) {
      _urlChange(); // url变化时重新执行一次url加载
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() async {
    super.dispose();
    if (_controller != null) {
      _controller!.removeListener(_videoListener);
      _controller!.dispose();
    }
  }


  @override
  Widget build(BuildContext context) {
    //SafeArea通过MediaQuery来检测屏幕尺寸，使应用程序的大小能与屏幕适配。
    return SafeArea(
      top: !_isFullScreen,
      bottom: !_isFullScreen,
      left: !_isFullScreen,
      right: !_isFullScreen,
      child:
      Container(
        width: _isFullScreen ? _window.width : widget.width,
        height: _isFullScreen ? _window.height : widget.height,
        child: _isHadUrl(),
      ),
    );
  }

// 判断是否有url
  Widget _isHadUrl() {
    return ControllerWidget(
      controlKey: _key,
      controller: _controller!,
      videoInit: _videoInit,
      title: widget.vodName!,
      vodPic: widget.vodPic!,
      child: VideoPlayerControl(
        key: _key,
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: _isVideoInit(),
        ),
      ),
    );
  }

// 加载url成功时，根据视频比例渲染播放器
  Widget _isVideoInit() {
    if (_videoInit) {
      return AspectRatio(
        aspectRatio: _controller!.value.aspectRatio,
        child: VideoPlayer(_controller!),
      );
    } else if (_controller != null && _videoError) {
      return Text(
        '加载出错',
        style: TextStyle(color: Colors.white),
      );
    } else {
      return SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    }
  }

  void _urlChange() async {
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    setState(() {
      /// 重置组件参数
      _videoInit = false;
      _videoError = false;
    });
    _controller = VideoPlayerController.network(widget.url);

    /// 加载资源完成时，监听播放进度，并且标记_videoInit=true加载完成
    _controller!.addListener(_videoListener);
    await _controller!.initialize();
    setState(() {
      _videoInit = true;
      _videoError = false;
      _controller!.play();
    });
  }

  void _videoListener() async {
    if (_controller!.value.hasError) {
      setState(() {
        _videoError = true;
      });
    } else {
      Duration? res = await _controller!.position;
      if (res! >= _controller!.value.duration) {
        await _controller!.seekTo(Duration(seconds: 0));
        await _controller!.pause();
      }
      if (_controller!.value.isPlaying && _key.currentState != null) {
        /// 减少build次数
        _key.currentState!.setPosition(
          position: res,
          totalDuration: _controller!.value.duration,
        );
      }
    }
  }
}
