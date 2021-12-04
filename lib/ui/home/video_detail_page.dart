import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/commom/common_hint_text_contain.dart';
import 'package:primeVedio/commom/coomom_video_player.dart';
import 'package:primeVedio/http/http_options.dart';
import 'package:primeVedio/http/http_util.dart';
import 'package:primeVedio/models/common/common_model.dart';
import 'package:primeVedio/models/video_detail_list_model.dart';
import 'package:primeVedio/table/db_util.dart';
import 'package:primeVedio/table/table_init.dart';
import 'package:primeVedio/ui/home/same_type_video_content.dart';
import 'package:primeVedio/ui/home/stub_tab_indicator.dart';
import 'package:primeVedio/ui/home/video_info_content.dart';
import 'package:primeVedio/utils/commom_srting_helper.dart';
import 'package:primeVedio/utils/log_utils.dart';
import 'package:primeVedio/utils/ui_data.dart';

class VideoDetailPageParams {
  final int vodId;
  final String vodName;
  final String vodPic;
  final int watchedDuration;

  VideoDetailPageParams(
      {required this.vodId, this.vodName = '', this.vodPic = '', this.watchedDuration = 0});
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
  String? videoUrl;
  List? urlInfo = [];
  List<VideoHistoryItem> videoHistoryList = [];
  late DBUtil dbUtil;
  String currentEpo = '';
  late StoreDuration durations;

  bool get _isFullScreen =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  void _playWithIndex(int index) {
    setState(() {
      videoUrl = urlInfo![index][1];
      currentEpo = urlInfo![index][0];
    });
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
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _getVideoDetailList();
    initDB();
  }

  void initDB() async {
    TablesInit tables = TablesInit();
    tables.init();
    dbUtil = new DBUtil();
    queryData();
  }

  void queryData() async {
    await dbUtil.open();
    List<Map> data = await dbUtil.queryList(
        "SELECT * FROM video_play_record ORDER By create_time DESC");
    setState(() {
      videoHistoryList = data.map((i) => VideoHistoryItem.fromJson(i)).toList();
    });
    await dbUtil.close();
  }

  void insertData(StoreDuration item) async {
    await dbUtil.open();
    List<VideoHistoryItem> searchedList = videoHistoryList
        .where((element) => element.vodId == getVideoDetail!.vodId)
        .toList();
    if (searchedList.length > 0) {
      await dbUtil.update(
          'UPDATE video_play_record SET create_time = ? , vod_epo = ?, watched_duration = ?, total = ?  WHERE vod_id = ?',
          [
            StringsHelper.getCurrentTimeMillis(),
            currentEpo,
            item.currentPosition,
            item.totalDuration,
            widget.videoDetailPageParams.vodId
          ]);
    } else if (item.totalDuration != '00:00'){
      Map<String, Object> par = Map<String, Object>();
      par['create_time'] = StringsHelper.getCurrentTimeMillis();
      par['vod_id'] =  widget.videoDetailPageParams.vodId;
      par['vod_name'] = widget.videoDetailPageParams.vodName;
      par['vod_pic'] =  widget.videoDetailPageParams.vodPic;
      par['vod_epo'] = currentEpo;
      par['total'] = item.totalDuration.toString();
      par['watched_duration'] = item.currentPosition;
      await dbUtil.insertByHelper('video_play_record', par);
    }
    await dbUtil.close();
    queryData();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    insertData(durations);
    super.dispose();
  }

  void setDurations(StoreDuration item) {
    if (!mounted) return;
    setState(() {
      durations = item;
    });
  }

  Widget _buildVideoPlayer() {
    return CommonVideoPlayer(
      url: videoUrl!,
      vodName: widget.videoDetailPageParams.vodName,
      vodPic: widget.videoDetailPageParams.vodPic,
      height: UIData.spaceSizeHeight228,
      onStoreDuration: setDurations,
      watchedDuration: widget.videoDetailPageParams.watchedDuration,
    );
  }

  Widget _buildVideoTabBar() {
    return _isFullScreen
        ? SizedBox()
        : TabBar(
            controller: _tabController,
            labelStyle: TextStyle(fontSize: UIData.fontSize20),
            padding: EdgeInsets.only(
              top: UIData.spaceSizeHeight16,
              left: UIData.spaceSizeWidth50,
            ),
            unselectedLabelStyle: TextStyle(fontSize: UIData.fontSize20),
            isScrollable: true,
            labelPadding:
                EdgeInsets.symmetric(horizontal: UIData.spaceSizeWidth50),
            labelColor: UIData.hoverTextColor,
            unselectedLabelColor: UIData.primaryColor,
            indicatorWeight: 0.0,
            indicator: StubTabIndicator(color: UIData.hoverThemeBgColor),
            tabs: [Tab(text: '详情'), Tab(text: '猜你喜欢')],
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
