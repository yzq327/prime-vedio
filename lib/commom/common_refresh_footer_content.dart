import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/utils/ui_data.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'commom_text.dart';

class CommonRefreshFooterContent extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
      Widget body;
      String text;
      if (mode == LoadStatus.loading) {
        body = CircularProgressIndicator(
            strokeWidth: 2.0, color: UIData.hoverThemeBgColor);
      } else {
        if (mode == LoadStatus.idle) {
          text = '上拉加载更多';
        } else if (mode == LoadStatus.failed) {
          text = '加载失败！点击重试！';
        } else if (mode == LoadStatus.canLoading) {
          text = '松手即可加载更多!';
        } else {
          text = '没有更多数据了!';
        }
        body = CommonText.normalText(text, color: UIData.subThemeBgColor);
      }
      return Container(
        height: UIData.spaceSizeHeight60,
        child: body,
      );
    },
    );
  }
}
