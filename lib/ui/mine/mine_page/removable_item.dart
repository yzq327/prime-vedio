import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/commom/common_img_display.dart';
import 'package:primeVedio/models/common/common_model.dart';
import 'package:primeVedio/ui/home/video_detail_page.dart';
import 'package:primeVedio/utils/commom_srting_helper.dart';
import 'package:primeVedio/utils/font_icon.dart';
import 'package:primeVedio/utils/routes.dart';
import 'package:primeVedio/utils/ui_data.dart';

class RemovableItem extends StatefulWidget {
  final List<VideoHistoryItem> videoHistoryList;
  final Key? moveItemKey;
  final VoidCallback onActionDown;
  final ValueChanged<int> onDeleteItem;
  final int index;
  RemovableItem({
    Key? key,
    required this.videoHistoryList,
    required this.index,
    this.moveItemKey,
    required this.onActionDown,
    required this.onDeleteItem,
  }) : super(key: moveItemKey);

  @override
  RemovableItemState createState() => RemovableItemState();
}

class RemovableItemState extends State<RemovableItem>
    with SingleTickerProviderStateMixin {

  late AnimationController slideController;
  double offset = 0.0;
  double maxDis = UIData.spaceSizeWidth120;
  bool opened = false;
  double moveDis = 0.0;

  List<VideoHistoryItem> get videoHistoryList => widget.videoHistoryList;
  get index => widget.index;

  @override
  void initState() {
    slideController = AnimationController(
        lowerBound: 0,
        upperBound: maxDis,
        duration: const Duration(seconds: 1),
        vsync: this)
      ..addListener(() {
        offset = slideController.value;
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    if (slideController != null) {
      slideController.dispose();
    }
    super.dispose();
  }

  void closeItems() {
    slideController.animateTo(0.0);
    opened = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.detail,
            arguments: VideoDetailPageParams(
                vodId: videoHistoryList[index].vodId,
                vodName: videoHistoryList[index].vodName,
                vodPic: videoHistoryList[index].vodPic,
                watchedDuration: videoHistoryList[index].watchedDuration));
      },
      onHorizontalDragDown: (DragDownDetails dragDownDetails) {
        closeItems();
        return widget.onActionDown();
      },
      onHorizontalDragUpdate: (DragUpdateDetails dragUpdateDetails) {
        setState(() {
          offset -= dragUpdateDetails.delta.dx;
          if (offset < 0) {
            offset = 0;
          }
          if (offset >= maxDis) {
            offset = maxDis;
          }
        });
      },
      onHorizontalDragEnd: (DragEndDetails dragEndDetails) {
        slideController.value = offset;
        if (offset >= maxDis) {
          opened = true;
        } else if (offset > maxDis / 2) {
          //滑动到最大距离一半时，执行动画，至打开item
          opened = true;
          slideController.animateTo(maxDis);
        } else {
          closeItems();
        }
      },
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                widget.onDeleteItem(videoHistoryList[index].vodId);
              },
              child: Container(
                alignment: Alignment.center,
                width: UIData.spaceSizeWidth110,
                height: UIData.spaceSizeWidth90,
                margin: EdgeInsets.only(
                  top: UIData.spaceSizeWidth20,
                  bottom: UIData.spaceSizeHeight16,
                  right: UIData.spaceSizeWidth20,
                ),
                color: Colors.red,
                child: Icon(
                  IconFont.icon_shanchutianchong,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: UIData.spaceSizeHeight16,
            left: -offset,
            right: offset,
            child: Container(
              color: UIData.themeBgColor,
              width: double.infinity,
              margin: EdgeInsets.only(
                left: UIData.spaceSizeWidth20,
                bottom: UIData.spaceSizeHeight16,
              ),
              padding: EdgeInsets.only(
                right: UIData.spaceSizeHeight16,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: UIData.spaceSizeHeight104,
                      width: UIData.spaceSizeWidth160,
                      child: CommonImgDisplay(
                        vodPic: videoHistoryList[index].vodPic,
                        vodId: videoHistoryList[index].vodId,
                        vodName: videoHistoryList[index].vodName,
                      )),
                  SizedBox(width: UIData.spaceSizeWidth18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText.text18(videoHistoryList[index].vodName),
                        SizedBox(
                          height: UIData.spaceSizeHeight8,
                        ),
                        CommonText.text18(videoHistoryList[index].vodEpo,
                            color: UIData.subTextColor),
                        SizedBox(
                          height: UIData.spaceSizeHeight8,
                        ),
                        CommonText.text14(
                            "${StringsHelper.formatDuration(Duration(milliseconds: videoHistoryList[index].watchedDuration))} / ${videoHistoryList[index].totalDuration} ",
                            color: UIData.hoverThemeBgColor),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
