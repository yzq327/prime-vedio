import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/commom/common_img_display.dart';
import 'package:primeVedio/models/video_list_model.dart';
import 'package:primeVedio/utils/ui_data.dart';

class VideoSwiper extends StatefulWidget{
  final List<VideoInfo> videoList;
  VideoSwiper({Key ? key, required this.videoList}) : super(key: key);

  _VideoSwiperState createState()=> _VideoSwiperState();
}

class _VideoSwiperState extends State<VideoSwiper>{

  late PageController _pageController;

  List<VideoInfo> get getImgList => widget.videoList;

  int currentIndex = 0;

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: currentIndex,
    );
    if(getImgList.length > 1) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        startTimer();
      });
    }
  }

  void dispose() {
    super.dispose();
    if(getImgList.length > 1) {
      _timer.cancel();
    }
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
      child: CommonImgDisplay(vodPic: getImgList[index].vodPic, vodId: getImgList[index].vodId, vodName: getImgList[index].vodName,),
    );
  }


  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: UIData.spaceSizeWidth320/UIData.spaceSizeHeight172,
      child: Container(
        padding: EdgeInsets.fromLTRB(UIData.spaceSizeWidth16,0,0,0),
        decoration: BoxDecoration(
          color: UIData.themeBgColor,
          ),
        child:  NotificationListener(
          //当用户用手滑动轮播的时候取消定时器，然后在轮播滑动结束后重设定时器
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
