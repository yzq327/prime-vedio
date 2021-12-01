import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primeVedio/utils/ui_data.dart';

import 'arc_clipper.dart';

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
      backgroundColor: UIData.primaryColor,
      appBar: null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: UIData.spaceSizeHeight16),
            height: UIData.spaceSizeHeight300,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                  sigmaX: UIData.spaceSizeWidth3,
                  sigmaY: UIData.spaceSizeWidth3),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(UIData.spaceSizeWidth100),
                    bottomRight: Radius.circular(UIData.spaceSizeWidth100)),
                child: Image.asset(
                  UIData.myImg,
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
                margin:
                    EdgeInsets.symmetric(horizontal: UIData.spaceSizeWidth12),
                child: Column(
                  children: [
                    Transform.translate(
                        offset: Offset(0, ScreenUtil().setHeight(-160)),
                        child: ClipPath(
                            child: Container(
                                color: UIData.lightBlockColor,
                                height: UIData.spaceSizeHeight60,
                                width: UIData.spaceSizeWidth320,
                                child: null),
                            clipper: ArcClipper())),
                    Container(
                      transform: Matrix4.translationValues(
                          0, -UIData.spaceSizeHeight160, 0),
                      width: double.infinity,
                      height: UIData.spaceSizeHeight160,
                      decoration: BoxDecoration(
                        color: UIData.lightBlockColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(UIData.spaceSizeWidth20),
                            topRight: Radius.circular(UIData.spaceSizeWidth20)),
                      ),
                      child: Column(
                        children: [
                          Container(
                            transform: Matrix4.translationValues(
                                0, -UIData.spaceSizeHeight60, 0),
                            width: UIData.spaceSizeWidth88,
                            height: UIData.spaceSizeWidth88,
                            decoration: BoxDecoration(
                              color: UIData.lightBlockColor,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(UIData.spaceSizeWidth44)),
                            ),
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(UIData.spaceSizeWidth40)),
                                child: Image.asset(
                                  UIData.myImg,
                                  fit: BoxFit.fitWidth,
                                  width: UIData.spaceSizeWidth80,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [],
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
