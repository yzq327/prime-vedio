import 'package:flutter/material.dart';
import 'package:primeVedio/utils/ui_data.dart';

import 'commom_text.dart';

class CommonDialog {
  static Widget? showAlertDialog(
    BuildContext context, {
    Key? key,
    barrierDismissible = false,
    onConfirm,
    onCancel,
    String? title,
    var contentPadding,
    var content,
    double? contentFontSize,
    String positiveBtnText = '确认',
    Color? positiveBtnColor,
    String negativeBtnText = '取消',
    bool showNegativeBtn = true,
    bool showPositiveBtn = true,
    bool willPop = true,
    bool onTapCloseDialog = true,
    Function? onDismiss,
  }) {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (BuildContext context) {
          return WillPopScope(
              child: SimpleDialog(
                key: key,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                contentPadding: contentPadding ??
                    EdgeInsets.only(top: UIData.spaceSizeWidth16),
                children: <Widget>[
                  Offstage(
                      offstage: title == null,
                      child: Container(
                        margin: EdgeInsets.only(top: UIData.spaceSizeHeight12),
                        child: CommonText.mainTitle(title,
                            color: UIData.blackColor),
                      )),
                  Offstage(
                      offstage: content == null,
                      child: content is String
                          ? Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: UIData.spaceSizeWidth20),
                              margin: EdgeInsets.symmetric(
                                  vertical: UIData.spaceSizeWidth16),
                              child: CommonText.text18(content,
                                  textAlign: TextAlign.center,
                                  color: UIData.blackColor),
                            )
                          : content),
                  Offstage(
                      offstage: !showPositiveBtn && !showNegativeBtn,
                      child: Container(
                        margin: EdgeInsets.only(top: UIData.spaceSizeWidth16),
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: UIData.phTextColor, width: 0.5))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Visibility(
                                visible: showPositiveBtn,
                                child: Expanded(
                                  child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      child: Container(
                                        height: UIData.spaceSizeHeight44,
                                        alignment: Alignment.center,
                                        child: CommonText.text18(
                                            positiveBtnText,
                                            color: positiveBtnColor ??
                                                UIData.blackColor),
                                      ),
                                      onTap: () {
                                        if (onTapCloseDialog)
                                          Navigator.pop(context);
                                        if (onConfirm != null) onConfirm();
                                      }),
                                )),
                            Visibility(
                              visible: showNegativeBtn && showPositiveBtn,
                              child: Container(
                                width: 1.0,
                                height: UIData.spaceSizeHeight44,
                                color: UIData.phTextColor,
                              ),
                            ),
                            Visibility(
                                visible: showNegativeBtn,
                                child: Expanded(
                                  child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      child: Container(
                                        height: UIData.spaceSizeHeight44,
                                        alignment: Alignment.center,
                                        child: CommonText.text18(
                                            negativeBtnText,
                                            color: positiveBtnColor ??
                                                UIData.subTextColor),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        if (onCancel != null) onCancel();
                                      }),
                                )),
                          ],
                        ),
                      )),
                ],
              ),
              onWillPop: () async {
                return Future.value(willPop);
              });
        }).then((data) {
      if (onDismiss != null) onDismiss();
    });
    return null;
  }
}
