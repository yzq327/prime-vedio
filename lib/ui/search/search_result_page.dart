import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/commom/common_hint_text_contain.dart';
import 'package:primeVedio/http/http_options.dart';
import 'package:primeVedio/http/http_util.dart';
import 'package:primeVedio/models/video_detail_list_model.dart';
import 'package:primeVedio/utils/log_utils.dart';
import 'package:primeVedio/utils/ui_data.dart';

class SearchResultPageParams {
  final String vodName;
  SearchResultPageParams({this.vodName = ''});
}

class SearchResultPage extends StatefulWidget {
  final SearchResultPageParams searchResultPageParams;
  SearchResultPage({Key? key, required this.searchResultPageParams})
      : super(key: key);
  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage>
    with TickerProviderStateMixin {
  List videoList = [];


  void _getVideoListByName() {
    Map<String, Object> params = {
      'ac': 'detail',
      'wd': widget.searchResultPageParams.vodName,
      'pg': 1,
    };
    HttpUtil.request(HttpOptions.baseUrl, HttpUtil.GET, params: params)
        .then((value) {
      VideoDetailListModel model = VideoDetailListModel.fromJson(value);
      if (model.list.length > 0) {
        setState(() {
          videoList = model.list;
        });
      } else {
        LogUtils.printLog('数据为空！');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getVideoListByName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: UIData.themeBgColor,
        appBar: AppBar(
          elevation: 0,
          title: Center(child: CommonText.normalText('搜索结果页'),),
        ),
        body: CommonHintTextContain(text: '数据加载中...'),
       );
  }
}