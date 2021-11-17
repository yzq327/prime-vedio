import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/http/http_options.dart';
import 'package:primeVedio/http/http_util.dart';
import 'package:primeVedio/models/video_list_model.dart';
import 'package:primeVedio/utils/log_utils.dart';
import 'package:primeVedio/utils/ui_data.dart';

class RecentVideoContainer extends StatefulWidget {
  final int typeId;
  RecentVideoContainer({Key key, this.typeId}) : super(key: key);
  _RecentVideoContainerState createState() => _RecentVideoContainerState();
}

class _RecentVideoContainerState extends State<RecentVideoContainer> {
  List<VideoInfo> getVideoList = [];

  _getVideoTypeList() {
    Map<String, Object> params = new Map();
    params['ac'] = 'detail';
    params['t'] = widget.typeId + 1;
    params['pg'] = 1;

    HttpUtil.request(HttpOptions.baseUrl, HttpUtil.GET, params: params)
        .then((value) {
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

  Widget _buildVideoInfo(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        Container(
          width: UIData.spaceSizeWidth160,
          height: UIData.spaceSizeHeight200,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: CachedNetworkImageProvider(
                    getVideoList[index].vodPic),
                alignment: Alignment.topCenter,
                fit: BoxFit.cover),
            borderRadius: BorderRadius.all(
                Radius.circular(UIData.fontSize12)),
          ),
          child: SizedBox(),
        ),
        Container(
            width: UIData.spaceSizeWidth160,
            alignment: Alignment.topLeft,
            margin: EdgeInsets.symmetric(
                vertical: UIData.spaceSizeHeight8),
            child: CommonText.normalText(
                getVideoList.length > 0
                    ? getVideoList[index].vodName
                    : '没有值',
                color: UIData.mainTextColor)),
      ] ,
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
            Container(margin: EdgeInsets.symmetric(vertical: UIData.spaceSizeHeight16),child:  CommonText.mainTitle('最新发布', color: UIData.hoverThemeBgColor),),
            Wrap(
            spacing: UIData.spaceSizeWidth20,
            runSpacing: UIData.spaceSizeHeight16,
            alignment: WrapAlignment.center, //沿主轴方向居中
            children: getVideoList.length > 0 ?getVideoList.asMap().keys.map((index) => _buildVideoInfo(index)).toList() : [Center(
              child: CommonText.mainTitle('暂无数控', color: UIData.hoverThemeBgColor),
            )],
          ),
            Container(color:UIData.themeBgColor,
                width: UIData.spaceSizeWidth400,child: CommonText.mainTitle('没有更多啦', color: UIData.hoverThemeBgColor))
          ]
        ),
      );
    });
  }
}
