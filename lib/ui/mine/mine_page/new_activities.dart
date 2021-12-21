import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/commom/common_basic_slider.dart';
import 'package:primeVedio/commom/common_page_header.dart';
import 'package:primeVedio/commom/common_toast.dart';
import 'package:primeVedio/utils/constants.dart';
import 'package:primeVedio/utils/font_icon.dart';
import 'package:primeVedio/utils/ui_data.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewActivities extends StatefulWidget {
  @override
  NewActivitiesState createState() => NewActivitiesState();
}

class NewActivitiesState extends State<NewActivities> {
  String webUrl = 'https://www.baidu.com/';
  String webTitle = '';
  bool isWebLoading = false;
  double sliderValue = 0.0;
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  Widget _buildPageHeader() {
    return CommonPageHeader(
      pageTitle: isWebLoading ? '加载中...' : webTitle,
      rightIcon: IconFont.icon_gengduo,
      onRightTop: () => showButtonSheet(),
    );
  }

  Widget _buildOperateInfo(
      GestureTapCallback onTap, IconData icon, String iconName) {
    return SizedBox(
      width: UIData.spaceSizeWidth64,
      child: Column(
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
                onTap();
              },
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

  void showButtonSheet() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            height: UIData.spaceSizeHeight240,
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
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      IconFont.icon_guanbi,
                      color: UIData.primaryColor,
                      size: UIData.spaceSizeWidth20,
                    )),
                SizedBox(height: UIData.spaceSizeHeight8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonText.text14('该网页由 ${Uri.parse(webUrl).host} 提供',
                        color: UIData.webTextColor),
                  ],
                ),
                SizedBox(height: UIData.spaceSizeHeight24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOperateInfo(() {
                      _webViewController.reload();
                    }, IconFont.icon_icon_refresh, '刷新'),
                    _buildOperateInfo(() {
                      Clipboard.setData(ClipboardData(text: webUrl));
                      CommonToast.show(
                        context: context,
                        message: "复制成功",
                      );
                    }, IconFont.icon_lianjiewangzhiwangzhan, '复制链接'),
                    _buildOperateInfo(() async {
                      if (!await launch(webUrl)) {
                        CommonToast.show(
                            context: context,
                            message: "无法打开该网址",
                            type: ToastType.fail);
                      }
                    }, IconFont.icon_browser, '在默认浏览器打开'),
                    _buildOperateInfo(() {
                      Share.share(webUrl, subject: '快来参加我们的新活动吧！');
                    }, IconFont.icon_fenxiangfangshi, '分享'),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Widget _buildPageContent() {
    return Expanded(
      child: Stack(
        children: [
          WebView(
            onWebViewCreated: (controller) {
              _webViewController = controller;
            },
            initialUrl: webUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (url) => setState(() {
              isWebLoading = true;
            }),
            onPageFinished: (url) {
              _webViewController.currentUrl().then((value) => setState(() {
                    webUrl = value!;
                  }));
              _webViewController.getTitle().then((value) {
                setState(() {
                  webTitle = value!;
                });
              });
              isWebLoading = false;
            },
            onProgress: (onProgressParam) => setState(() {
              sliderValue = onProgressParam / 100;
            }),
          ),
          _buildSlider(),
        ],
      ),
    );
  }

  Widget _buildSlider() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: MediaQuery.of(context).size.height - UIData.spaceSizeHeight50,
      child: Container(
        height: UIData.spaceSizeHeight1,
        width: double.infinity,
        color: UIData.themeBgColor,
        child: isWebLoading
            ? CommonBasicSlider(
                currentValue: sliderValue,
                activeColor: UIData.webSliderColor,
                inactiveColor: UIData.themeBgColor,
                quarterTurns: 4,
                enabledThumbRadius: 1,
                overlayRadius: 1,
                trackHeight: 1,
                onChange: (double value) {},
              )
            : SizedBox(),
      ),
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
          _buildPageContent(),
        ],
      ),
    );
  }
}
