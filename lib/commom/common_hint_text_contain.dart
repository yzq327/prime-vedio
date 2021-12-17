import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/utils/ui_data.dart';

import 'commom_text.dart';

class CommonHintTextContain extends StatelessWidget{
  final String? text;
  final double? height;

  CommonHintTextContain({this.text = '暂无数据', this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UIData.themeBgColor,
      height: height ?? UIData.spaceSizeHeight580,
      alignment: Alignment.center,
      child: CommonText.mainTitle(text,
          color: UIData.hoverThemeBgColor, overflow: TextOverflow.visible),
    );
  }
}
