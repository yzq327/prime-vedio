import 'package:flutter/cupertino.dart';
class CurrentTypeModel extends ChangeNotifier {
  int currentTypeId = 1;

  CurrentTypeModel(this.currentTypeId);

  void changeType(int value) {
    this.currentTypeId = value;
    notifyListeners();
  }
}