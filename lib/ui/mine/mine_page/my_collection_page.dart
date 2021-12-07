import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/commom/common_dialog.dart';
import 'package:primeVedio/commom/common_hint_text_contain.dart';
import 'package:primeVedio/commom/common_removableItem.dart';
import 'package:primeVedio/models/common/common_model.dart';
import 'package:primeVedio/table/db_util.dart';
import 'package:primeVedio/table/table_init.dart';
import 'package:primeVedio/utils/font_icon.dart';
import 'package:primeVedio/utils/ui_data.dart';

class MyCollectionPage extends StatefulWidget {
  @override
  _MyCollectionPageState createState() => _MyCollectionPageState();
}

class _MyCollectionPageState extends State<MyCollectionPage> {
  late DBUtil dbUtil;
  List<MyCollectionItem> myCollectionsList = [];
  static List<GlobalKey<CommonRemovableItemState>> childItemStates = [];
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

  void initDB() async {
    TablesInit tables = TablesInit();
    tables.init();
    dbUtil = new DBUtil();
    queryData();
  }

  queryData() async {
    await dbUtil.open();
    await dbUtil.close();
  }

  void delete(int collectId) async {
    await dbUtil.open();
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
    return Padding(
      padding: EdgeInsets.only(
          top: UIData.spaceSizeHeight50,
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
                  content: Container(
                    margin: EdgeInsets.only(
                      top: UIData.spaceSizeHeight16,
                      left: UIData.spaceSizeWidth32,
                      right: UIData.spaceSizeWidth32,
                    ),
                    child: TextField(
                      controller: _userEtController,
                      maxLength: 30,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (value) {
                        _userEtController.text = '';
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: UIData.spaceSizeWidth8, vertical: UIData.spaceSizeWidth4),
                        hintStyle: TextStyle(color: UIData.textDefaultColor),
                        filled: true,
                        fillColor: UIData.inputBgColor,
                        hintText: "请输入收藏夹名称",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(
                            Radius.circular(UIData.spaceSizeHeight6), //边角为30
                          ),
                        ),
                        suffixIcon: _userEtController.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(IconFont.icon_closefill,
                                    color: UIData.subTextColor,
                                    size: UIData.spaceSizeWidth20),
                                onPressed: () => _userEtController.text = '',
                              )
                            : SizedBox(),
                      ),
                    ),
                  ),
                  onConfirm: () {});
            },
            child: Icon(IconFont.icon_jia, color: UIData.primaryColor),
          )
        ],
      ),
    );
  }

  Widget _buildCollectionDetail(int index) {
    return CommonRemovableItem(
      moveItemKey: childItemStates[index],
      onActionDown: () => closeItems(childItemStates, index),
      onNavigator: () {
        // Navigator.pushNamed(context, Routes.detail,
        //     arguments: VideoDetailPageParams(
        //         vodId: videoHistoryList[index].vodId,
        //         vodName: videoHistoryList[index].vodName,
        //         vodPic: videoHistoryList[index].vodPic,
        //         watchedDuration: videoHistoryList[index].watchedDuration));
      },
      onDelete: () {},
      child: Container(
        color: UIData.themeBgColor,
        width: double.infinity,
        margin: EdgeInsets.only(
          left: UIData.spaceSizeWidth20,
          bottom: UIData.spaceSizeHeight16,
        ),
        padding: EdgeInsets.only(
          right: UIData.spaceSizeHeight16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: UIData.spaceSizeHeight80,
                width: UIData.spaceSizeWidth100,
                child: Image.asset(myCollectionsList[index].img)),
            SizedBox(width: UIData.spaceSizeWidth18),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText.text18(myCollectionsList[index].collectName),
                  CommonText.text18(
                      "共 ${myCollectionsList[index].totalVideos} 部",
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
