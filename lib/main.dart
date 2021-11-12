import 'package:flutter/material.dart';
import 'package:primeVedio/utils/constant.dart';
import 'package:primeVedio/utils/ui_data.dart';
import 'home/home_page.dart';

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
      ),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        Constant.home: (BuildContext context) => HomePage(),
        Constant.search: (BuildContext context) => HomePage(),
        Constant.mine: (BuildContext context) => HomePage(),
      },
    );
  }
}

