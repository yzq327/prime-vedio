import 'package:flutter/cupertino.dart';
import 'package:primeVedio/utils/ui_data.dart';

import 'font_icon.dart';

class CommonConstant {
  static Map<String, double> speedMap = {
  '正常': 1.0,
  '1.25X': 1.25,
  '1.5X': 1.5,
  '1.75X': 1.75,
  '2.0X': 2.0,
  '3.0X': 3.0,
  };
}

class ToastType {
  static final String success = 'success';
  static final String fail = 'fail';
}

const Map<String, Color> ToastTypeColor = {
  'success': UIData.successBgColor,
  'fail': UIData.failBgColor,
};

const Map<String, IconData> ToastTypeIcon = {
  'success': IconFont.icon_chenggong,
  'fail': IconFont.icon_shibai,
};