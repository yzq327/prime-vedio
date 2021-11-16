import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:primeVedio/utils/log_utils.dart';
import 'http_options.dart';

class HttpUtil {
  static const String GET = 'get';
  static Future<Response> request(String url, String method, {Map<String, dynamic> params, Function errorCallBack}) async {
    Dio dio = HttpOptions.dio;
    try {
      Response response;
      if (method == GET) {
        if (params != null && params.isNotEmpty) {
          if (HttpOptions.isInDebugMode) _urlPrint(url, params: params);
          response = await dio.get(url, queryParameters: params);
        } else {
          if (HttpOptions.isInDebugMode) _urlPrint(url);
          response = await dio.get(url);
        }
      }
      int statusCode = response.statusCode;
      LogUtils.printLog('status:' + response.statusCode.toString());
      if (statusCode != 200) {
        String errorMsg = '网络请求出错，状态码：' + statusCode.toString();
        LogUtils.printLog('errorMsg: $errorMsg');
        return null;
      }
      return response;
    } on DioError catch (e) {
      LogUtils.printLog(e?.message ?? "");
    }
  }

  static void _urlPrint(String url,
      {Map<String, dynamic> params, String jsonData, FormData formData}) {
    String urlStr;
    StringBuffer sb = new StringBuffer();
    sb.write(HttpOptions.baseUrl);
    sb.write(url + '?');
    if (params != null && params.isNotEmpty) {
      params.forEach((key, value) {
        sb.write(key + '=' + value.toString() + '&');
      });
    } else if (jsonData != null && jsonData.isNotEmpty) {
      sb.write(jsonData);
    }
    urlStr = sb.toString();
    if ((params != null && params.isNotEmpty) || formData != null)
      urlStr = urlStr.substring(0, urlStr.length - 1);
    LogUtils.printLog("url:  $urlStr");
  }
}
