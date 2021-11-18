import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/commom/common_hint_text_contain.dart';
import 'package:primeVedio/http/http_options.dart';
import 'package:primeVedio/http/http_util.dart';
import 'package:primeVedio/models/video_list_model.dart';
import 'package:primeVedio/ui/home/recent_video_container.dart';
import 'package:primeVedio/ui/home/video_swiper.dart';
import 'package:primeVedio/utils/log_utils.dart';

class TabContent extends StatefulWidget{
  final int typeId;
  TabContent({ Key? key, required this.typeId}) : super(key: key);

  _TabContentState createState()=> _TabContentState();
}

class _TabContentState extends State<TabContent>{
  List<VideoInfo> getVideoList = [];

  _getVideoTypeList() {
    Map<String, Object> params = {
      'ac': 'detail',
      't': widget.typeId,
      'pg': 1,
    };

    HttpUtil.request(HttpOptions.baseUrl, HttpUtil.GET, params: params)
        .then((value) {
      VideoListModel model = VideoListModel.fromJson(value);
      if (model.list != null && model.list.length > 0) {
        setState(() {
          getVideoList = model.list;
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
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: getVideoList.length > 0 ?[
            VideoSwiper(videoList: getVideoList),
            RecentVideoContainer(videoList: getVideoList)
          ]: [CommonHintTextContain(),],
        ),
      ],
    );
  }
}
