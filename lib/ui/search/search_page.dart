import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:primeVedio/commom/commom_text.dart';
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
            TextField(
              controller: _userEtController,
              maxLength: 16,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(UIData.spaceSizeHeight6), //边角为30
                    ),
                ),
                onChanged: (value) => setState(() {
                  searchValue = value.trim();
                }),
                contentPadding: EdgeInsets.all(UIData.spaceSizeWidth8),
                hintStyle: TextStyle(color: UIData.textDefaultColor),
                filled: true,
                fillColor: UIData.primaryColor,
                hintText: "请输入关键字搜索",
                suffixIcon: searchValue.isNotEmpty
                    ? IconButton(
                        icon: Icon(IconFont.icon_closefill,
                            color: UIData.subTextColor,
                            size: UIData.spaceSizeWidth20),
                        onPressed: () => setState(() {
                          searchValue = '';
                          _userEtController.text = '';
                        }),
                      )
                    : SizedBox(),
              ),
            ),
            CommonText.mainTitle('SearchPage', color: UIData.subThemeBgColor),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
