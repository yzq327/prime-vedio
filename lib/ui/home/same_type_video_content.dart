import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/commom/common_hint_text_contain.dart';
import 'package:primeVedio/commom/common_img_display.dart';
import 'package:primeVedio/commom/common_refresh_footer_content.dart';
import 'package:primeVedio/commom/common_refresh_header_content.dart';
import 'package:primeVedio/http/http_options.dart';
import 'package:primeVedio/http/http_util.dart';
import 'package:primeVedio/models/video_detail_list_model.dart';
import 'package:primeVedio/models/video_list_model.dart';
import 'package:primeVedio/ui/home/video_detail_page.dart';
import 'package:primeVedio/utils/routes.dart';
import 'package:primeVedio/utils/log_utils.dart';
import 'package:primeVedio/utils/ui_data.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SameTypeVideoContent extends StatefulWidget {
  final VideoDetail? getVideoDetail;
  SameTypeVideoContent({Key? key, required this.getVideoDetail})
      : super(key: key);

  _SameTypeVideoContentState createState() => _SameTypeVideoContentState();
}

class _SameTypeVideoContentState extends State<SameTypeVideoContent> {
  List<VideoInfo> getVideoList = [];
  int total = 0;
  int currentPage = 1;

  RefreshController _refreshController = RefreshController();

  _getVideoTypeList() async {
    Map<String, Object> params = {
      'ac': 'detail',
      't': widget.getVideoDetail!.typeId,
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
                  .where((element) =>
                      element.vodId != widget.getVideoDetail!.vodId)
                  .toList()
              : (getVideoList..addAll(model.list))
                  .where((element) =>
                      element.vodId != widget.getVideoDetail!.vodId)
                  .toList();
        });
      } else {
        LogUtils.printLog('数据为空！');
      }
    });
  }

  bool get _enablePullUp {
    print('getVideoList.length != total: ${getVideoList.length != total}');
    return getVideoList.length != total - 1;
  }

  @override
  void initState() {
    _getVideoTypeList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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

  Widget _buildRecommendVideo(int index) {
    return Container(
      margin: EdgeInsets.only(
        left: UIData.spaceSizeWidth20,
        bottom: UIData.spaceSizeHeight8,
        right: UIData.spaceSizeWidth16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: UIData.spaceSizeHeight100,
              width: UIData.spaceSizeWidth160,
              child: CommonImgDisplay(
                vodPic: getVideoList[index].vodPic,
                vodId: getVideoList[index].vodId,
                vodName: getVideoList[index].vodName,
              )),
          SizedBox(width: UIData.spaceSizeWidth18),
          GestureDetector(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: UIData.spaceSizeWidth160,
                    child: CommonText.text18(getVideoList[index].vodName)),
                SizedBox(
                  height: UIData.spaceSizeHeight8,
                ),
                CommonText.text18("评分：${getVideoList[index].vodScore}",
                    color: UIData.subTextColor),
                SizedBox(
                  height: UIData.spaceSizeHeight8,
                ),
                CommonText.text14("上线年份： ${getVideoList[index].vodYear}",
                    color: UIData.hoverThemeBgColor),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, Routes.detail,
                  arguments: VideoDetailPageParams(
                      vodId: getVideoList[index].vodId,
                      vodName: getVideoList[index].vodName));
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getVideoList.length > 0
        ? SmartRefresher(
            enablePullDown: true,
            enablePullUp: _enablePullUp,
            header: CommonRefreshHeaderContent(),
            footer: CommonRefreshFooterContent(),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView(
              shrinkWrap: true,
              children: getVideoList
                  .asMap()
                  .keys
                  .map((index) => _buildRecommendVideo(index))
                  .toList()
                ..add(Container(
                  height: UIData.spaceSizeHeight60,
                  alignment: Alignment.center,
                  child: CommonText.normalText(_enablePullUp ? '' : '没有更多同类型影片啦!',
                      color: UIData.subThemeBgColor),
                )),
            ))
        : CommonHintTextContain(text: '暂无同类型影片，看看其他的吧');
  }
}
