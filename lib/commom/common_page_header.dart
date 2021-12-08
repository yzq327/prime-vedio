import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/utils/ui_data.dart';

import 'commom_text.dart';

class CommonPageHeader extends StatefulWidget {
  final String pageTitle;
  final IconData rightIcon;
  final VoidCallback onRightTop;

  CommonPageHeader(
      {required this.pageTitle,
      required this.rightIcon,
      required this.onRightTop});

  @override
  _CommonPageHeaderState createState() => _CommonPageHeaderState();
}

class _CommonPageHeaderState extends State<CommonPageHeader> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: UIData.spaceSizeHeight50,
          bottom: UIData.spaceSizeWidth24,
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
          CommonText.text18(widget.pageTitle),
          GestureDetector(
            onTap: () {
              widget.onRightTop();
            },
            child: Icon(widget.rightIcon, color: UIData.primaryColor),
          )
        ],
      ),
    );
  }
}
