import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/utils/font_icon.dart';
import 'package:primeVedio/utils/ui_data.dart';

class CommonToast {
  static void show({
    required BuildContext context,
    required String message,
    Color? color,
    IconData? icon,
  }) {
    OverlayEntry overlayEntry = new OverlayEntry(builder: (context) {
      return new Positioned(
          top: MediaQuery.of(context).size.height * 0.7,
          child: new Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  new Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        vertical: UIData.spaceSizeHeight10,
                        horizontal: UIData.spaceSizeWidth24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(UIData.spaceSizeWidth20),
                      color: color ?? UIData.successBgColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icon ?? IconFont.icon_chenggong,
                          color: UIData.primaryColor,
                          // size: UIData.spaceSizeWidth30,
                        ),
                        SizedBox(
                          width: UIData.spaceSizeWidth14,
                        ),
                        CommonText.text16(message),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
    });
    Overlay.of(context)!.insert(overlayEntry);
    new Future.delayed(Duration(seconds: 2)).then((value) {
      overlayEntry.remove();
    });
  }
}
