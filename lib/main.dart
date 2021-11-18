import 'package:flutter/material.dart';
import 'package:primeVedio/ui/home/video_detail_page.dart';
import 'package:primeVedio/ui/mian_page.dart';
import 'package:primeVedio/ui/mine/mine_page/mine_page.dart';
import 'package:primeVedio/ui/search/search_page.dart';
import 'package:primeVedio/utils/constant.dart';
import 'package:primeVedio/utils/ui_data.dart';
import 'ui/home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prime_Video',
      theme: ThemeData(
        primarySwatch: UIData.themeBgColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        highlightColor: Color.fromRGBO(0, 0, 0, 0),
        splashColor: Color.fromRGBO(0, 0, 0, 0),
      ),
      home: MainPage(),
      routes: <String, WidgetBuilder>{
        Constant.home: (BuildContext context) => HomePage(),
        Constant.search: (BuildContext context) => SearchPage(),
        Constant.mine: (BuildContext context) => MinePage(),
        Constant.detail: (BuildContext context) => VideoDetailPage(),
      },
    );
  }
}

