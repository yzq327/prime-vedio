import 'package:flutter/cupertino.dart';
import 'package:primeVedio/ui/home/home_page.dart';
import 'package:primeVedio/ui/home/video_detail_page.dart';
import 'package:primeVedio/ui/mine/mine_page/about_us_page.dart';
import 'package:primeVedio/ui/mine/mine_page/collection_detail_page.dart';
import 'package:primeVedio/ui/mine/mine_page/mine_page.dart';
import 'package:primeVedio/ui/mine/mine_page/my_collection_page.dart';
import 'package:primeVedio/ui/mine/mine_page/new_activities.dart';
import 'package:primeVedio/ui/mine/mine_page/vedio_history_page.dart';
import 'package:primeVedio/ui/mine/mine_page/web_view_page.dart';
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
  static final String mineCollection = '/mine/collection';
  static final String mineAboutUs = '/mine/about';
  static final String mineCollectionDetail = '/mine/Collection/detail';
  static final String mineNewActivities = '/mine/activities';
  static final String mineWebView = '/mine/web';

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
  Routes.mineCollection: (BuildContext context) => MyCollectionPage(),
  Routes.mineAboutUs: (BuildContext context) => AboutUsPage(),
  Routes.mineCollectionDetail: (BuildContext context) => CollectionDetailPage(collectionDetailPageParams: NavigateOption.getParams(context)),
  Routes.mineNewActivities: (BuildContext context) => NewActivities(),
  Routes.mineWebView: (BuildContext context) => WebViewPage(),
};
