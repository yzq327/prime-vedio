import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/utils/ui_data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentIndex = 0;

  void _onItemTapped (int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      appBar: AppBar(
        title:
        Row(
          children: [
            CommonText.mainTitle('Prime', color: UIData.hoverThemeBgColor),
            SizedBox(width: UIData.spaceSizeWidth8),
            CommonText.mainTitle('Video'),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times11:',
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: UIData.themeBgColor,
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: _getBottomNavigationList.asMap().keys.map((index) => _buildBottomNavigationBarItem(index)).toList(),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<_NavigationBarItem> get _getBottomNavigationList {
    return [
      _NavigationBarItem('首页', Image.asset(UIData.iconHomeNormal), Image.asset(UIData.iconHomeSelected)),
      _NavigationBarItem('搜索', Image.asset(UIData.iconSearchNormal), Image.asset(UIData.iconSearchSelected)),
      _NavigationBarItem('我的', Image.asset(UIData.iconMimeNormal), Image.asset(UIData.iconMimeNormal)),
    ];
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(index) {
    return BottomNavigationBarItem(
        icon: SizedBox(
        width: ScreenUtil.getInstance().setWidth(96),
        height: ScreenUtil.getInstance().setWidth(96),
        child: _currentIndex == index
                ? _getBottomNavigationList[index].selectedIcon
                : _getBottomNavigationList[index].normalIcon,
        ),
        title: Text(_getBottomNavigationList[index].title),
    );
  }
}

class _NavigationBarItem {
  String title;
  Widget normalIcon;
  Widget selectedIcon;
  _NavigationBarItem(this.title, this.normalIcon, selectedIcon);
}
