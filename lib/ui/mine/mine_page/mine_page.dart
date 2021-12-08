import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/utils/font_icon.dart';
import 'package:primeVedio/utils/routes.dart';
import 'package:primeVedio/utils/ui_data.dart';
import 'package:sqlite_viewer/sqlite_viewer.dart';

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
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Expanded(
              child: Icon(
                icon,
                color: UIData.primaryColor,
                size: UIData.spaceSizeWidth44,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: UIData.spaceSizeHeight6),
              child: CommonText.text14(iconText),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildMyInfo() {
    return Stack(
      children: [
        ClipShadowPath(
            clipper: ArcClipper(),
            shadow: BoxShadow(
              color: UIData.shadowColor,
              blurRadius: UIData.spaceSizeWidth30,
              spreadRadius: 3,
              offset: Offset(
                0,
                UIData.spaceSizeWidth3,
              ),
            ),
            child: Container(
              color: UIData.lightBlockColor,
              width: double.infinity,
              height: UIData.spaceSizeHeight200,
              child: Container(
                padding: EdgeInsets.only(
                    left: UIData.spaceSizeWidth24,
                    bottom: UIData.spaceSizeWidth24,
                    right: UIData.spaceSizeWidth24,
                    top: UIData.spaceSizeHeight104),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildIconInfo(IconFont.icon_lishijilu_copy, '我看过的', () {
                      Navigator.pushNamed(context, Routes.mineVideoHistory);
                    }),
                    _buildIconInfo(IconFont.icon_shoucangjia, '我收藏的', () {
                      Navigator.pushNamed(context, Routes.mineCollection);
                    }),
                  ],
                ),
              ),
            )),
        Positioned.fill(
          child: Container(
            transform: Matrix4.translationValues(0, -UIData.spaceSizeHeight90, 0),
            child: Center(
              child: Container(
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
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCommonRow(
      IconData icon, String iconText, GestureTapCallback onTap) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
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
      ),
    );
  }

  Widget _buildAboutVideo() {
    return Column(
      children: [
        _buildCommonRow(IconFont.icon_guanyuwomen, '关于我们', () {
          Navigator.pushNamed(context, Routes.mineAboutUs);
        }),
        _buildCommonRow(IconFont.icon_licensexinxi, 'LICENSE', () {
          showLicensePage(
            context: context,
            applicationIcon: FlutterLogo(size: UIData.spaceSizeWidth60),
              applicationName: '',
          );
        }),
        _buildCommonRow(IconFont.icon_licensexinxi, '数据库', () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => DatabaseList()));
        }),
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
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: Scaffold(
        backgroundColor: UIData.myPageBgColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildMyBgImg(),
              Container(
                transform: Matrix4.translationValues(0, -UIData.spaceSizeHeight130, 0),
                margin:
                    EdgeInsets.symmetric(horizontal: UIData.spaceSizeWidth12),
                child: Column(
                  children: [
                    _buildMyInfo(),
                    SizedBox(height: UIData.spaceSizeHeight24),
                    _buildAboutVideo(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
