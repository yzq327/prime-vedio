import 'package:flutter/cupertino.dart';

class NavigateOption {
  static getParams(BuildContext context) {
   return ModalRoute.of(context).settings.arguments;
  }
}
