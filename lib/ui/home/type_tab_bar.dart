import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/http/http_options.dart';
import 'package:primeVedio/http/http_util.dart';
import 'package:primeVedio/models/video_type_list_model.dart';
import 'package:primeVedio/utils/log_utils.dart';
import 'package:primeVedio/utils/ui_data.dart';

class _TypeItem {
  int typeId;
  String typeName;
  _TypeItem(this.typeId, this.typeName);
}

class TypeTabBar extends StatefulWidget{
  _MyTypeTabBar createState()=> _MyTypeTabBar();
}

class _MyTypeTabBar extends State<TypeTabBar>{
  final ScrollController _tabScrollController = new ScrollController(); //tab栏横向
  final double _tabHeight = ScreenUtil().setHeight(56);
  int currentTypeId = 1;
  List<VideoType> getTypeList =[];

  _getVideoTypeList() {
    String url = HttpOptions.urlVideoTypeList;
    HttpUtil.get(
        url,
            (data) {
          _messageListCallBack(data);
        },
    );
  }

  void _messageListCallBack(data) {
    LogUtils.printLog('data*********:' + data.code);
    VideoTypeListModel model = VideoTypeListModel.fromJson(data);
    LogUtils.printLog('消息列表:${json.encode(data)}');
    if (model.typeList != null && model.typeList.length > 0) {
      LogUtils.printLog('getTypeList***********:${model.typeList}');
      setState(() {
        getTypeList = model.typeList;
      });
    } else {
      LogUtils.printLog('数据为空！！！！');
    }
  }

  @override
  void initState() {
    print("88888");
    HttpUtil.get(
      HttpOptions.urlVideoTypeList,
          (data) {
        _messageListCallBack(data);
      },
    );
    super.initState();
  }

  //
  //
  // List<_TypeItem> get getTypeList {
  //   return [
  //   _TypeItem(1,'电视'),
  //   _TypeItem(2,'连续剧'),
  //   _TypeItem(3,'综艺'),
  //   _TypeItem(4,'动漫'),
  //   _TypeItem(5,'资讯'),
  //   _TypeItem(6,'动作片'),
  //   _TypeItem(7,'喜剧片'),
  //   _TypeItem(8,'爱情片'),
  //   _TypeItem(9,'科幻片'),
  //   ];
  // }

  Widget _buildTabItem (VideoType item) {
    return  GestureDetector(
      child: Container(
        width: UIData.spaceSizeWidth110,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: currentTypeId ==item.typeId ? UIData.hoverThemeBgColor : UIData.themeBgColor ,
          borderRadius: BorderRadius.all(Radius.circular(UIData.fontSize50)),
        ),
        child: CommonText.mainTitle(item.typeName, color: currentTypeId ==item.typeId ? UIData.hoverTextColor : UIData.mainTextColor ),
      ),
      onTap: () {
        setState(() {
          currentTypeId = item.typeId;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // _getVideoTypeList();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: UIData.spaceSizeWidth16, vertical: UIData.spaceSizeHeight8),
      color: UIData.themeBgColor,
      alignment: Alignment.topLeft,
      height: _tabHeight,
      child: ListView(
        controller: _tabScrollController,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: getTypeList.map((item) => _buildTabItem(item)).toList(),
      ),
    );
  }
}
