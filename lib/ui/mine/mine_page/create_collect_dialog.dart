import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/utils/font_icon.dart';
import 'package:primeVedio/utils/ui_data.dart';

class CreateCollectDialog extends StatefulWidget {
  final TextEditingController userEtController;
  final VoidCallback handleClear;
  CreateCollectDialog(
      {required this.userEtController, required this.handleClear});

  @override
  _CreateCollectDialogState createState() => _CreateCollectDialogState();
}

class _CreateCollectDialogState extends State<CreateCollectDialog> {
  String inputValue = '';

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
    return Container(
      margin: EdgeInsets.only(
        top: UIData.spaceSizeHeight16,
        left: UIData.spaceSizeWidth32,
        right: UIData.spaceSizeWidth32,
      ),
      child: TextField(
        controller: widget.userEtController,
        maxLength: 20,
        textInputAction: TextInputAction.next,
        onSubmitted: (value) {},
        onChanged: (value) {
          setState(() {
            inputValue = value;
          });
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: UIData.spaceSizeWidth8,
              vertical: UIData.spaceSizeWidth4),
          hintStyle: TextStyle(color: UIData.textDefaultColor),
          filled: true,
          fillColor: UIData.inputBgColor,
          hintText: "请输入收藏夹名称",
          border: OutlineInputBorder(
            borderSide: BorderSide.none, //
            borderRadius: BorderRadius.all(
              Radius.circular(UIData.spaceSizeHeight6), //边角为30
            ),
          ),
          suffixIcon: inputValue.isEmpty
              ? null
              : IconButton(
                  icon: Icon(IconFont.icon_closefill,
                      color: UIData.subTextColor,
                      size: UIData.spaceSizeWidth20),
                  onPressed: () {
                    widget.handleClear();
                    setState(() {
                      inputValue = '';
                    });
                  }),
        ),
      ),
    );
  }
}
