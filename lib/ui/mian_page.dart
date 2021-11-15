import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/ui/home/type_tab_bar.dart';
import 'package:primeVedio/ui/mine/mine_page/mine_page.dart';
import 'package:primeVedio/ui/search/search_page.dart';
import 'package:primeVedio/utils/constant.dart';
import 'package:primeVedio/utils/font_icon.dart';
import 'package:primeVedio/utils/ui_data.dart';

import 'home/home_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
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
      appBar: null,
      body: IndexedStack(
        index: _currentIndex,
        children: _buildIndexedStack(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: UIData.themeBgColor,
        elevation: 0.0,
        iconSize: UIData.fontSize26,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: _getBottomNavigationList
            .asMap()
            .keys
            .map((index) => _buildBottomNavigationBarItem(index))
            .toList(),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<_NavigationBarItem> get _getBottomNavigationList {
    return [
      _NavigationBarItem(IconFont.icon_home_fill),
      _NavigationBarItem(IconFont.icon_search),
      _NavigationBarItem(IconFont.icon_wode_F),
    ];
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(index) {
    return BottomNavigationBarItem(
      icon: SizedBox(
          width: ScreenUtil().setWidth(26),
          height: ScreenUtil().setWidth(26),
          child: Container(
              padding: EdgeInsets.symmetric(vertical: UIData.spaceSizeHeight16),
              child: Icon(_getBottomNavigationList[index].icon,
                  color: _currentIndex == index
                      ? UIData.hoverThemeBgColor
                      : UIData.subTextColor))),
      label: '',
    );
  }

  List<Widget> _buildIndexedStack() {
    return <Widget>[
      HomePage(),
      SearchPage(),
      MinePage()
    ];
  }
}

class _NavigationBarItem {
  IconData icon;
  _NavigationBarItem(this.icon);
}
