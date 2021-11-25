import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/commom/common_hint_text_contain.dart';
import 'package:primeVedio/commom/coomom_video_player.dart';
import 'package:primeVedio/http/http_options.dart';
import 'package:primeVedio/http/http_util.dart';
import 'package:primeVedio/models/video_detail_list_model.dart';
import 'package:primeVedio/ui/home/same_type_video_content.dart';
import 'package:primeVedio/ui/home/stub_tab_indicator.dart';
import 'package:primeVedio/ui/home/video_info_content.dart';
import 'package:primeVedio/utils/log_utils.dart';
import 'package:primeVedio/utils/ui_data.dart';
import 'package:video_player/video_player.dart';

class VideoDetailPageParams {
  final int vodId;
  final String vodName;

  VideoDetailPageParams({required this.vodId, this.vodName = ''});
}

class VideoDetailPage extends StatefulWidget {
  final VideoDetailPageParams videoDetailPageParams;
  VideoDetailPage({Key? key, required this.videoDetailPageParams})
      : super(key: key);
  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with TickerProviderStateMixin {
  VideoDetail? getVideoDetail;
  TabController? _tabController;
  VideoPlayerController? _videoPlayerController;
  List? urlInfo = [];
  bool isPlaying = false;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  void _playWithIndex(int index) {
    _videoPlayerController?.dispose();
    _videoPlayerController = VideoPlayerController.network(urlInfo![index][1])
      ..initialize()
      ..addListener(() {
        position = _videoPlayerController?.value.position ?? Duration.zero;
        duration = _videoPlayerController?.value.duration ?? Duration.zero;
        setState(() {});
      })
      ..play();
  }

  void _getVideoDetailList() {
    Map<String, Object> params = {
      'ac': 'detail',
      'ids': widget.videoDetailPageParams.vodId,
    };
    HttpUtil.request(HttpOptions.baseUrl, HttpUtil.GET, params: params)
        .then((value) {
      VideoDetailListModel model = VideoDetailListModel.fromJson(value);
      if (model.list.length > 0) {
        setState(() {
          getVideoDetail = model.list[0];
          String vodPlayUrl = model.list[0].vodPlayUrl;
          if (vodPlayUrl.isNotEmpty) {
            urlInfo = vodPlayUrl.split('#').map((e) => e.split('\$')).toList();
            _playWithIndex(0);
          }
        });
      } else {
        LogUtils.printLog('数据为空！');
      }
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _getVideoDetailList();
    super.initState();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  Widget _buildVideoPlayer() {
    return Container(
      alignment: Alignment.center,
      height: UIData.spaceSizeHeight228,
      width: double.infinity,
      child: urlInfo!.isNotEmpty
          ? CommonVideoPlayer(controller: _videoPlayerController, position: position, duration: duration, vodName: widget.videoDetailPageParams.vodName)
          : CommonText.mainTitle('暂无视频资源，尽情期待',
              color: UIData.hoverThemeBgColor),
    );
  }

  Widget _buildVideoTabBar() {
    return Container(
      alignment: Alignment.topLeft,
      width: 400,
      margin: EdgeInsets.symmetric(vertical: UIData.spaceSizeHeight24),
      child: TabBar(
        controller: _tabController,
        labelStyle: TextStyle(fontSize: UIData.fontSize20),
        padding: EdgeInsets.only(
          left: UIData.spaceSizeWidth50,
        ),
        unselectedLabelStyle: TextStyle(fontSize: UIData.fontSize20),
        isScrollable: true,
        labelPadding: EdgeInsets.symmetric(horizontal: UIData.spaceSizeWidth50),
        labelColor: UIData.hoverTextColor,
        unselectedLabelColor: UIData.primaryColor,
        indicatorWeight: 0.0,
        indicator: StubTabIndicator(color: UIData.hoverThemeBgColor),
        tabs: [Tab(text: '详情'), Tab(text: '猜你喜欢')],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: UIData.themeBgColor,
        appBar: PreferredSize(
            child: AppBar(
              elevation: 0,
            ),
            preferredSize: Size.fromHeight(0)),
        body: getVideoDetail == null
            ? CommonHintTextContain(text: '数据加载中...')
            : Column(
                children: [
                  _buildVideoPlayer(),
                  _buildVideoTabBar(),
                  Expanded(
                      child: TabBarView(controller: _tabController, children: [
                    VideoInfoContent(
                      getVideoDetail: getVideoDetail,
                      urlInfo: urlInfo,
                      onChanged: _playWithIndex,
                    ),
                    SameTypeVideoContent(getVideoDetail: getVideoDetail),
                  ])),
                ],
              ));
  }
}
