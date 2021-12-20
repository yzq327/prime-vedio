import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primeVedio/commom/common_basic_slider.dart';
import 'package:primeVedio/commom/common_page_header.dart';
import 'package:primeVedio/commom/common_toast.dart';
import 'package:primeVedio/utils/font_icon.dart';
import 'package:primeVedio/utils/ui_data.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  bool showOperations = false;
  String webUrl = 'https://daa9-202-66-38-130.ngrok.io/webView';
  String webTitle = 'WebView Html';
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
      onRightTop: () => setState(() {
        showOperations = !showOperations;
      }),
    );
  }

  Set<JavascriptChannel> _alertJavascriptChannel(BuildContext context) {
    return {
      JavascriptChannel(
          name: "toast",
          onMessageReceived: (message) {
            CommonToast.show(
              context: context,
              message: message.message,
            );
          }),
      JavascriptChannel(
          name: "jscomm",
          onMessageReceived: (message) {
            Navigator.pop(context);
          }),
    };
  }

  Widget _buildPageContent() {
    return Expanded(
      child: Stack(
        children: [
          WebView(
            initialUrl: webUrl,
            onWebViewCreated: (controller) {
              _webViewController = controller;
            },
            javascriptMode: JavascriptMode.unrestricted,
            javascriptChannels: _alertJavascriptChannel(context),
            onPageStarted: (webUrl) => setState(() {
              isWebLoading = true;
            }),
            onPageFinished: (webUrl) => setState(() {
              _webViewController.currentUrl().then((value) {
                setState(() {
                  webUrl = value!;
                });
              });
              isWebLoading = false;
            }),
            onProgress: (onProgressParam) => setState(() {
              sliderValue = onProgressParam / 100;
            }),
          ),
          _buildSlider(),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.5,
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_webViewController != null) {
                        _webViewController
                            .runJavascriptReturningResult(
                                "flutterCallJsMethod('Flutter调用了JS')")
                            .then((value) {
                          CommonToast.show(
                            context: context,
                            message: value,
                          );
                        });
                      }
                    },
                    child: Text("点击Flutter调用JS有返回值"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_webViewController != null) {
                        _webViewController.runJavascript(
                            "flutterCallJsMethodNoResult('visible')");
                      }
                    },
                    child: Text("点击Flutter调用JS无返回值"),
                  ),
                ],
              ))
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
