import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/commom/common_basic_slider.dart';
import 'package:primeVedio/commom/common_page_header.dart';
import 'package:primeVedio/utils/font_icon.dart';
import 'package:primeVedio/utils/ui_data.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewActivities extends StatefulWidget {
  @override
  NewActivitiesState createState() => NewActivitiesState();
}

class NewActivitiesState extends State<NewActivities> {
  bool showOperations = false;
  String webUrl = 'https://www.baidu.com/';
  bool isWebLoading = false;
  double sliderValue = 0.0;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  Widget _buildPageHeader() {
    return CommonPageHeader(
      pageTitle: isWebLoading ? '加载中...' : '百度一下，你就知道',
      rightIcon: IconFont.icon_gengduo,
      onRightTop: () => setState(() {
        showOperations = !showOperations;
      }),
    );
  }

  Widget _buildOperateInfo(
      GestureTapCallback onTap, IconData icon, String iconName) {
    return SizedBox(
      width: UIData.spaceSizeWidth64,
      child: Column(
        children: [
          GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.all(UIData.spaceSizeWidth12),
                decoration: BoxDecoration(
                  color: UIData.blackColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(UIData.spaceSizeWidth4),
                      topRight: Radius.circular(UIData.spaceSizeWidth4)),
                ),
                child: Icon(
                  icon,
                  color: UIData.primaryColor,
                  size: UIData.spaceSizeWidth40,
                ),
              )),
          SizedBox(height: UIData.spaceSizeHeight6),
          CommonText.text12(iconName,
              color: UIData.webTextColor, overflow: TextOverflow.visible),
        ],
      ),
    );
  }

  Widget _buildPageOperation() {
    return Positioned(
        top: MediaQuery.of(context).size.height * 0.6,
        left: 0,
        right: 0,
        bottom: 0,
        child: Offstage(
          offstage: !showOperations,
          child: Container(
            padding: EdgeInsets.all(UIData.spaceSizeWidth16),
            decoration: BoxDecoration(
              color: UIData.sheetContentBgColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(UIData.spaceSizeWidth20),
                  topRight: Radius.circular(UIData.spaceSizeWidth20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () => setState(() {
                          showOperations = false;
                        }),
                    child: Icon(
                      IconFont.icon_guanbi,
                      color: UIData.primaryColor,
                      size: UIData.spaceSizeWidth20,
                    )),
                SizedBox(height: UIData.spaceSizeHeight8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonText.text14('该网页由 $webUrl 提供',
                        color: UIData.webTextColor),
                  ],
                ),
                SizedBox(height: UIData.spaceSizeHeight24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOperateInfo(() {}, IconFont.icon_icon_refresh, '刷新'),
                    _buildOperateInfo(
                        () {}, IconFont.icon_lianjiewangzhiwangzhan, '复制链接'),
                    _buildOperateInfo(() {}, IconFont.icon_browser, '在默认浏览器打开'),
                    _buildOperateInfo(
                        () {}, IconFont.icon_fenxiangfangshi, '分享'),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildPageContent() {
    return Expanded(
      child: Stack(
        children: [
          WebView(
            initialUrl: webUrl,
            //JS执行模式 是否允许JS执行
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (webUrl) => setState(() {
              isWebLoading = true;
            }),
            onPageFinished: (webUrl) => setState(() {
              isWebLoading = false;
            }),
            onProgress: (onProgressParam) => setState(() {
              sliderValue = onProgressParam / 100;
            }),
          ),
          _buildPageOperation(),
        ],
      ),
    );
  }

  Widget _buildSlider() {
    return Container(
      height: UIData.spaceSizeHeight1,
      width: double.infinity,
      color: UIData.themeBgColor,
      child: isWebLoading ? CommonBasicSlider(
        currentValue: sliderValue,
        activeColor: UIData.webSliderColor,
        inactiveColor: UIData.themeBgColor,
        quarterTurns: 4,
        enabledThumbRadius: 1,
        overlayRadius: 1,
        trackHeight: 1,
        onChange: (double value) {},
      ) : SizedBox(),
      // SizedBox())
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
          _buildSlider(),
          _buildPageContent(),
        ],
      ),
    );
  }
}
