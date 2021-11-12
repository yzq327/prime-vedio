import 'package:flutter/material.dart';
import 'package:primeVedio/utils/constant.dart';
import 'package:primeVedio/utils/ui_data.dart';

import 'home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: UIData.themeBgColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'Flutter Demo Home Page'),
      routes: <String, WidgetBuilder>{
        Constant.home: (BuildContext context) => HomePage(),
        Constant.search: (BuildContext context) => HomePage(),
        Constant.mine: (BuildContext context) => HomePage(),
      },
    );
  }
}

