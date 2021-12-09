import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/models/video_detail_list_model.dart';
import 'package:primeVedio/utils/font_icon.dart';
import 'package:primeVedio/utils/ui_data.dart';

class VideoInfoContent extends StatefulWidget {
  final VideoDetail? getVideoDetail;
  final ValueChanged<int> onChanged;
  final ValueChanged<bool> onCollected;
  final List? urlInfo;
  VideoInfoContent(
      {Key? key,
      this.getVideoDetail,
      required this.onChanged,
      required this.urlInfo,
      required this.onCollected})
      : super(key: key);

  _VideoInfoContentState createState() => _VideoInfoContentState();
}

class _VideoInfoContentState extends State<VideoInfoContent> {
  int currentIndex = 0;
  bool _reverse = false;
  bool isCollected = false;

  VideoDetail? get getVideoDetail {
    return widget.getVideoDetail;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildSelectVideo() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText.mainTitle('选集'),
            GestureDetector(
              child: Icon(IconFont.icon_daoxu, color: UIData.primaryColor),
              onTap: () {
                setState(() {
                  _reverse = !_reverse;
                });
              },
            ),
          ],
        ),
        SizedBox(height: UIData.spaceSizeHeight18),
        Container(
          height: UIData.spaceSizeHeight44,
          width: double.infinity,
          child: GridView.builder(
            reverse: _reverse,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 0.45,
              mainAxisSpacing: UIData.spaceSizeWidth8,
            ),
            itemCount: widget.urlInfo!.length,
            itemBuilder: (BuildContext context, int index) => GestureDetector(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: index == currentIndex
                      ? UIData.darkBlueColor
                      : UIData.darkWhiteColor,
                  borderRadius: BorderRadius.circular(UIData.spaceSizeWidth2),
                ),
                child: CommonText.text18(widget.urlInfo![index][0],
                    color: index == currentIndex
                        ? UIData.hoverThemeBgColor
                        : UIData.blackColor),
              ),
              onTap: () {
                setState(() {
                  currentIndex = index;
                  widget.onChanged(index);
                });
              },
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildAddCollection(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText.mainTitle(getVideoDetail!.vodName),
        GestureDetector(
            onTap: () {
              setState(() {
                isCollected = !isCollected;
                widget.onCollected(true);
              });
            },
            child: Icon(
              IconFont.icon_shoucangjia,
              size: UIData.spaceSizeWidth30,
              color: isCollected
                  ? UIData.collectedBgColor
                  : UIData.primaryColor,
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: UIData.spaceSizeWidth20),
      child: ListView(
        children: [
          _buildAddCollection(),
          SizedBox(height: UIData.spaceSizeHeight18),
          widget.urlInfo!.length > 0 ? _buildSelectVideo() : Container(),
          SizedBox(height: UIData.spaceSizeHeight18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText.mainTitle('介绍'),
              SizedBox(height: UIData.spaceSizeHeight12),
              CommonText.normalText('导演：${getVideoDetail!.vodDirector}'),
              CommonText.normalText('主演：${getVideoDetail!.vodActor}'),
              CommonText.normalText('年代：${getVideoDetail!.vodYear}'),
              CommonText.normalText('语言：${getVideoDetail!.vodLang}'),
              CommonText.normalText('介绍：${getVideoDetail!.vodContent}',
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.left),
            ],
          ),
        ],
      ),
    );
  }
}
