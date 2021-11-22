import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/commom/common_hint_text_contain.dart';
import 'package:primeVedio/commom/common_img_display.dart';
import 'package:primeVedio/http/http_options.dart';
import 'package:primeVedio/http/http_util.dart';
import 'package:primeVedio/models/video_detail_list_model.dart';
import 'package:primeVedio/models/video_list_model.dart';
import 'package:primeVedio/ui/home/video_detail_page.dart';
import 'package:primeVedio/utils/routes.dart';
import 'package:primeVedio/utils/log_utils.dart';
import 'package:primeVedio/utils/ui_data.dart';

class SameTypeVideoContent extends StatefulWidget {
  final VideoDetail? getVideoDetail;
  SameTypeVideoContent({Key? key, required this.getVideoDetail})
      : super(key: key);

  _SameTypeVideoContentState createState() => _SameTypeVideoContentState();
}

class _SameTypeVideoContentState extends State<SameTypeVideoContent> {
  List<VideoInfo> getVideoList = [];

  _getVideoTypeList() async {
    Map<String, Object> params = {
      'ac': 'detail',
      't': widget.getVideoDetail!.typeId,
      'pg': 1,
    };
    HttpUtil.request(HttpOptions.baseUrl, HttpUtil.GET, params: params)
        .then((value) {
      VideoListModel model = VideoListModel.fromJson(value);
      if (model.list.length > 0) {
        setState(() {
          getVideoList = model.list
              .where((element) => element.vodId != widget.getVideoDetail!.vodId)
              .toList();
        });
      } else {
        LogUtils.printLog('数据为空！');
      }
    });
  }

  @override
  void initState() {
    _getVideoTypeList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildRecommendVideo(int index) {
    return Container(
      margin: EdgeInsets.only(bottom: UIData.spaceSizeHeight8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: UIData.spaceSizeHeight100,
              width: UIData.spaceSizeWidth160,
              child: CommonImgDisplay(
                vodPic: getVideoList[index].vodPic,
                vodId: getVideoList[index].vodId,
                vodName: getVideoList[index].vodName,
              )),
          SizedBox(width: UIData.spaceSizeWidth18),
          GestureDetector(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.text18(getVideoList[index].vodName),
                SizedBox(
                  height: UIData.spaceSizeHeight8,
                ),
                CommonText.text18("评分：${getVideoList[index].vodScore}",
                    color: UIData.subTextColor),
                SizedBox(
                  height: UIData.spaceSizeHeight8,
                ),
                CommonText.text14("上线年份： ${getVideoList[index].vodYear}",
                    color: UIData.hoverThemeBgColor),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, Routes.detail,
                  arguments: VideoDetailPageParams(
                      vodId: getVideoList[index].vodId,
                      vodName: getVideoList[index].vodName));
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getVideoList.length > 0
        ? ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: UIData.spaceSizeWidth20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: getVideoList
                      .asMap()
                      .keys
                      .map((index) => _buildRecommendVideo(index))
                      .toList(),
                ),
              ),
            ],
          )
        : CommonHintTextContain(text: '暂无同类型影片，看看其他的吧');
  }
}
