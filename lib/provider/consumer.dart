// 这是一个便捷类，会获得当前context和指定数据类型的Provider
import 'package:flutter/cupertino.dart';

import 'change_notifier_provider.dart';

class Consumer<T> extends StatelessWidget {
  Consumer({
    Key key,
    this.builder,
  }) : super(key: key);

  final Widget Function(BuildContext context, T value) builder;

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      ChangeNotifierProvider.of<T>(context),
    );
  }
}