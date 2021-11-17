import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/http/http_options.dart';
import 'package:primeVedio/http/http_util.dart';
import 'package:primeVedio/models/video_list_model.dart';
import 'package:primeVedio/utils/log_utils.dart';
import 'package:primeVedio/utils/ui_data.dart';

class RecentVideoContainer extends StatefulWidget{
  final int typeId;
  RecentVideoContainer({Key key, this.typeId}) : super(key: key);
  _RecentVideoContainerState createState()=> _RecentVideoContainerState();
}

class _RecentVideoContainerState extends State<RecentVideoContainer>{
  List<VideoInfo> getVideoList =[];

  _getVideoTypeList() {
    Map<String, Object> params = new Map();
    params['ac'] = 'detail';
    params['t'] = widget.typeId + 1;
    params['pg'] = 1;

    HttpUtil.request(HttpOptions.baseUrl, HttpUtil.GET,params: params).then((value) {
      VideoListModel model = VideoListModel.fromJson(value);
      if (model.list != null && model.list.length > 0) {
        LogUtils.printLog('数据: ${model.list[0].vodName}');
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
    return Builder(builder: (context) {
      return Container(
        width: UIData.spaceSizeWidth400,
        margin: EdgeInsets.symmetric(horizontal: UIData.spaceSizeWidth16),
        padding: EdgeInsets.symmetric(vertical: UIData.spaceSizeHeight8, horizontal: UIData.spaceSizeHeight16),
        decoration: BoxDecoration(

        ),
        child: Column(
          children: [
            Container(child: CommonText.mainTitle('最新发布',color: UIData.hoverThemeBgColor, textAlign: TextAlign.left)),
            Container(
              width: UIData.spaceSizeWidth160,
              alignment: Alignment.center,
              child: Column(
                children: [
                  CommonText.normalText(getVideoList.length > 0 ?  getVideoList[0].vodName : '没有值', color: UIData.mainTextColor),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
