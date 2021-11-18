import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/utils/ui_data.dart';

import 'commom_text.dart';

class CommonHintTextContain extends StatelessWidget{
  final String? text;

  CommonHintTextContain({this.text = '暂无数据'});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UIData.themeBgColor,
      height: UIData.spaceSizeHeight580,
      alignment: Alignment.center,
      child: CommonText.mainTitle(text,
          color: UIData.hoverThemeBgColor),
    );
  }
}
