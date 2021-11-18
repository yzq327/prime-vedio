import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/commom/common_hint_text_contain.dart';
import 'package:primeVedio/commom/common_img_display.dart';
import 'package:primeVedio/http/http_options.dart';
import 'package:primeVedio/http/http_util.dart';
import 'package:primeVedio/models/video_detail_list_model.dart';
import 'package:primeVedio/utils/log_utils.dart';
import 'package:primeVedio/utils/ui_data.dart';

class VideoDetailPageParams {
  final int vodId;
  final String vodName;

  VideoDetailPageParams({ required this.vodId, this.vodName = ''});
}

class VideoDetailPage extends StatefulWidget {
  final VideoDetailPageParams videoDetailPageParams;
  VideoDetailPage({Key? key, required this.videoDetailPageParams})
      : super(key: key);
  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  VideoDetail? getVideoDetail;

  _getVideoDetailList() {
    Map<String, Object> params = {
      'ac': 'detail',
      'ids': widget.videoDetailPageParams.vodId,
    };
    HttpUtil.request(HttpOptions.baseUrl, HttpUtil.GET, params: params)
        .then((value) {
      VideoDetailListModel model = VideoDetailListModel.fromJson(value);
      if (model.list.length > 0) {
        setState(() {
          getVideoDetail = model.list[0];
        });
      } else {
        LogUtils.printLog('数据为空！');
      }
    });
  }

  @override
  void initState() {
    print(
        'widget.videoDetailPageParams.vodId${widget.videoDetailPageParams.vodName}');
    _getVideoDetailList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: UIData.themeBgColor,
        appBar: AppBar(
          elevation: 0,
          title: CommonText.mainTitle(widget.videoDetailPageParams.vodName),
        ),
        body: getVideoDetail == null
            ? CommonHintTextContain(text: '数据加载中...')
            : ListView(
                // padding:
                //     EdgeInsets.symmetric(horizontal: UIData.spaceSizeWidth16),
                children: [
                  Column(
                    children: [
                      Container(
                          height: UIData.spaceSizeHeight228,
                          width: UIData.spaceSizeWidth350,
                          child:  Container(
                            child: Image(
                                image: CachedNetworkImageProvider(getVideoDetail!.vodPic),
                                alignment: Alignment.topCenter,
                                fit: BoxFit.cover),
                          ),
                        ),
                      Container(
                        height: 600,
                        child:
                            CommonText.darkGrey20Text(getVideoDetail!.vodName),
                      ),
                      Container(
                        height: 600,
                        child:
                            CommonText.darkGrey20Text(getVideoDetail!.vodName),
                      ),
                    ],
                  )
                ],
              ));
  }
}
