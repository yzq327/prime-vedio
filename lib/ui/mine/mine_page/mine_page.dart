import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/utils/font_icon.dart';
import 'package:primeVedio/utils/ui_data.dart';

import 'arc_clipper.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {

  Widget _buildMyBgImg() {
    return Container(
      width: double.infinity,
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(bottom: UIData.spaceSizeHeight16),
      height: UIData.spaceSizeHeight300,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(
            sigmaX: UIData.spaceSizeWidth3, sigmaY: UIData.spaceSizeWidth3),
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
    );
  }

  Widget _buildIconInfo(
      IconData icon, String iconText, GestureTapCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: UIData.primaryColor,
            size: UIData.spaceSizeWidth44,
          ),
          Padding(
            padding: EdgeInsets.only(top: UIData.spaceSizeHeight6),
            child: CommonText.text14(iconText),
          )
        ],
      ),
    );
  }

  Widget _buildMyInfo() {
    return Column(
      children: [
        ClipPath(
            child: Container(
                color: UIData.lightBlockColor,
                height: UIData.spaceSizeHeight60,
                width: UIData.spaceSizeWidth320,
                child: CommonText.text18('text', color: UIData.primaryColor)),
            clipper: ArcClipper()),
        Container(
          width: double.infinity,
          height: UIData.spaceSizeHeight160,
          decoration: BoxDecoration(
              color: UIData.lightBlockColor,
              borderRadius:
                  BorderRadius.all(Radius.circular(UIData.spaceSizeWidth20)),
              boxShadow: [
                BoxShadow(
                    color: UIData.shadowColor,
                    offset: Offset(0.0, 10),
                    blurRadius: 10.0,
                    spreadRadius: 0.0)
              ]),
          child: Column(
            children: [
              Container(
                transform:
                    Matrix4.translationValues(0, -UIData.spaceSizeHeight60, 0),
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
              Container(
                transform:
                    Matrix4.translationValues(0, -UIData.spaceSizeHeight20, 0),
                padding: EdgeInsets.only(
                    left: UIData.spaceSizeWidth24,
                    right: UIData.spaceSizeWidth24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildIconInfo(IconFont.icon_lishijilu_copy, '我看过的', () {}),
                    _buildIconInfo(IconFont.icon_shoucangjia, '我收藏的', () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCommonRow(
      IconData icon, String iconText, GestureTapCallback onTap) {
    return Container(
      margin: EdgeInsets.only(bottom: UIData.spaceSizeHeight20),
      padding: EdgeInsets.all(UIData.spaceSizeWidth20),
      width: double.infinity,
      decoration: BoxDecoration(
          color: UIData.lightBlockColor,
          borderRadius:
              BorderRadius.all(Radius.circular(UIData.spaceSizeWidth20)),
          boxShadow: [
            BoxShadow(
                color: UIData.shadowColor,
                offset: Offset(0.0, 3.5),
                blurRadius: 30.0,
                spreadRadius: 3.0)
          ]),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: UIData.spaceSizeWidth8),
            child: Icon(
              icon,
              color: UIData.primaryColor,
              size: UIData.spaceSizeWidth24,
            ),
          ),
          CommonText.text14(iconText),
        ],
      ),
    );
  }

  Widget _buildAboutVideo() {
    return Column(
      children: [
        _buildCommonRow(IconFont.icon_guanyuwomen, '关于我们', () {}),
        _buildCommonRow(IconFont.icon_licensexinxi, 'LICENSE', () {}),
      ],
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
      backgroundColor: UIData.myPageBgColor,
      appBar: null,
      body: ListView(
        children: [
          _buildMyBgImg(),
          Container(
            transform:
                Matrix4.translationValues(0, -UIData.spaceSizeHeight160, 0),
            margin: EdgeInsets.symmetric(horizontal: UIData.spaceSizeWidth12),
            child: Column(
              children: [
                _buildMyInfo(),
                SizedBox(height: UIData.spaceSizeHeight20),
                _buildAboutVideo(),
              ],
            ),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
