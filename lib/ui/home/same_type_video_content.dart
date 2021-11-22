import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/http/http_options.dart';
import 'package:primeVedio/http/http_util.dart';
import 'package:primeVedio/models/video_detail_list_model.dart';
import 'package:primeVedio/models/video_list_model.dart';
import 'package:primeVedio/utils/log_utils.dart';
import 'package:primeVedio/utils/ui_data.dart';

class SameTypeVideoContent extends StatefulWidget {
  final VideoDetail? getVideoDetail;
  SameTypeVideoContent(
      {Key? key,
        this.getVideoDetail})
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
          getVideoList = getVideoList..addAll(model.list);
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
    return Row(
      children: [
        Container(),
        CommonText.mainTitle('index: $index')
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: UIData.spaceSizeWidth20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:getVideoList.asMap().keys.map((index) => _buildRecommendVideo(index)).toList(),
          ),
        ),
      ],
    );
  }
}
