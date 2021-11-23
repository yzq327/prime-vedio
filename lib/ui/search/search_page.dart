import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/commom/common_dialog.dart';
import 'package:primeVedio/table/db_util.dart';
import 'package:primeVedio/utils/font_icon.dart';
import 'package:primeVedio/utils/ui_data.dart';
import 'package:primeVedio/table/table_init.dart';

class SearchDBItem {
  int id;
  String content;
  SearchDBItem({required this.id, required this.content});

  factory SearchDBItem.fromJson(Map<dynamic, dynamic> parsedJson) {
    return SearchDBItem(id: parsedJson['id'], content: parsedJson['content']);
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _userEtController = TextEditingController();
  String searchValue = '';

  List<SearchDBItem> dataList = [];
  late DBUtil dbUtil;

  @override
  void initState() {
    super.initState();
    initDB();
  }

  void initDB() async {
    TablesInit tables = TablesInit();
    tables.init();
    dbUtil = new DBUtil();
    queryData();
  }

  void insertData() async {
    await dbUtil.open();
    Map<String, Object> par = Map<String, Object>();
    par['content'] = 'test-search-value';
    await dbUtil.insertByHelper('search', par);
    await dbUtil.close();
    queryData();
  }

  void queryData() async {
    await dbUtil.open();
    List<Map> data = await dbUtil.queryList("SELECT * FROM search");
    setState(() {
      dataList = data.map((i) => SearchDBItem.fromJson(i)).toList();
    });
    print('dataList******：$dataList');
    await dbUtil.close();
  }

  void delete() async {
    await dbUtil.open();
    dbUtil.delete('DELETE FROM search', null);
    await dbUtil.close();
    queryData();
  }

  Widget _buildSearchTextField() {
    return TextField(
      controller: _userEtController,
      maxLength: 16,
      textInputAction: TextInputAction.search,
      onChanged: (value) => setState(() {
        searchValue = value.trim();
      }),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(UIData.spaceSizeWidth8),
        hintStyle: TextStyle(color: UIData.textDefaultColor),
        filled: true,
        fillColor: UIData.primaryColor,
        hintText: "请输入关键字搜索",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(UIData.spaceSizeHeight6), //边角为30
          ),
        ),
        suffixIcon: searchValue.isNotEmpty
            ? IconButton(
                icon: Icon(IconFont.icon_closefill,
                    color: UIData.subTextColor, size: UIData.spaceSizeWidth20),
                onPressed: () => setState(() {
                  searchValue = '';
                  _userEtController.text = '';
                }),
              )
            : SizedBox(),
      ),
    );
  }

  Widget _buildSearchHistory() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText.mainTitle('历史搜索', color: UIData.hoverThemeBgColor),
            IconButton(
                onPressed: () {
                  CommonDialog.showAlertDialog(context,
                      title: '提示', content: '确定要清空历史搜索记录吗？', onConfirm: () {
                    delete();
                  });
                },
                icon: Icon(
                  IconFont.icon_clear_l,
                  color: UIData.primaryColor,
                ))
          ],
        ),
        dataList.length > 0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: dataList
                    .map((e) => Container(
                          decoration: BoxDecoration(
                            color: UIData.primaryColor,
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: UIData.spaceSizeHeight10,
                              horizontal: UIData.spaceSizeWidth24),
                          child: CommonText.text18(e.content,
                              color: UIData.blackColor),
                        ))
                    .toList(),
              )
            : Container(
                height: UIData.spaceSizeHeight60,
                alignment: Alignment.center,
                child: CommonText.normalText('没有历史搜索记录',
                    color: UIData.subThemeBgColor),
              ),
      ],
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
          preferredSize: Size.fromHeight(UIData.spaceSizeHeight16)),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: UIData.spaceSizeHeight24),
        child: Column(
          children: <Widget>[
            _buildSearchTextField(),
            _buildSearchHistory(),
          ],
        ),
      ),
    );
  }
}
