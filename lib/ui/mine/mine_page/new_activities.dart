import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primeVedio/commom/common_page_header.dart';
import 'package:primeVedio/utils/font_icon.dart';
import 'package:primeVedio/utils/ui_data.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewActivities extends StatefulWidget {
  @override
  NewActivitiesState createState() => NewActivitiesState();
}

class NewActivitiesState extends State<NewActivities> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  Widget _buildPageHeader() {
    return CommonPageHeader(
      pageTitle: '百度一下，你就知道',
      rightIcon: IconFont.icon_gengduo,
      onRightTop: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(375, 812),
        orientation: Orientation.portrait);
    return Scaffold(
      backgroundColor: UIData.themeBgColor,
      appBar: null,
      body: Column(
        children: [
          _buildPageHeader(),
          Expanded(
            child: WebView(
              initialUrl: 'https://www.baidu.com/',
              //JS执行模式 是否允许JS执行
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ],
      ),
    );
  }
}
