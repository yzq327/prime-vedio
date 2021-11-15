import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/ui/home/type_tab_bar.dart';
import 'package:primeVedio/utils/font_icon.dart';
import 'package:primeVedio/utils/ui_data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //设置为iphoneX的尺寸，设置字体大小根据系统的“字体大小”辅助选项来进行缩放
    ScreenUtil.instance =
        ScreenUtil(width: 375, height: 812, allowFontScaling: true)
          ..init(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CommonText.mainTitle('Prime', color: UIData.hoverThemeBgColor),
            SizedBox(width: UIData.spaceSizeWidth8),
            CommonText.mainTitle('Video'),
          ],
        ),
      ),
      body: Column(
        children: [
          TypeTabBar(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CommonText.mainTitle('Prime', color: UIData.hoverThemeBgColor),
              ],
            ),
          ),
        ],
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
          width: ScreenUtil.getInstance().setWidth(26),
          height: ScreenUtil.getInstance().setWidth(26),
          child: Container(
              padding: EdgeInsets.symmetric(vertical: UIData.spaceSizeHeight16),
              child: Icon(_getBottomNavigationList[index].icon,
                  color: _currentIndex == index
                      ? UIData.hoverThemeBgColor
                      : UIData.subTextColor))),
      label: '',
    );
  }
}

class _NavigationBarItem {
  IconData icon;
  _NavigationBarItem(this.icon);
}
