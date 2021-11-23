import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/commom/common_dialog.dart';
import 'package:primeVedio/utils/font_icon.dart';
import 'package:primeVedio/utils/ui_data.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _userEtController = TextEditingController();
  String searchValue = '';

  @override
  void initState() {
    super.initState();
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText.mainTitle('历史搜索', color: UIData.hoverThemeBgColor),
        IconButton(
            onPressed: () {
              CommonDialog.showAlertDialog(context,
                  title: '提示', content: '确定要清空历史搜索记录吗？', onConfirm: () {});
            },
            icon: Icon(
              IconFont.icon_clear_l,
              color: UIData.primaryColor,
            ))
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
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
