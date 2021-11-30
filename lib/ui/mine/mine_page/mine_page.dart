import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/utils/ui_data.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(375, 812),
        orientation: Orientation.portrait);
    return Scaffold(
      backgroundColor: UIData.myPageBgColor,
      appBar: null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: UIData.spaceSizeHeight16),
            height: UIData.spaceSizeHeight300,
            decoration: BoxDecoration(
              // color: UIData.myPageBgColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(UIData.spaceSizeWidth120),
                  bottomRight: Radius.circular(UIData.spaceSizeWidth120)),
            ),
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: UIData.spaceSizeWidth3, sigmaY: UIData.spaceSizeWidth3),
              child: Image.asset(
                UIData.myImg,
                fit: BoxFit.fitWidth,
                width: double.infinity,
              ),
            ),
          ),
          Expanded(
            child: Container(
                width: double.infinity,
                color: UIData.myPageBgColor,
                child: CommonText.mainTitle('Mine',
                    color: UIData.hoverThemeBgColor)),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
