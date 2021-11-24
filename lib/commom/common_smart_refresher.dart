import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'common_refresh_footer_content.dart';
import 'common_refresh_header_content.dart';

class CommonSmartRefresher extends StatefulWidget {
  late final Widget? child;
  late final Widget? header;
  late final Widget? footer;
  late final bool enablePullUp;
  late final bool enablePullDown;
  late final VoidCallback? onRefresh;
  late final VoidCallback? onLoading;
  late final RefreshController controller;

  CommonSmartRefresher({Key? key, this.child,
    this.header ,
    this.footer,
    this.enablePullUp = false,
    this.enablePullDown = true,
    this.onRefresh,
    this.onLoading,
    required this.controller})
      : super(key: key);

  _CommonSmartRefresherState createState() => _CommonSmartRefresherState();

}
class _CommonSmartRefresherState extends State<CommonSmartRefresher> {

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
    return  SmartRefresher(
        enablePullDown: widget.enablePullDown,
        enablePullUp: widget.enablePullUp,
        header: widget.header ?? CommonRefreshHeaderContent(),
        footer: widget.footer ?? CommonRefreshFooterContent(),
        controller: widget.controller,
        onRefresh: widget.onRefresh,
        onLoading: widget.onLoading,
        child: widget.child);
  }
}
