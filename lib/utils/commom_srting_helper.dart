import 'dart:convert';

import 'package:flutter/cupertino.dart';

class StringsHelper {

//省份简称列表
  static List<String> provinceAbbrList = [
    '京',
    '津',
    '沪',
    '渝',
    '冀',
    '豫',
    '鲁',
    '晋',
    '陕',
    '皖',
    '苏',
    '浙',
    '鄂',
    '湘',
    '赣',
    '闽',
    '粤',
    '桂',
    '琼',
    '川',
    '贵',
    '云',
    '辽',
    '吉',
    '黑',
    '蒙',
    '甘',
    '宁',
    '青',
    '新',
    '藏',
    '港',
    '澳',
    '台',
  ];

//字母和数字列表
  static List<String> letterList = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'J',
    'K',
    'L',
    'M',
    'N',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
  ];

  static bool isEmpty(String content) {
    return content==null||content.trim().length==0;
  }

  static bool isNotEmpty(String content) {
    return content!=null&&content.trim().length>0;
  }

  //获取字符串
  static String getStringValue(value) {
    if(value==null){
      return "";
    }else{
      return value.toString();
    }
  }

  //获取字符串(优先选第一个)
  static String getValidStringValue(String value1,String value2) {
    if(value1==null||value1.isEmpty){
      if(value2==null){
        return "";
      }else{
        return value2.toString();
      }
    }else{
      return value1.toString();
    }
  }

  //获取整数
  static int getIntValue(value) {
    int reValue=0;
    try{
      reValue =int.parse(value);
    }catch(e){

    }
    return reValue;
  }

  //字符串转double
  static double getStringToDoubleValue(value) {
    double reValue=0;
    try{
      reValue =double.parse(value);
    }catch(e){

    }
    return reValue;
  }

  //double转字符串
  static String getDoubleToStringValue(double value) {
    if(value==null){
      return "0";
    }else{
      return value.toString();
    }
  }

  //判断是否是手机号码（以1开头的11位）
  static bool isPhone(String str) {
    if(str==null) return false;
    else return new RegExp('^1\\d{10}\$').hasMatch(str);
  }

  ///
  /// 判断是否车牌号，只判断是否7位数
  ///
  static bool isCarNo(String carNo) {
    return carNo != null && (carNo.length == 7 || carNo.length == 8);
  }

  //判断是否是邮箱
  static bool isEMail(String str) {
    if (str == null)
      return false;
    else
//      return new RegExp(r"^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$").hasMatch(str);
      return new RegExp(r"^\w+@[a-z0-9]+\.[a-z]{2,4}$").hasMatch(str);
  }

  ///
  /// 枚举类型转换成String
  ///
  static String enum2String(var data){
    return data.toString().split('.')[1];
  }

  //判断是否是纯数字
  static bool isNumber(String str) {
    if(str==null) return false;
    else return new RegExp('^\\d').hasMatch(str);
  }

  //判断是否是图片上传返回的uuid
  static bool isUuid(String str) {
    if (str == null)
      return false;
    else
      return new RegExp(r'^[a-z0-9\-]+$').hasMatch(str);
  }

  /*
  * Base64加密
  */
  static String encodeBase64(String data){
    var content = utf8.encode(data);
    var digest = base64Encode(content);
    return digest;
  }

  /*
  * Base64解密
  */
  static String decodeBase64(String data){
    return String.fromCharCodes(base64Decode(data));
  }

  /*
  * 截取年月日时分
  */
  static String subString2YMDHM(String date){
    if(StringsHelper.isNotEmpty(date) && date.length == 19){
      date = date.substring(0, 16);
    }
    return date;
  }

  //判断是否包含特殊字符
  static bool isSpecialChar(String str) {
    RegExp regEx = RegExp("[\$()（）”“‘’\'\"]|-");
    return regEx.hasMatch(str);
  }

  static String getCurrentTimeMillis() {
    return DateTime.now().toLocal().toString().substring(0,19);
  }

  static String formatDuration(Duration? duration) {
    //padLeft: 如果字符串没有'2'的长度，则在前面加上字符串'0'并返回,不会改变原字符串
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration!.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if(duration.inHours > 0) {
      return "${duration.inHours}:$twoDigitMinutes:$twoDigitSeconds";
    } else {
      return "$twoDigitMinutes:$twoDigitSeconds";
    }

  }

  static Size getWidgetSize (BuildContext context) {
    return MediaQuery.of(context).size;
  }
}

