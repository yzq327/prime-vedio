import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/commom/common_dialog.dart';
import 'package:primeVedio/commom/common_hint_text_contain.dart';
import 'package:primeVedio/commom/common_smart_refresher.dart';
import 'package:primeVedio/models/common/common_model.dart';
import 'package:primeVedio/table/db_util.dart';
import 'package:primeVedio/table/table_init.dart';
import 'package:primeVedio/ui/mine/mine_page/removable_item.dart';
import 'package:primeVedio/utils/font_icon.dart';
import 'package:primeVedio/utils/ui_data.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VideoHistoryPage extends StatefulWidget {
  @override
  _VideoHistoryPageState createState() => _VideoHistoryPageState();
}

class _VideoHistoryPageState extends State<VideoHistoryPage> {
  RefreshController _refreshController = RefreshController();
  int total = 0;
  List<VideoHistoryItem> videoHistoryList = [];
  late DBUtil dbUtil;
  int currentPage = 1;
  int pageSize = 10;
  static List<GlobalKey<RemovableItemState>> childItemStates = [];

  bool get _enablePullUp {
    return videoHistoryList.length != total;
  }

  @override
  void initState() {
    super.initState();
    initDB();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initChildItemStates() {
    childItemStates.clear();
    for (int i = 0; i < videoHistoryList.length; i++) {
      GlobalKey<RemovableItemState> removeGK = GlobalKey(debugLabel: "$i");
      childItemStates.add(removeGK);
    }
    setState(() {});
  }

  void initDB() async {
    TablesInit tables = TablesInit();
    tables.init();
    dbUtil = new DBUtil();
    queryData();
  }

  queryData() async {
    await dbUtil.open();
    int currentSize = currentPage * pageSize;
    List<Map> allData =
        await dbUtil.queryList("SELECT * FROM video_play_record");
    setState(() {
      total = allData.length;
    });
    List<Map> data = await dbUtil.queryList(
        "SELECT * FROM video_play_record ORDER By create_time DESC LIMIT $currentSize");
    setState(() {
      videoHistoryList = data.map((i) => VideoHistoryItem.fromJson(i)).toList();
    });
    initChildItemStates();
    await dbUtil.close();
  }

  void delete(int? vodId) async {
    await dbUtil.open();
    if (vodId == null) {
      dbUtil.delete('DELETE FROM video_play_record', null);
    } else {
      dbUtil.delete('DELETE FROM video_play_record WHERE vod_id = ?', [vodId]);
    }
    await dbUtil.close();
    queryData();
  }

  void _onRefresh() async {
    setState(() {
      currentPage = 1;
    });
    await queryData();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    setState(() {
      currentPage = currentPage + 1;
    });
    await queryData();
    _refreshController.loadComplete();
  }

  static void closeItems(
      List<GlobalKey<RemovableItemState>> childItemStates, int index) {
    childItemStates.forEach((element) {
      if (element != childItemStates[index]) {
        element.currentState?.closeItems();
      }
    });
  }

  Widget _buildPageHeader() {
    return Padding(
      padding: EdgeInsets.only(
          top: UIData.spaceSizeWidth40,
          bottom: UIData.spaceSizeWidth16,
          left: UIData.spaceSizeWidth16,
          right: UIData.spaceSizeWidth16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, color: UIData.primaryColor),
          ),
          CommonText.text18('我看过的'),
          GestureDetector(
            onTap: () {
              CommonDialog.showAlertDialog(context,
                  title: '提示',
                  content: '确定要清空观影历史吗？',
                  onConfirm: () => delete(null));
            },
            child: Icon(IconFont.icon_clear_l, color: UIData.primaryColor),
          )
        ],
      ),
    );
  }

  Widget _buildVideoDetail(int index) {
    return index == videoHistoryList.length
        ? Container(
            height: UIData.spaceSizeHeight60,
            alignment: Alignment.center,
            child: CommonText.normalText('没有更多观影历史啦',
                color: UIData.subThemeBgColor),
          )
        : RemovableItem(
            videoHistoryList: videoHistoryList,
            onActionDown: () => closeItems(childItemStates, index),
            index: index,
            moveItemKey: childItemStates[index],
            onDeleteItem: delete,
          );
  }

  Widget _buildVideoHistory() {
    return videoHistoryList.length == 0
        ? CommonHintTextContain(text: '暂无观影记录，去看看影片吧')
        : Expanded(
            child: CommonSmartRefresher(
                enablePullUp: _enablePullUp,
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _enablePullUp
                      ? videoHistoryList.length
                      : videoHistoryList.length + 1,
                  itemBuilder: (context, index) {
                    return _buildVideoDetail(index);
                  },
                )),
          );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(375, 812),
        orientation: Orientation.portrait);
    return Scaffold(
      backgroundColor: UIData.themeBgColor,
      appBar: null,
      body: Column(
        children: [
          _buildPageHeader(),
          _buildVideoHistory(),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
