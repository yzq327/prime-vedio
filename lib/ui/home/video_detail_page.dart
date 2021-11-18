import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/http/http_options.dart';
import 'package:primeVedio/http/http_util.dart';
import 'package:primeVedio/models/video_list_model.dart';
import 'package:primeVedio/utils/log_utils.dart';
import 'package:primeVedio/utils/navigate.dart';

class VideoDetailPage extends StatefulWidget {
  final int vodId;
  final String vodName;

  VideoDetailPage({required this.vodId, this.vodName = ''});

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {

  late int videoId;
  late List getVideoDetail;

  _getVideoDetailList() {
    Map<String, Object> params = {
      'ac': 'detail',
      'ids': videoId,
    };

    HttpUtil.request(HttpOptions.baseUrl, HttpUtil.GET, params: params)
        .then((value) {
      VideoListModel model = VideoListModel.fromJson(value);
      if (model.list != null && model.list.length > 0) {
        setState(() {
          getVideoDetail = model.list;
        });
      } else {
        LogUtils.printLog('数据为空！');
      }
    });
  }

  @override
  void initState() {
    if(videoId != null) {
      // _getVideoDetailList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    VideoDetailPage videoDetailPage = NavigateOption.getParams(context);
    setState(() {
      videoId = videoDetailPage.vodId;
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:CommonText.mainTitle(videoDetailPage.vodName.toString()),
      ),
      body: Center(
        child: Column(
          children: [
            CommonText.darkGrey20Text(videoDetailPage.vodId.toString()),
          ],
        ),
      )
    );
  }
}

