import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/ui/home/type_tab_bar.dart';
import 'package:primeVedio/ui/home/video_swiper.dart';
import 'package:primeVedio/utils/ui_data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(375, 812),
        orientation: Orientation.portrait);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            CommonText.mainTitle('Prime', color: UIData.hoverThemeBgColor),
            SizedBox(width: UIData.spaceSizeWidth8),
            CommonText.mainTitle('Video'),
          ],
        ),
      ),
      body: Column(
        children: [
          TypeTabBar(),
          Expanded(
            child: ListView(
              children: [
                VideoSwiper(),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CommonText.mainTitle('Prime', color: UIData.hoverThemeBgColor),
                    ],
                  ),
                )
              ],
            ),
          )
         ],
      ),
    );
  }
}

