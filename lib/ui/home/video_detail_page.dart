import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/commom/commom_image.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/commom/common_dialog.dart';
import 'package:primeVedio/commom/common_hint_text_contain.dart';
import 'package:primeVedio/commom/common_toast.dart';
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
import 'package:primeVedio/ui/mine/mine_page/create_collect_dialog.dart';
import 'package:primeVedio/utils/commom_srting_helper.dart';
import 'package:primeVedio/utils/constants.dart';
import 'package:primeVedio/utils/font_icon.dart';
import 'package:primeVedio/utils/log_utils.dart';
import 'package:primeVedio/utils/ui_data.dart';

class VideoDetailPageParams {
  final int vodId;
  final String vodName;
  final String vodPic;
  final int watchedDuration;

  VideoDetailPageParams(
      {required this.vodId,
      this.vodName = '',
      this.vodPic = '',
      this.watchedDuration = 0});
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
  bool showSheet = false;
  List<MyCollectionItem> myCollectionsList = [];
  List<int> collectedVideoNumbers = [];
  TextEditingController _userEtController = TextEditingController();
  List<bool> checkBoxStates = [];
  int currentSelectCollection = 0;
  late bool isCollected = false;

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
    _userEtController.addListener(() {
      setState(() {});
    });
  }

  void initDB() async {
    TablesInit tables = TablesInit();
    tables.init();
    dbUtil = new DBUtil();
    queryData();
  }

  void queryData() async {
    await dbUtil.open();
    List<Map> collectedDate = await dbUtil.queryListByHelper(
        'collection_detail', ['vod_id'], 'vod_id=?', [widget.videoDetailPageParams.vodId]);
    List<Map> data = await dbUtil
        .queryList("SELECT * FROM video_play_record ORDER By create_time DESC");
    setState(() {
      videoHistoryList = data.map((i) => VideoHistoryItem.fromJson(i)).toList();
      isCollected = collectedDate.length > 0;
    });
    await dbUtil.close();
  }

  Future<void> insertData(StoreDuration item) async {
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
    } else if (item.currentPosition > 0) {
      Map<String, Object> par = Map<String, Object>();
      par['create_time'] = StringsHelper.getCurrentTimeMillis();
      par['vod_id'] = widget.videoDetailPageParams.vodId;
      par['vod_name'] = widget.videoDetailPageParams.vodName;
      par['vod_pic'] = widget.videoDetailPageParams.vodPic;
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
    _userEtController.dispose();
    super.dispose();
  }

  void setDurations(StoreDuration item) {
    durations = item;
  }

  void initCheckBoxStates({int? index, bool? value}) {
    checkBoxStates.clear();
    for (int i = 0; i < myCollectionsList.length; i++) {
      if (index == i) {
        checkBoxStates.add(value!);
      } else {
        checkBoxStates.add(false);
      }
    }
    setState(() {});
  }

  void initVideoNumbers() async {
    await dbUtil.open();
    collectedVideoNumbers.clear();
    for (int i = 0; i < myCollectionsList.length; i++) {
      var allData = await dbUtil.queryList(
          "SELECT count(vod_id) as count FROM collection_detail where collect_id = ${myCollectionsList[i].collectId}");
      collectedVideoNumbers.add(allData[0]['count']);
    }
    setState(() {});
    await dbUtil.close();
  }

  queryCollectionData() async {
    await dbUtil.open();
    List<Map> data;
    data = await dbUtil
        .queryList("SELECT * FROM my_collections ORDER By create_time DESC");
    if(data.isEmpty) {
      Map<String, Object> par = Map<String, Object>();
      par['create_time'] = StringsHelper.getCurrentTimeMillis();
      par['collect_name'] = '默认收藏夹';
      par['img'] = UIData.collectionDefaultImg;
      await dbUtil.insertByHelper('my_collections', par);
      data = await dbUtil
          .queryList("SELECT * FROM my_collections ORDER By create_time DESC");
    }
    setState(() {
      myCollectionsList =
          data.map((i) => MyCollectionItem.fromJson(i)).toList();
    });
    initCheckBoxStates();
    initVideoNumbers();
    await dbUtil.close();
  }

  void insertCollectionData() async {
    if(_userEtController.text.trim() == '') {
      CommonToast.show(
          context: context,
          message: "创建失败，不能输入空的文件夹名",
          type: ToastType.fail
          );
    } else {
      await dbUtil.open();
      List<MyCollectionItem> searchedList = myCollectionsList
          .where((element) => element.collectName == _userEtController.text)
          .toList();
      if (searchedList.length > 0) {
        await dbUtil.update(
            'UPDATE my_collections SET create_time = ? WHERE collect_name = ?',
            [StringsHelper.getCurrentTimeMillis(), _userEtController.text]);
        CommonToast.show(
            context: context,
            message: "创建失败，文件夹名已存在",
            type: ToastType.fail);
      } else {
        Map<String, Object> par = Map<String, Object>();
        par['create_time'] = StringsHelper.getCurrentTimeMillis();
        par['collect_name'] = _userEtController.text;
        par['img'] = UIData.collectionDefaultImg;
        await dbUtil.insertByHelper('my_collections', par);
        CommonToast.show(context: context, message: "创建成功");
      }
      _userEtController.text = '';
      await dbUtil.close();
      queryCollectionData();
    }
  }

  void insertCollectionDetailData() async {
    await dbUtil.open();
    Map<String, Object> par = Map<String, Object>();
    par['create_time'] = StringsHelper.getCurrentTimeMillis();
    par['collect_id'] = currentSelectCollection;
    par['vod_id'] = widget.videoDetailPageParams.vodId;
    par['vod_pic'] = widget.videoDetailPageParams.vodPic;
    par['vod_name'] = widget.videoDetailPageParams.vodName;
    await dbUtil.insertByHelper('collection_detail', par);
    CommonToast.show(context: context, message: "收藏成功");
    setState(() {
      isCollected = true;
    });
    await dbUtil.close();
  }

  void cancelCollection() async {
    await dbUtil.open();
    await dbUtil.delete('DELETE FROM collection_detail WHERE vod_id = ?',
        [widget.videoDetailPageParams.vodId]);
    CommonToast.show(context: context, message: "取消收藏成功");
    setState(() {
      isCollected = false;
      currentSelectCollection = 0;
    });
    await dbUtil.close();
  }

  void handleOnCollect(bool value) {
    if (value) {
      setState(() {
        queryCollectionData();
        showSheet = value;
      });
    } else {
      CommonDialog.showAlertDialog(context,
          title: '提示',
          content: '确定要取消收藏吗？',
          onConfirm: () => cancelCollection());
    }
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
              bottom: UIData.spaceSizeHeight16,
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

  Widget _buildCollectionDetail(int index) {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      height: UIData.spaceSizeHeight80,
      margin: EdgeInsets.only(
        bottom: UIData.spaceSizeWidth10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: UIData.spaceSizeHeight80,
              width: UIData.spaceSizeWidth100,
              child: myCollectionsList[index].img.startsWith('http')
                  ? ClipRRect(
                borderRadius:
                BorderRadius.circular(UIData.spaceSizeWidth12),
                child: CommonImg(vodPic: myCollectionsList[index].img),
              )
                  : Image.asset(
                myCollectionsList[index].img,
                fit: BoxFit.fitWidth,
                width: double.infinity,
              )),
          SizedBox(width: UIData.spaceSizeWidth16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText.text18(myCollectionsList[index].collectName),
                CommonText.text18("共 ${collectedVideoNumbers.length > 0 ? collectedVideoNumbers[index] : 0} 部", color: UIData.subTextColor),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                currentSelectCollection = checkBoxStates[index]? 0: myCollectionsList[index].collectId;
                initCheckBoxStates(index: index, value: !checkBoxStates[index]);
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: checkBoxStates[index]
                    ? UIData.primaryColor
                    : UIData.subThemeBgColor,
                borderRadius: BorderRadius.circular(UIData.spaceSizeWidth12),
              ),
              width: UIData.spaceSizeWidth20,
              height: UIData.spaceSizeWidth20,
              alignment: Alignment.center,
              child: !checkBoxStates[index]
                  ? SizedBox()
                  : Container(
                      decoration: BoxDecoration(
                        color: UIData.hoverThemeBgColor,
                        borderRadius:
                            BorderRadius.circular(UIData.spaceSizeWidth12),
                      ),
                      width: UIData.spaceSizeWidth12,
                      height: UIData.spaceSizeWidth12,
                      child: SizedBox(),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet() {
    return Positioned.fill(
        child: Offstage(
      offstage: !showSheet,
      child: Container(
        color: UIData.sheetBgColor,
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4),
          padding: EdgeInsets.all(UIData.spaceSizeWidth24),
          decoration: BoxDecoration(
            color: UIData.sheetContentBgColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(UIData.spaceSizeWidth20),
                topRight: Radius.circular(UIData.spaceSizeWidth20)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          showSheet = false;
                        });
                      },
                      child: Icon(
                        IconFont.icon_guanbi,
                        color: UIData.primaryColor,
                        size: UIData.spaceSizeWidth20,
                      )),
                  GestureDetector(
                      onTap: () {
                        CommonDialog.showAlertDialog(
                          context,
                          title: '新建收藏夹',
                          positiveBtnText: '创建',
                          onConfirm: insertCollectionData,
                          onCancel: () => _userEtController.text = '',
                          content: CreateCollectDialog(
                            userEtController: _userEtController,
                            handleClear: () => _userEtController.text = '',
                          ),
                        );
                      },
                      child: Icon(
                        IconFont.icon_jia,
                        color: UIData.primaryColor,
                        size: UIData.spaceSizeWidth20,
                      )),
                ],
              ),
              SizedBox(height: UIData.spaceSizeHeight24),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: myCollectionsList.length,
                  itemBuilder: (context, index) {
                    return _buildCollectionDetail(index);
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (currentSelectCollection == 0) {
                    CommonToast.show(context: context, message: "请选择收藏夹");
                  } else {
                    insertCollectionDetailData();
                    setState(() {
                      showSheet = false;
                    });
                  }
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.symmetric(vertical: UIData.spaceSizeHeight8),
                  decoration: BoxDecoration(
                    color: UIData.hoverThemeBgColor,
                    borderRadius: BorderRadius.all(
                        Radius.circular(UIData.spaceSizeWidth10)),
                  ),
                  child: CommonText.text18('加入收藏夹', color: UIData.blackColor),
                ),
              )
            ],
          ),
        ),
      ),
    ));
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
            : Stack(
                children: [
                  Column(
                    children: [
                      _buildVideoPlayer(),
                      _buildVideoTabBar(),
                      Expanded(
                          child:
                              TabBarView(controller: _tabController, children: [
                        VideoInfoContent(
                          getVideoDetail: getVideoDetail,
                          urlInfo: urlInfo,
                          onChanged: _playWithIndex,
                          isCollected: isCollected,
                          onCollected: handleOnCollect,
                        ),
                        SameTypeVideoContent(getVideoDetail: getVideoDetail),
                      ])),
                    ],
                  ),
                  _buildBottomSheet(),
                ],
              ));
  }
}
