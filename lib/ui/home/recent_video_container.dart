import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/http/http_options.dart';
import 'package:primeVedio/http/http_util.dart';
import 'package:primeVedio/models/video_list_model.dart';
import 'package:primeVedio/models/video_type_list_model.dart';
import 'package:primeVedio/utils/log_utils.dart';
import 'package:primeVedio/utils/ui_data.dart';

class RecentVideoContainer extends StatefulWidget{
  _RecentVideoContainerState createState()=> _RecentVideoContainerState();
}

class _RecentVideoContainerState extends State<RecentVideoContainer>{
  int currentTypeId = 1;
  List<VideoInfo> getVideoList =[];

  _getVideoTypeList() {
    HttpUtil.request(HttpOptions.baseUrl, HttpUtil.GET,).then((value) {
      VideoListModel model  =VideoListModel.fromJson(json.decode(value.data));
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: UIData.spaceSizeWidth16, vertical: UIData.spaceSizeHeight8),
      color: UIData.themeBgColor,
      alignment: Alignment.topLeft,
      child: null,
    );
  }
}
