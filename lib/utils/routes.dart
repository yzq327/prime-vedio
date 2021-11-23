import 'package:flutter/cupertino.dart';
import 'package:primeVedio/ui/home/home_page.dart';
import 'package:primeVedio/ui/home/video_detail_page.dart';
import 'package:primeVedio/ui/mine/mine_page/mine_page.dart';
import 'package:primeVedio/ui/search/search_page.dart';
import 'package:primeVedio/ui/search/search_result_page.dart';

import 'navigate.dart';

class Routes {
  //首页
  static final String home = '/home';
  //搜索
  static final String search = '/search';
  //我的
  static final String mine = '/mine';
  //视频详情页
  static final String detail = '/home/detail';
  //搜索结果页
  static final String searchResult = '/search/result';
}

var routePath = {
  Routes.home: (BuildContext context) => HomePage(),
  Routes.search: (BuildContext context) => SearchPage(),
  Routes.mine: (BuildContext context) => MinePage(),
  Routes.detail: (BuildContext context) => VideoDetailPage(videoDetailPageParams: NavigateOption.getParams(context)),
  Routes.searchResult: (BuildContext context) => SearchResultPage(searchResultPageParams: NavigateOption.getParams(context),),
};
