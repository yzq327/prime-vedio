import 'package:app_installer/app_installer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/commom/common_dialog.dart';
import 'package:primeVedio/http/http_options.dart';
import 'package:primeVedio/http/http_util.dart';
import 'package:primeVedio/models/video_type_list_model.dart';
import 'package:primeVedio/models/video_version_model.dart';
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
  late VideoVersionModel videoVersionModel;
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

  _getVideoVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    HttpUtil.request(HttpOptions.versionUrl, HttpUtil.GET).then((value) {
      setState(() {
        videoVersionModel = VideoVersionModel.fromJson(value);
      });
      if (packageInfo.version != videoVersionModel.version ||
          packageInfo.buildNumber != videoVersionModel.buildNumber) {
        CommonDialog.showAlertDialog(
          context,
          title: '发现新版本！',
          positiveBtnText: '立即升级',
          onConfirm: _getVideoApk,
          content: Padding(
            padding: EdgeInsets.symmetric(vertical: UIData.spaceSizeHeight8, horizontal: UIData.spaceSizeWidth16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.text18(
                    '版本号: ${videoVersionModel.version} + ${videoVersionModel.buildNumber}',color: UIData.blackColor),
                CommonText.text18(
                    '更新内容:',color: UIData.blackColor),
                Column(
                  children: videoVersionModel.content
                      .asMap()
                      .keys
                      .map((index) => CommonText.text18(
                      '  ${index + 1}.  ${videoVersionModel.content[index]}',color: UIData.blackColor))
                      .toList(),
                )
              ],
            ),
          ),
        );
      }
    });
  }

  _getVideoApk()  {
    HttpUtil.request(HttpOptions.apkUrl, HttpUtil.DOWNLOAD).then((value) {
      AppInstaller.installApk('assets/app-armeabi-v7a-release.apk');
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: getTypeList.length, vsync: this);
    _getVideoTypeList();
    _getVideoVersion();
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
      backgroundColor: UIData.themeBgColor,
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
            indicator: StubTabIndicator(color: UIData.hoverThemeBgColor),
            tabs: getTypeList.map((e) => _buildTab(e)).toList(),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children:
                getTypeList.map((e) => TabContent(typeId: e.typeId)).toList(),
          ),
        )
      ]),
    );
  }
}
