import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/commom/common_dialog.dart';
import 'package:primeVedio/commom/common_hint_text_contain.dart';
import 'package:primeVedio/commom/common_page_header.dart';
import 'package:primeVedio/commom/common_removableItem.dart';
import 'package:primeVedio/commom/common_toast.dart';
import 'package:primeVedio/models/common/common_model.dart';
import 'package:primeVedio/table/db_util.dart';
import 'package:primeVedio/table/table_init.dart';
import 'package:primeVedio/utils/commom_srting_helper.dart';
import 'package:primeVedio/utils/font_icon.dart';
import 'package:primeVedio/utils/routes.dart';
import 'package:primeVedio/utils/ui_data.dart';

import 'collection_detail_page.dart';
import 'create_collect_dialog.dart';

class MyCollectionPage extends StatefulWidget {
  @override
  _MyCollectionPageState createState() => _MyCollectionPageState();
}

class _MyCollectionPageState extends State<MyCollectionPage> {
  late DBUtil dbUtil;
  List<MyCollectionItem> myCollectionsList = [];
  static List<GlobalKey<CommonRemovableItemState>> childItemStates = [];
  List<int> collectedVideoNumbers = [];
  TextEditingController _userEtController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _userEtController.addListener(() {
      setState(() {});
    });
    initDB();
  }

  @override
  void dispose() {
    _userEtController.dispose();
    super.dispose();
  }

  void initChildItemStates() {
    childItemStates.clear();
    for (int i = 0; i < myCollectionsList.length; i++) {
      GlobalKey<CommonRemovableItemState> removeGK =
          GlobalKey(debugLabel: "$i");
      childItemStates.add(removeGK);
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

  void initDB() async {
    TablesInit tables = TablesInit();
    tables.init();
    dbUtil = new DBUtil();
    queryData();
  }

  queryData() async {
    await dbUtil.open();
    List<Map> data = await dbUtil
        .queryList("SELECT * FROM my_collections ORDER By create_time DESC");
    setState(() {
      myCollectionsList =
          data.map((i) => MyCollectionItem.fromJson(i)).toList();
    });
    initVideoNumbers();
    initChildItemStates();
    await dbUtil.close();
  }

  void insertData() async {
    if(_userEtController.text.trim() == '') {
      CommonToast.show(
          context: context,
          message: "创建失败，不能输入空的文件夹名",
          color: UIData.failBgColor,
          icon: IconFont.icon_shibai);
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
            color: UIData.failBgColor,
            icon: IconFont.icon_shibai);
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
      queryData();
    }
  }

  void delete(int collectId) async {
    await dbUtil.open();
    dbUtil.delete('DELETE FROM my_collections WHERE id = ?', [collectId]);
    CommonToast.show(context: context, message: "删除成功");
    queryData();
    await dbUtil.close();
  }

  static void closeItems(
      List<GlobalKey<CommonRemovableItemState>> childItemStates, int index) {
    childItemStates.forEach((element) {
      if (element != childItemStates[index]) {
        element.currentState?.closeItems();
      }
    });
  }

  Widget _buildPageHeader() {
    return CommonPageHeader(
      pageTitle: '我收藏的',
      rightIcon: IconFont.icon_jia,
      onRightTop: () {
        CommonDialog.showAlertDialog(
          context,
          title: '新建收藏夹',
          positiveBtnText: '创建',
          onConfirm: insertData,
          onCancel: () => _userEtController.text = '',
          content: CreateCollectDialog(
            userEtController: _userEtController,
            handleClear: () => _userEtController.text = '',
          ),
        );
      },
    );
  }

  Widget _buildCollectionDetail(int index) {
    return CommonRemovableItem(
      moveItemKey: childItemStates[index],
      onActionDown: () => closeItems(childItemStates, index),
      onNavigator: () {
        Navigator.pushNamed(context, Routes.mineCollectionDetail,
            arguments: CollectionDetailPageParams(
                collectName: myCollectionsList[index].collectName,
                collectId: myCollectionsList[index].collectId));
      },
      onDelete: () {
        CommonDialog.showAlertDialog(context,
            title: '提示',
            content: '确定要删除《${myCollectionsList[index].collectName}》吗？',
            onCancel: () => childItemStates[index].currentState!.closeItems(),
            onConfirm: () => delete(myCollectionsList[index].collectId));
      },
      height: UIData.spaceSizeHeight80,
      child: Container(
        color: UIData.themeBgColor,
        width: double.infinity,
        height: UIData.spaceSizeHeight80,
        padding: EdgeInsets.symmetric(
          horizontal: UIData.spaceSizeWidth20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: UIData.spaceSizeHeight80,
                width: UIData.spaceSizeWidth100,
                child: Image.asset(
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
                  CommonText.text18("共 ${collectedVideoNumbers[index]} 部",
                      color: UIData.subTextColor),
                ],
              ),
            ),
            Icon(IconFont.icon_you, color: UIData.primaryColor)
          ],
        ),
      ),
    );
  }

  Widget _buildCollections() {
    return myCollectionsList.length == 0
        ? CommonHintTextContain(text: '暂无收藏夹哦，创建一个吧')
        : Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: myCollectionsList.length,
              itemBuilder: (context, index) {
                return _buildCollectionDetail(index);
              },
            ),
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
          _buildCollections(),
        ],
      ),
    );
  }
}
