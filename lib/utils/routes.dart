import 'package:flutter/cupertino.dart';
import 'package:primeVedio/ui/home/home_page.dart';
import 'package:primeVedio/ui/home/video_detail_page.dart';
import 'package:primeVedio/ui/mine/mine_page/mine_page.dart';
import 'package:primeVedio/ui/mine/mine_page/vedio_history_page.dart';
import 'package:primeVedio/ui/search/search_page.dart';
import 'package:primeVedio/ui/search/search_result_page.dart';

import 'navigate.dart';

class Routes {
  //首页
  static final String home = '/home';
  //视频详情页
  static final String detail = '/home/detail';

  //搜索
  static final String search = '/search';
  //搜索结果页
  static final String searchResult = '/search/result';

  //我的
  static final String mine = '/mine';
  static final String mineVideoHistory = '/mine/history';

}

var routePath = {
  //首页
  Routes.home: (BuildContext context) => HomePage(),
  Routes.detail: (BuildContext context) => VideoDetailPage(videoDetailPageParams: NavigateOption.getParams(context)),
  //搜索页
  Routes.search: (BuildContext context) => SearchPage(),
  Routes.searchResult: (BuildContext context) => SearchResultPage(searchResultPageParams: NavigateOption.getParams(context),),
  //我的
  Routes.mine: (BuildContext context) => MinePage(),
  Routes.mineVideoHistory: (BuildContext context) => VideoHistoryPage(),
};
