import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/http/http_options.dart';
import 'package:primeVedio/http/http_util.dart';
import 'package:primeVedio/models/video_type_list_model.dart';
import 'package:primeVedio/provider/change_notifier_provider.dart';
import 'package:primeVedio/utils/log_utils.dart';
import 'package:primeVedio/utils/ui_data.dart';
import 'home_page.dart';

class TypeTabBar extends StatefulWidget{
  _MyTypeTabBar createState()=> _MyTypeTabBar();
}

class _MyTypeTabBar extends State<TypeTabBar>{
  final ScrollController _tabScrollController = new ScrollController(); //tab栏横向
  final double _tabHeight = ScreenUtil().setHeight(56);
  List<VideoType> getTypeList =[];

  _getVideoTypeList() {
    HttpUtil.request(HttpOptions.baseUrl, HttpUtil.GET).then((value) {
      VideoTypeListModel model  =VideoTypeListModel.fromJson(json.decode(value.data));
      if (model.typeList != null && model.typeList.length > 0) {
        setState(() {
          getTypeList = model.typeList;
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

  Widget _buildTabItem (VideoType item, CurrentTypeModel currentType) {
    return  GestureDetector(
      child: Container(
        width: UIData.spaceSizeWidth110,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: currentType.currentTypeId == item.typeId ? UIData.hoverThemeBgColor : UIData.themeBgColor ,
          borderRadius: BorderRadius.all(Radius.circular(UIData.fontSize50)),
        ),
        child: CommonText.mainTitle(item.typeName, color: currentType.currentTypeId ==item.typeId ? UIData.hoverTextColor : UIData.mainTextColor ),
      ),
      onTap: () {
        currentType.changeType(item.typeId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: UIData.spaceSizeWidth16, vertical: UIData.spaceSizeHeight8),
      color: UIData.themeBgColor,
      alignment: Alignment.topLeft,
      height: _tabHeight,
      child: ChangeNotifierProvider<CurrentTypeModel>(
        data: CurrentTypeModel(1),
        child: Builder(builder: (context) {
          var currentType = ChangeNotifierProvider.of<CurrentTypeModel>(context);
          return ListView(
           controller: _tabScrollController,
           shrinkWrap: true,
           scrollDirection: Axis.horizontal,
           children: getTypeList.map((item) => _buildTabItem(item, currentType)).toList(),
         );
        }),
      ),
    );
  }
}
