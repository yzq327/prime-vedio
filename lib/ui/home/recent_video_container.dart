import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/http/http_options.dart';
import 'package:primeVedio/http/http_util.dart';
import 'package:primeVedio/models/current_type_model.dart';
import 'package:primeVedio/models/video_list_model.dart';
import 'package:primeVedio/provider/change_notifier_provider.dart';
import 'package:primeVedio/utils/log_utils.dart';
import 'package:primeVedio/utils/ui_data.dart';

class RecentVideoContainer extends StatefulWidget{
  _RecentVideoContainerState createState()=> _RecentVideoContainerState();
}

class _RecentVideoContainerState extends State<RecentVideoContainer>{
  int currentTypeId = 1;
  List<VideoInfo> getVideoList =[];

  _getVideoTypeList() {
    Map<String, Object> params = new Map();
    params['ac'] = 'detail';
    params['t'] = currentTypeId;
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
    return ChangeNotifierProvider<CurrentTypeModel>(
      data: CurrentTypeModel(1),
      child: Builder(builder: (context) {
        var currentType = ChangeNotifierProvider.of<CurrentTypeModel>(context);
        print('currentType.currentTypeId: ${currentType.currentTypeId}');
        // if(currentType.currentTypeId != currentTypeId) {
        //   setState(() {
        //     currentTypeId = currentType.currentTypeId;
        //     _getVideoTypeList();
        //   });
        // }
        return Container(
          padding: EdgeInsets.symmetric(vertical: UIData.spaceSizeHeight8),
          color: UIData.themeBgColor,
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              CommonText.mainTitle('最新发布',color: UIData.hoverThemeBgColor),
              Container(
                width: UIData.spaceSizeWidth160,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    // Image.asset(getVideoList[0].vodPic),
                    Container(width: UIData.spaceSizeWidth160,)
                    // CommonText.normalTitle(getVideoList.length > 0 ?  getVideoList[0].vodName : '没有值', color: UIData.mainTextColor)
                  ],
                ),
              ),


            ],
          ),
        );
      }),
    );
  }
}
