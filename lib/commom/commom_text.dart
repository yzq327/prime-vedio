import 'package:flutter/material.dart';
import 'package:primeVedio/utils/ui_data.dart';

class CommonText {
  //主标题
  static Widget mainTitle(text,
      {color = UIData.mainTextColor, textAlign = TextAlign.center, overflow = TextOverflow.ellipsis}) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: UIData.mainTitleFontSize),
      textAlign: textAlign,
      overflow: overflow,
    );
  }

  //常规标题
  static Widget normalTitle(text,
      {color = UIData.mainTextColor, textAlign = TextAlign.center, overflow = TextOverflow.ellipsis}) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: UIData.normalTitleFontSize, fontWeight: FontWeight.bold),
      textAlign: textAlign,
      overflow: overflow,
    );
  }

  //深灰色20号字
  static Widget darkGrey20Text(text,
      {maxLines, overflow = TextOverflow.ellipsis, textAlign = TextAlign.center, FontWeight fontWeight}) {
    return Text(
      text,
      style: TextStyle(color: UIData.themeBgColor, fontSize: UIData.fontSize20, fontWeight: fontWeight),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }

  //自定义颜色18号字
  static Widget text18(text, {height, textAlign = TextAlign.start, color = UIData.primaryColor}) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: UIData.fontSize18, height: height),
      textAlign: textAlign,
    );
  }

//自定义颜色16号字-
  static Widget text16(text, {height, textAlign = TextAlign.start, color = UIData.primaryColor,FontWeight fontWeight,TextOverflow overflow = TextOverflow.ellipsis}) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: UIData.fontSize16,
          height: height,
          fontWeight: fontWeight),
      textAlign: textAlign,
      overflow: overflow,
    );
  }


  //自定义颜色14号字
  static Widget text14(text,
      {height,maxLines,
        textAlign = TextAlign.start,
        color = UIData.primaryColor,
        TextDecoration textDecoration,
        TextOverflow overflow = TextOverflow.ellipsis}) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: UIData.fontSize14, height: height, decoration: textDecoration),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}



