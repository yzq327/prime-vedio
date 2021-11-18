import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/http/http_options.dart';
import 'package:primeVedio/http/http_util.dart';
import 'package:primeVedio/models/video_type_list_model.dart';
import 'package:primeVedio/ui/home/stub_tab_indicator.dart';
import 'package:primeVedio/ui/home/tab_content.dart';
import 'package:primeVedio/utils/log_utils.dart';
import 'package:primeVedio/utils/ui_data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<VideoType> getTypeList = [];
  late TabController _tabController;
  int currentTabIndex = 0;

  _getVideoTypeList() {
    HttpUtil.request(HttpOptions.baseUrl, HttpUtil.GET).then((value) {
      VideoTypeListModel model = VideoTypeListModel.fromJson(value);
      if (model.typeList != null && model.typeList.length > 0) {
        setState(() {
          _tabController =
              TabController(length: model.typeList.length, vsync: this)
                ..addListener(() {
                  setState(() {
                    currentTabIndex = _tabController.index;
                  });
                });
          getTypeList = model.typeList;
        });
      } else {
        LogUtils.printLog('数据为空！');
      }
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: getTypeList.length, vsync: this);
    _getVideoTypeList();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTab(item) {
    return Container(
      width: UIData.spaceSizeWidth110,
      child: Tab(text: item.typeName),
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
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            CommonText.mainTitle('Prime', color: UIData.hoverThemeBgColor),
            SizedBox(width: UIData.spaceSizeWidth8),
            CommonText.mainTitle('Video'),
          ],
        ),
      ),
      body: Column(children: [
        Container(
          padding: EdgeInsets.only(bottom: UIData.spaceSizeHeight16),
          color: UIData.themeBgColor,
          child: TabBar(
            controller: _tabController,
            padding: EdgeInsets.symmetric(horizontal: UIData.spaceSizeWidth16),
            labelStyle: TextStyle(fontSize: UIData.fontSize20),
            unselectedLabelStyle: TextStyle(fontSize: UIData.fontSize20),
            isScrollable: true,
            labelPadding: EdgeInsets.all(0),
            labelColor: UIData.hoverTextColor,
            unselectedLabelColor: UIData.primaryColor,
            indicatorWeight: 0.0,
            indicator: StubTabIndicator(color:UIData.hoverThemeBgColor),
            tabs: getTypeList.map((e) => _buildTab(e)).toList(),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children:
                getTypeList.map((e) => TabContent(typeId:e.typeId)).toList(),
          ),
        )
      ]),
    );
  }
}

