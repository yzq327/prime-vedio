import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UIData {

  //***************************改版颜色***************************//
  static const primaryColor = Colors.white;
  static const themeBgColor = const Color(0xFF252E39);
  static const subThemeBgColor = const Color(0xFFA3B5B6);
  static const hoverThemeBgColor = const Color(0xFF00B9E7);

  //***************************字体颜色***************************//
  static const mainTextColor = const Color(0xFFFFFFFF);
  static const hoverTextColor = const Color(0xFF0D1821);
  static const subTextColor = const Color(0xFF5A6777);
  static const phTextColor = const Color(0xFFC4C2C2);

  //***************************其余颜色***************************//


  //***************************字号***************************//
  static double fontSize9 = ScreenUtil(allowFontScaling: true).setSp(9);
  static double fontSize10 = ScreenUtil(allowFontScaling: true).setSp(10);
  static double fontSize11 = ScreenUtil(allowFontScaling: true).setSp(11);
  static double fontSize12 = ScreenUtil(allowFontScaling: true).setSp(12);
  static double fontSize13 = ScreenUtil(allowFontScaling: true).setSp(13);
  static double fontSize14 = ScreenUtil(allowFontScaling: true).setSp(14);
  static double fontSize15 = ScreenUtil(allowFontScaling: true).setSp(15);
  static double fontSize16 = ScreenUtil(allowFontScaling: true).setSp(16);
  static double fontSize17 = ScreenUtil(allowFontScaling: true).setSp(17);
  static double fontSize18 = ScreenUtil(allowFontScaling: true).setSp(18);
  static double fontSize20 = ScreenUtil(allowFontScaling: true).setSp(20);
  static double fontSize22 = ScreenUtil(allowFontScaling: true).setSp(22);
  static double fontSize24 = ScreenUtil(allowFontScaling: true).setSp(24);
  static double fontSize26 = ScreenUtil(allowFontScaling: true).setSp(26);
  static double fontSize28 = ScreenUtil(allowFontScaling: true).setSp(28);
  static double fontSize30 = ScreenUtil(allowFontScaling: true).setSp(30);
  static double fontSize32 = ScreenUtil(allowFontScaling: true).setSp(32);
  static double fontSize36 = ScreenUtil(allowFontScaling: true).setSp(36);
  static double fontSize50 = ScreenUtil(allowFontScaling: true).setSp(50);


  //***************************改良字号***************************//
  static double mainTitleFontSize = ScreenUtil(allowFontScaling: true).setSp(20);
  static double normalTitleFontSize = ScreenUtil(allowFontScaling: true).setSp(16);


  //***************************宽度***************************//
  static double spaceSizeWidth1 = ScreenUtil.getInstance().setWidth(1);
  static double spaceSizeWidth2 = ScreenUtil.getInstance().setWidth(2);
  static double spaceSizeWidth3 = ScreenUtil.getInstance().setWidth(3);
  static double spaceSizeWidth4 = ScreenUtil.getInstance().setWidth(4);
  static double spaceSizeWidth5 = ScreenUtil.getInstance().setWidth(5);
  static double spaceSizeWidth6 = ScreenUtil.getInstance().setWidth(6);
  static double spaceSizeWidth8 = ScreenUtil.getInstance().setWidth(8);
  static double spaceSizeWidth10 = ScreenUtil.getInstance().setWidth(10);
  static double spaceSizeWidth12 = ScreenUtil.getInstance().setWidth(12);
  static double spaceSizeWidth14 = ScreenUtil.getInstance().setWidth(14);
  static double spaceSizeWidth15 = ScreenUtil.getInstance().setWidth(15);
  static double spaceSizeWidth16 = ScreenUtil.getInstance().setWidth(16);
  static double spaceSizeWidth18 = ScreenUtil.getInstance().setWidth(18);
  static double spaceSizeWidth20 = ScreenUtil.getInstance().setWidth(20);
  static double spaceSizeWidth24 = ScreenUtil.getInstance().setWidth(24);
  static double spaceSizeWidth26 = ScreenUtil.getInstance().setWidth(26);
  static double spaceSizeWidth30 = ScreenUtil.getInstance().setWidth(30);
  static double spaceSizeWidth32 = ScreenUtil.getInstance().setWidth(32);
  static double spaceSizeWidth34 = ScreenUtil.getInstance().setWidth(34);
  static double spaceSizeWidth36 = ScreenUtil.getInstance().setWidth(36);
  static double spaceSizeWidth40 = ScreenUtil.getInstance().setWidth(40);
  static double spaceSizeWidth48 = ScreenUtil.getInstance().setWidth(48);
  static double spaceSizeWidth50 = ScreenUtil.getInstance().setWidth(50);
  static double spaceSizeWidth56 = ScreenUtil.getInstance().setWidth(56);
  static double spaceSizeWidth60 = ScreenUtil.getInstance().setWidth(60);
  static double spaceSizeWidth70 = ScreenUtil.getInstance().setWidth(70);
  static double spaceSizeWidth80 = ScreenUtil.getInstance().setWidth(80);
  static double spaceSizeWidth90 = ScreenUtil.getInstance().setWidth(90);
  static double spaceSizeWidth100 = ScreenUtil.getInstance().setWidth(100);
  static double spaceSizeWidth116 = ScreenUtil.getInstance().setWidth(116);
  static double spaceSizeWidth120 = ScreenUtil.getInstance().setWidth(120);
  static double spaceSizeWidth130 = ScreenUtil.getInstance().setWidth(130);
  static double spaceSizeWidth150 = ScreenUtil.getInstance().setWidth(150);
  static double spaceSizeWidth200 = ScreenUtil.getInstance().setWidth(200);
  static double spaceSizeWidth224 = ScreenUtil.getInstance().setWidth(224);
  static double spaceSizeWidth283 = ScreenUtil.getInstance().setWidth(283);
  static double spaceSizeWidth343 = ScreenUtil.getInstance().setWidth(343);
  static double spaceSizeWidth400 = ScreenUtil.getInstance().setWidth(400);

  //***************************高度***************************//
  static double spaceSizeHeight1 = ScreenUtil.getInstance().setHeight(1);
  static double spaceSizeHeight2 = ScreenUtil.getInstance().setHeight(2);
  static double spaceSizeHeight3 = ScreenUtil.getInstance().setHeight(3);
  static double spaceSizeHeight4 = ScreenUtil.getInstance().setHeight(4);
  static double spaceSizeHeight6 = ScreenUtil.getInstance().setHeight(6);
  static double spaceSizeHeight8 = ScreenUtil.getInstance().setHeight(8);
  static double spaceSizeHeight10 = ScreenUtil.getInstance().setHeight(10);
  static double spaceSizeHeight12 = ScreenUtil.getInstance().setHeight(12);
  static double spaceSizeHeight14 = ScreenUtil.getInstance().setHeight(14);
  static double spaceSizeHeight15 = ScreenUtil.getInstance().setHeight(15);
  static double spaceSizeHeight16 = ScreenUtil.getInstance().setHeight(16);
  static double spaceSizeHeight18 = ScreenUtil.getInstance().setHeight(18);
  static double spaceSizeHeight20 = ScreenUtil.getInstance().setHeight(20);
  static double spaceSizeHeight24 = ScreenUtil.getInstance().setHeight(24);
  static double spaceSizeHeight26 = ScreenUtil.getInstance().setHeight(26);
  static double spaceSizeHeight30 = ScreenUtil.getInstance().setHeight(30);
  static double spaceSizeHeight32 = ScreenUtil.getInstance().setHeight(32);
  static double spaceSizeHeight34 = ScreenUtil.getInstance().setHeight(34);
  static double spaceSizeHeight40 = ScreenUtil.getInstance().setHeight(40);
  static double spaceSizeHeight48 = ScreenUtil.getInstance().setHeight(48);
  static double spaceSizeHeight50 = ScreenUtil.getInstance().setHeight(50);
  static double spaceSizeHeight60 = ScreenUtil.getInstance().setHeight(60);
  static double spaceSizeHeight70 = ScreenUtil.getInstance().setHeight(70);
  static double spaceSizeHeight80 = ScreenUtil.getInstance().setHeight(80);
  static double spaceSizeHeight90 = ScreenUtil.getInstance().setHeight(90);
  static double spaceSizeHeight100 = ScreenUtil.getInstance().setHeight(100);
  static double spaceSizeHeight120 = ScreenUtil.getInstance().setHeight(120);
  static double spaceSizeHeight130 = ScreenUtil.getInstance().setHeight(130);
  static double spaceSizeHeight150 = ScreenUtil.getInstance().setHeight(150);
  static double spaceSizeHeight200 = ScreenUtil.getInstance().setHeight(200);
  static double spaceSizeHeight400 = ScreenUtil.getInstance().setHeight(400);



  //images
  static const String imageDir = "assets/images";
  static const String imageDirHome = "$imageDir/home"; //首页页面图标

  //*******************首页************************//

  //*******************首页************************//

  //*******************搜索************************//

  //*******************搜索************************//



  //*******************我的************************//

  //*******************我的************************//

  //*******************首页悬浮按钮内页************************//

  static Icon iconMyMessage =
  Icon(IconData(0xe8e4, fontFamily: 'iconfont_new'), color: themeBgColor, size: UIData.fontSize20); //我的-我的消息

  static const String imageChatMineBg = '$imageDir/icon_chat_mine_bg.png'; //聊天页面我的背景图
  static const String imageChatOtherBg = '$imageDir/icon_chat_other_bg.png';

  //*************************消息中心图标******************************//

}
