import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/commom/common_hint_text_contain.dart';
import 'package:primeVedio/http/http_options.dart';
import 'package:primeVedio/http/http_util.dart';
import 'package:primeVedio/models/video_list_model.dart';
import 'package:primeVedio/ui/home/recent_video_container.dart';
import 'package:primeVedio/ui/home/video_swiper.dart';
import 'package:primeVedio/utils/log_utils.dart';
import 'package:primeVedio/utils/ui_data.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TabContent extends StatefulWidget {
  final int typeId;
  TabContent({Key? key, required this.typeId}) : super(key: key);

  _TabContentState createState() => _TabContentState();
}

class _TabContentState extends State<TabContent> {
  List<VideoInfo> getVideoList = [];
  int total = 0;
  int currentPage = 1;

  bool get _enablePullUp {
    return getVideoList.length != total;
  }

  RefreshController _refreshController = RefreshController();

  _getVideoTypeList() async {
    Map<String, Object> params = {
      'ac': 'detail',
      't': widget.typeId,
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

  @override
  void initState() {
    _getVideoTypeList();
    super.initState();
  }

  void _onRefresh() async {
    setState(() {
      currentPage = 1;
    });
    await _getVideoTypeList();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    setState(() {
      currentPage = currentPage + 1;
    });
    await _getVideoTypeList();
    _refreshController.loadComplete();
  }

  Widget _buildFooterContent() {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        String text;
        if (mode == LoadStatus.loading) {
          body = CircularProgressIndicator(
              strokeWidth: 2.0, color: UIData.hoverThemeBgColor);
        } else {
          if (mode == LoadStatus.idle) {
            text = '上拉加载更多';
          } else if (mode == LoadStatus.failed) {
            text = '加载失败！点击重试！';
          } else if (mode == LoadStatus.canLoading) {
            text = '松手即可加载更多!';
          } else {
            text = '没有更多数据了!';
          }
          body = CommonText.normalText(text, color: UIData.subThemeBgColor);
        }
        return Container(
          height: UIData.spaceSizeHeight60,
          child: body,
        );
      },
    );
  }

  Widget _buildHeaderContent() {
    return WaterDropHeader(
        refresh: CircularProgressIndicator(
            strokeWidth: 2.0, color: UIData.hoverThemeBgColor),
        waterDropColor: UIData.hoverThemeBgColor,
        complete: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.done,
              color: Colors.grey,
            ),
            Container(
              width: 15.0,
            ),
            CommonText.normalText('加载完成!', color: UIData.subThemeBgColor)
          ],
        ),
        idleIcon: Icon(
          Icons.autorenew,
          size: 20,
          color: Colors.white,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: _enablePullUp,
      header: _buildHeaderContent(),
      footer: _buildFooterContent(),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView(
        children: getVideoList.length > 0
            ? [
                VideoSwiper(videoList: getVideoList),
                RecentVideoContainer(videoList: getVideoList),
                Container(
                  height: UIData.spaceSizeHeight60,
                  alignment: Alignment.center,
                  child: CommonText.normalText(_enablePullUp ? '' : '没有更多数据了!',
                      color: UIData.subThemeBgColor),
                )
              ]
            : [
                CommonHintTextContain(),
              ],
      ),
    );
  }
}
