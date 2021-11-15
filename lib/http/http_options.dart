import 'package:dio/dio.dart';

class HttpOptions {
  static BaseOptions _options = BaseOptions(
    baseUrl: HttpOptions.baseUrl,
    connectTimeout: HttpOptions.connectTimeout,
    receiveTimeout: HttpOptions.receiveTimeout,
  );

  static BaseOptions get getInstance {
    return _options;
  }

  static bool get isInDebugMode {
    bool inDebugMode = false;
    assert(inDebugMode = true); //debug模式执行assert打印log
    return inDebugMode;
  }

  static bool isTrialVersion = false;

  static String baseUrl = urlVideoTypeList;
  static int connectTimeout = 30000;
  static int receiveTimeout = 30000;
  static const int pageSize = 23;

  //分类列表
  static const String urlVideoTypeList = "http://dy.51isu.com:11801/api.php/provide/vod"; //mock-server

  // 搜索：
  static const String urlSearch = 'http://dy.51isu.com:11801/api.php/provide/vod/?ac=detail&wd=%E6%88%91%E7%9A%84&pg=2';

  //分类
  static const String urlVideoType = 'http://dy.51isu.com:11801/api.php/provide/vod/?ac=detail&t=6&pg=2';

  //分类
  static const String urlVideoDetail = 'http://dy.51isu.com:11801/api.php/provide/vod/?ac=detail&ids=46197';

}
