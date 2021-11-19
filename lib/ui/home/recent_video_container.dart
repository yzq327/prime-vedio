import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/commom/common_img_display.dart';
import 'package:primeVedio/models/video_list_model.dart';
import 'package:primeVedio/utils/ui_data.dart';

class RecentVideoContainer extends StatefulWidget {
  final List<VideoInfo> videoList;
  RecentVideoContainer({Key ?key, required this.videoList}) : super(key: key);
  _RecentVideoContainerState createState() => _RecentVideoContainerState();
}

class _RecentVideoContainerState extends State<RecentVideoContainer> {

  List<VideoInfo> get getVideoList => widget.videoList;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildVideoInfo(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: UIData.spaceSizeWidth160,
          height: UIData.spaceSizeHeight200,
          child: CommonImgDisplay(vodPic: getVideoList[index].vodPic, vodId: getVideoList[index].vodId, vodName: getVideoList[index].vodName),
        ),
        Container(
            width: UIData.spaceSizeWidth160,
            alignment: Alignment.topLeft,
            margin: EdgeInsets.symmetric(vertical: UIData.spaceSizeHeight8),
            child: CommonText.normalText(
                getVideoList.length > 0 ? getVideoList[index].vodName : '没有值',
                color: UIData.mainTextColor)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        width: UIData.spaceSizeWidth400,
        color: UIData.themeBgColor,
        padding: EdgeInsets.symmetric(
            vertical: UIData.spaceSizeHeight8,
            horizontal: UIData.spaceSizeHeight16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: UIData.spaceSizeHeight16),
                      child: CommonText.mainTitle('最新发布',
                          color: UIData.hoverThemeBgColor),
                    ),
                    GridView.builder(
                     physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.66,
                        mainAxisSpacing: UIData.spaceSizeHeight8,
                        crossAxisSpacing: UIData.spaceSizeWidth16,
                      ),
                      itemCount: getVideoList.length,
                      itemBuilder: (BuildContext context, int index) => _buildVideoInfo(index),
                    ),
                  ]
                ),
      );
    });
  }
}
