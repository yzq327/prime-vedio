import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/commom/common_hint_text_contain.dart';
import 'package:primeVedio/commom/common_img_display.dart';
import 'package:primeVedio/commom/common_smart_refresher.dart';
import 'package:primeVedio/http/http_options.dart';
import 'package:primeVedio/http/http_util.dart';
import 'package:primeVedio/models/video_detail_list_model.dart';
import 'package:primeVedio/models/video_list_model.dart';
import 'package:primeVedio/utils/log_utils.dart';
import 'package:primeVedio/utils/ui_data.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
  List<VideoInfo> getVideoList = [];
  int total = 0;
  int currentPage = 1;
  RefreshController _refreshController = RefreshController();

  _getVideoListByName() async {
    Map<String, Object> params = {
      'ac': 'detail',
      'wd': widget.searchResultPageParams.vodName,
      'pg': currentPage,
    };
    HttpUtil.request(HttpOptions.baseUrl, HttpUtil.GET, params: params)
        .then((value) {
      VideoListModel model = VideoListModel.fromJson(value);
      if (model.list.length > 0) {
        setState(() {
          total = model.total;
          getVideoList = currentPage == 1
              ? model.list
              : (getVideoList..addAll(model.list));
        });
      } else {
        LogUtils.printLog('数据为空！');
      }
    });
  }

  bool get _enablePullUp {
    return getVideoList.length != total;
  }

  @override
  void initState() {
    super.initState();
    _getVideoListByName();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onRefresh() async {
    setState(() {
      currentPage = 1;
    });
    await _getVideoListByName();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    setState(() {
      currentPage = currentPage + 1;
    });
    await _getVideoListByName();
    _refreshController.loadComplete();
  }

  Widget _buildSearchedVideo(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: UIData.spaceSizeWidth160,
          height: UIData.spaceSizeHeight200,
          child: CommonImgDisplay(
              vodPic: getVideoList[index].vodPic,
              vodId: getVideoList[index].vodId,
              vodName: getVideoList[index].vodName),
        ),
        Container(
            width: UIData.spaceSizeWidth160,
            alignment: Alignment.topLeft,
            margin: EdgeInsets.symmetric(vertical: UIData.spaceSizeHeight8),
            child: CommonText.normalText(
                getVideoList.length > 0 ? getVideoList[index].vodName : '没有值',
                color: UIData.mainTextColor)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIData.themeBgColor,
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: CommonText.normalText('搜索结果页'),
        ),
      ),
      body: getVideoList.length > 0
          ? Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: UIData.spaceSizeWidth16),
                    child: CommonSmartRefresher(
                      enablePullUp: _enablePullUp,
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      child: ListView(
                        children: [
                          GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              mainAxisSpacing: UIData.spaceSizeHeight8,
                              crossAxisSpacing: UIData.spaceSizeWidth8,
                            ),
                            itemCount: getVideoList.length,
                            itemBuilder: (BuildContext context, int index) =>
                                _buildSearchedVideo(index),
                          ),
                          Container(
                            height: UIData.spaceSizeHeight60,
                            alignment: Alignment.center,
                            child: CommonText.normalText(
                                _enablePullUp ? '' : '没有更多影片啦!',
                                color: UIData.subThemeBgColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : CommonHintTextContain(text: '暂未搜索到您想看的影片，换个关键词试试吧'),
    );
  }
}
