import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/utils/ui_data.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'commom_text.dart';

class CommonRefreshHeaderContent extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return WaterDropHeader(
        refresh: CircularProgressIndicator(
            strokeWidth: 2.0, color: UIData.hoverThemeBgColor),
        waterDropColor: UIData.hoverThemeBgColor,
        complete: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.done,
              color: Colors.grey,
            ),
            Container(
              width: 15.0,
            ),
            CommonText.normalText('加载完成!', color: UIData.subThemeBgColor)
          ],
        ),
        idleIcon: Icon(
          Icons.autorenew,
          size: 20,
          color: Colors.white,
        ));
  }
}
