import 'package:flutter/material.dart';
import 'package:primeVedio/ui/mian_page.dart';
import 'package:primeVedio/ui/splash_page.dart';
import 'package:primeVedio/utils/routes.dart';
import 'package:primeVedio/utils/ui_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(home: Splash());
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



