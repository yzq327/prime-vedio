import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primeVedio/commom/commom_image.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/commom/common_toast.dart';
import 'package:primeVedio/models/slash_data_model.dart';
import 'package:primeVedio/utils/constants.dart';
import 'package:primeVedio/utils/ui_data.dart';
import 'package:url_launcher/url_launcher.dart';

class Splash extends StatefulWidget {
  final SlashDataModel slashData;
  Splash({
    Key? key,
    required this.slashData,
  }) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late Timer _timer;
  int _countdownTime = CommonConstant.splashSeconds;
  bool isLoading = false;
  SlashDataModel get slashData => widget.slashData;
  @override
  void initState() {
    startCountdownTimer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  void startCountdownTimer() {
    const oneSec = const Duration(seconds: 1);
    var callback = (timer) => {
          setState(() {
            if (_countdownTime < 1) {
              _timer.cancel();
            } else {
              _countdownTime = _countdownTime - 1;
            }
          })
        };
    _timer = Timer.periodic(oneSec, callback);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(375, 812),
        orientation: Orientation.portrait);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            child: CommonImg(vodPic: slashData.imageUrl),
          ),
          Positioned(
              top: UIData.spaceSizeHeight40,
              right: UIData.spaceSizeHeight16,
              child: Container(
                decoration: BoxDecoration(
                    color: UIData.videoStateBgColor,
                    borderRadius: BorderRadius.all(
                        Radius.circular(UIData.spaceSizeWidth10))),
                padding: EdgeInsets.symmetric(
                    vertical: UIData.spaceSizeHeight6,
                    horizontal: UIData.spaceSizeWidth12),
                child: GestureDetector(
                  onTap: (){
                    _timer.cancel();
                    setState(() {
                      _countdownTime = 0;
                    });
                  },
                  child: CommonText.text16("跳过($_countdownTime)",
                      color: UIData.primaryColor),
                ),
              )),
          Positioned(
              bottom: UIData.spaceSizeHeight70,
              right: UIData.spaceSizeWidth70,
              left: UIData.spaceSizeWidth70,
              child: GestureDetector(
                onTap: () async {
                  if (!await launch(slashData.landPageUrl)) {
                    CommonToast.show(
                        context: context,
                        message: "无法打开该网址",
                        type: ToastType.fail);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.symmetric(vertical: UIData.spaceSizeHeight12),
                  decoration: BoxDecoration(
                      color: UIData.slashLintC0lor,
                      borderRadius: BorderRadius.all(
                          Radius.circular(UIData.spaceSizeWidth30))),
                  child: CommonText.text16("前往落地页", color: UIData.primaryColor),
                ),
              )),
        ],
      ),
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    await Future.delayed(Duration(seconds: CommonConstant.splashSeconds));
  }
}
