import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UIData {

  //***************************改版颜色***************************//
  static const primaryColor = Colors.white;
  static const MaterialColor themeBgColor = const MaterialColor(
    0xFF252E39,
    const <int, Color>{
      50: const Color(0xFF252E39),
      100: const Color(0xFF252E39),
      200: const Color(0xFF252E39),
      300: const Color(0xFF252E39),
      400: const Color(0xFF252E39),
      500: const Color(0xFF252E39),
      600: const Color(0xFF252E39),
      700: const Color(0xFF252E39),
      800: const Color(0xFF252E39),
      900: const Color(0xFF252E39),
    },
  );

  // static const themeBgColor = const Color(0xFF252E39);
  static const subThemeBgColor = const Color(0xFFA3B5B6);
  static const hoverThemeBgColor = const Color(0xFF00B9E7);

  //***************************字体颜色***************************//
  static const mainTextColor = const Color(0xFFFFFFFF);
  static const hoverTextColor = const Color(0xFF0D1821);
  static const subTextColor = const Color(0xFF5A6777);
  static const defaultImgBgColor = const Color(0xFFA3B5B6);
  static const phTextColor = const Color(0xFFC4C2C2);
  static const darkWhiteColor = const Color(0xFFF6F7F9);
  static const blackColor = const Color(0xFF000000);
  static const darkBlueColor = const Color(0xFF09647A);
  static const textDefaultColor = const Color(0xFF9C9C9C);
  static const videoStateDefaultColor = const Color.fromRGBO(255, 255, 255, 0.5);
  static const videoSlideBgColor = const Color.fromRGBO(0, 0, 0, 0.3);
  static const videoStateBgColor = const Color.fromRGBO(0, 0, 0, 0.5);
  static const myPageBgColor = const Color(0xFF0D1821);
  static const lightBlockColor = const Color(0xFF081923);
  static const shadowColor =  const Color.fromRGBO(210, 234, 242, 0.25);
  static const inputBgColor =  const Color(0xFFEDEDED);



  //***************************其余颜色***************************//


  //***************************字号***************************//
  static double fontSize8 = ScreenUtil().setSp(8);
  static double fontSize9 = ScreenUtil().setSp(9);
  static double fontSize10 = ScreenUtil().setSp(10);
  static double fontSize11 = ScreenUtil().setSp(11);
  static double fontSize12 = ScreenUtil().setSp(12);
  static double fontSize13 = ScreenUtil().setSp(13);
  static double fontSize14 = ScreenUtil().setSp(14);
  static double fontSize15 = ScreenUtil().setSp(15);
  static double fontSize16 = ScreenUtil().setSp(16);
  static double fontSize17 = ScreenUtil().setSp(17);
  static double fontSize18 = ScreenUtil().setSp(18);
  static double fontSize20 = ScreenUtil().setSp(20);
  static double fontSize22 = ScreenUtil().setSp(22);
  static double fontSize24 = ScreenUtil().setSp(24);
  static double fontSize26 = ScreenUtil().setSp(26);
  static double fontSize28 = ScreenUtil().setSp(28);
  static double fontSize40 = ScreenUtil().setSp(40);



  //***************************改良字号***************************//
  static double mainTitleFontSize = ScreenUtil().setSp(20);
  static double normalTitleFontSize = ScreenUtil().setSp(16);


  //***************************宽度***************************//
  static double spaceSizeWidth1 = ScreenUtil().setWidth(1);
  static double spaceSizeWidth2 = ScreenUtil().setWidth(2);
  static double spaceSizeWidth3 = ScreenUtil().setWidth(3);
  static double spaceSizeWidth4 = ScreenUtil().setWidth(4);
  static double spaceSizeWidth6 = ScreenUtil().setWidth(6);
  static double spaceSizeWidth8 = ScreenUtil().setWidth(8);
  static double spaceSizeWidth10 = ScreenUtil().setWidth(10);
  static double spaceSizeWidth12 = ScreenUtil().setWidth(12);
  static double spaceSizeWidth14 = ScreenUtil().setWidth(14);
  static double spaceSizeWidth15 = ScreenUtil().setWidth(15);
  static double spaceSizeWidth16 = ScreenUtil().setWidth(16);
  static double spaceSizeWidth18 = ScreenUtil().setWidth(18);
  static double spaceSizeWidth20 = ScreenUtil().setWidth(20);
  static double spaceSizeWidth24 = ScreenUtil().setWidth(24);
  static double spaceSizeWidth26 = ScreenUtil().setWidth(26);
  static double spaceSizeWidth30 = ScreenUtil().setWidth(30);
  static double spaceSizeWidth32 = ScreenUtil().setWidth(32);
  static double spaceSizeWidth34 = ScreenUtil().setWidth(34);
  static double spaceSizeWidth36 = ScreenUtil().setWidth(36);
  static double spaceSizeWidth40 = ScreenUtil().setWidth(40);
  static double spaceSizeWidth44 = ScreenUtil().setWidth(44);
  static double spaceSizeWidth48 = ScreenUtil().setWidth(48);
  static double spaceSizeWidth50 = ScreenUtil().setWidth(50);
  static double spaceSizeWidth56 = ScreenUtil().setWidth(56);
  static double spaceSizeWidth60 = ScreenUtil().setWidth(60);
  static double spaceSizeWidth70 = ScreenUtil().setWidth(70);
  static double spaceSizeWidth80 = ScreenUtil().setWidth(80);
  static double spaceSizeWidth88 = ScreenUtil().setWidth(88);
  static double spaceSizeWidth90 = ScreenUtil().setWidth(90);
  static double spaceSizeWidth100 = ScreenUtil().setWidth(100);
  static double spaceSizeWidth110 = ScreenUtil().setWidth(110);
  static double spaceSizeWidth120 = ScreenUtil().setWidth(120);
  static double spaceSizeWidth130 = ScreenUtil().setWidth(130);
  static double spaceSizeWidth150 = ScreenUtil().setWidth(150);
  static double spaceSizeWidth160 = ScreenUtil().setWidth(160);
  static double spaceSizeWidth200 = ScreenUtil().setWidth(200);
  static double spaceSizeWidth224 = ScreenUtil().setWidth(224);
  static double spaceSizeWidth283 = ScreenUtil().setWidth(283);
  static double spaceSizeWidth320 = ScreenUtil().setWidth(320);
  static double spaceSizeWidth350 = ScreenUtil().setWidth(350);
  static double spaceSizeWidth400 = ScreenUtil().setWidth(400);

  //***************************高度***************************//
  static double spaceSizeHeight1 = ScreenUtil().setHeight(1);
  static double spaceSizeHeight2 = ScreenUtil().setHeight(2);
  static double spaceSizeHeight3 = ScreenUtil().setHeight(3);
  static double spaceSizeHeight4 = ScreenUtil().setHeight(4);
  static double spaceSizeHeight6 = ScreenUtil().setHeight(6);
  static double spaceSizeHeight8 = ScreenUtil().setHeight(8);
  static double spaceSizeHeight10 = ScreenUtil().setHeight(10);
  static double spaceSizeHeight12 = ScreenUtil().setHeight(12);
  static double spaceSizeHeight14 = ScreenUtil().setHeight(14);
  static double spaceSizeHeight15 = ScreenUtil().setHeight(15);
  static double spaceSizeHeight16 = ScreenUtil().setHeight(16);
  static double spaceSizeHeight18 = ScreenUtil().setHeight(18);
  static double spaceSizeHeight20 = ScreenUtil().setHeight(20);
  static double spaceSizeHeight24 = ScreenUtil().setHeight(24);
  static double spaceSizeHeight26 = ScreenUtil().setHeight(26);
  static double spaceSizeHeight30 = ScreenUtil().setHeight(30);
  static double spaceSizeHeight32 = ScreenUtil().setHeight(32);
  static double spaceSizeHeight34 = ScreenUtil().setHeight(34);
  static double spaceSizeHeight40 = ScreenUtil().setHeight(40);
  static double spaceSizeHeight44 = ScreenUtil().setHeight(44);
  static double spaceSizeHeight48 = ScreenUtil().setHeight(48);
  static double spaceSizeHeight50 = ScreenUtil().setHeight(50);
  static double spaceSizeHeight60 = ScreenUtil().setHeight(60);
  static double spaceSizeHeight70 = ScreenUtil().setHeight(70);
  static double spaceSizeHeight80 = ScreenUtil().setHeight(80);
  static double spaceSizeHeight90 = ScreenUtil().setHeight(90);
  static double spaceSizeHeight100 = ScreenUtil().setHeight(100);
  static double spaceSizeHeight104 = ScreenUtil().setHeight(104);
  static double spaceSizeHeight114 = ScreenUtil().setHeight(114);
  static double spaceSizeHeight120 = ScreenUtil().setHeight(120);
  static double spaceSizeHeight130 = ScreenUtil().setHeight(130);
  static double spaceSizeHeight140 = ScreenUtil().setHeight(140);
  static double spaceSizeHeight150 = ScreenUtil().setHeight(150);
  static double spaceSizeHeight160 = ScreenUtil().setHeight(160);
  static double spaceSizeHeight172 = ScreenUtil().setHeight(172);
  static double spaceSizeHeight180 = ScreenUtil().setHeight(180);
  static double spaceSizeHeight200 = ScreenUtil().setHeight(200);
  static double spaceSizeHeight210 = ScreenUtil().setHeight(210);
  static double spaceSizeHeight220 = ScreenUtil().setHeight(220);
  static double spaceSizeHeight228 = ScreenUtil().setHeight(228);
  static double spaceSizeHeight240 = ScreenUtil().setHeight(240);
  static double spaceSizeHeight264 = ScreenUtil().setHeight(264);

  static double spaceSizeHeight300 = ScreenUtil().setHeight(300);
  static double spaceSizeHeight400 = ScreenUtil().setHeight(400);
  static double spaceSizeHeight580 = ScreenUtil().setHeight(580);
  static double spaceSizeHeight700 = ScreenUtil().setHeight(700);



  //images
  static const String imageDir = "assets/images";
  static const String defaultImg = "$imageDir/default_img.png"; //加载失败默认图片
  static const String myImg = "$imageDir/my_img.png"; //我的头像


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
