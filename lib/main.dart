import 'package:flutter/material.dart';
import 'package:primeVedio/ui/mian_page.dart';
import 'package:primeVedio/ui/splash_page.dart';
import 'package:primeVedio/utils/routes.dart';
import 'package:primeVedio/utils/ui_data.dart';
import 'http/http_options.dart';
import 'http/http_util.dart';
import 'models/slash_data_model.dart';

void main() async {
  HttpUtil.request(HttpOptions.slashUrl, HttpUtil.GET).then((value) {
    SlashDataModel slashData = SlashDataModel.fromJson(value);
    if (slashData.imageUrl.isNotEmpty) {
      runApp(MyApp(slashData));
    }
  });
}

class MyApp extends StatelessWidget {
  final SlashDataModel slashData;
  MyApp(this.slashData);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(home: Splash(slashData: slashData));
        } else {
          return MaterialApp(
            title: 'Prime_Video',
            theme: ThemeData(
              primarySwatch: UIData.themeBgColor,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              highlightColor: Color.fromRGBO(0, 0, 0, 0),
              splashColor: Color.fromRGBO(0, 0, 0, 0),
            ),
            home: MainPage(),
            routes: routePath,
          );
        }
      },
    );
  }
}



