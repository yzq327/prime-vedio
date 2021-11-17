import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/models/video_list_model.dart';
import 'package:primeVedio/utils/ui_data.dart';

class VideoSwiper extends StatefulWidget{
  final List<VideoInfo> videoList;
  VideoSwiper({Key key, this.videoList}) : super(key: key);

  _VideoSwiperState createState()=> _VideoSwiperState();
}

class _VideoSwiperState extends State<VideoSwiper>{

  PageController _pageController;

  List<VideoInfo> get getImgList => widget.videoList;

  int currentIndex = 0;

  Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: currentIndex,
    );
    if(getImgList.length > 1) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        startTimer();
      });
    }
  }

  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = new Timer.periodic(Duration(seconds: 3), (_) {
      currentIndex ++;
      _pageController.animateToPage(currentIndex,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }


  _buildPageViewItemWidget(int index) {
    return  Container(
      margin: EdgeInsets.only(right: UIData.spaceSizeWidth16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(UIData.spaceSizeWidth12),
        child: Image(
            image: CachedNetworkImageProvider(getImgList[index].vodPic),
            alignment: Alignment.topCenter,
            fit: BoxFit.cover),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: UIData.spaceSizeWidth320/UIData.spaceSizeHeight172,
      child: Container(
        padding: EdgeInsets.fromLTRB(UIData.spaceSizeWidth16,UIData.spaceSizeHeight16,0,0),
        decoration: BoxDecoration(
          color: UIData.themeBgColor,
          ),
        child:  NotificationListener(
            onNotification: (ScrollNotification notification) {
              if (notification.depth == 0 &&
                  notification is ScrollStartNotification) {
                if (notification.dragDetails != null) {
                  _timer.cancel();
                }
              } else if (notification is ScrollEndNotification) {
                _timer.cancel();
                startTimer();
              }
              return true;
            },
          child: PageView.builder(
            itemBuilder: (BuildContext context, int index) => _buildPageViewItemWidget(index),
            controller: _pageController,
            itemCount: getImgList.length,
            pageSnapping: false,
            onPageChanged: (int index) {
              int newIndex;
              if (index == getImgList.length -1) {
                newIndex = 0;
                _pageController.jumpToPage(newIndex);
              } else {
                newIndex = index;
              }
              setState(() {
                currentIndex = newIndex;
              });
            },
          ),
        ),
      ),
    );
  }
}
