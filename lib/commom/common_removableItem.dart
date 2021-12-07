import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/utils/font_icon.dart';
import 'package:primeVedio/utils/ui_data.dart';

class CommonRemovableItem extends StatefulWidget {
  final GlobalKey<CommonRemovableItemState> moveItemKey;
  final VoidCallback onActionDown;
  final VoidCallback onNavigator;
  final VoidCallback onDelete;
  final Widget child;
  CommonRemovableItem({
    Key? key,
    required this.moveItemKey,
    required this.onActionDown,
    required this.onNavigator,
    required this.onDelete,
    required this.child,
  }) : super(key: moveItemKey);

  @override
  CommonRemovableItemState createState() => CommonRemovableItemState();
}

class CommonRemovableItemState extends State<CommonRemovableItem>
    with SingleTickerProviderStateMixin {

  late AnimationController slideController;
  double offset = 0.0;
  double maxDis = UIData.spaceSizeWidth120;
  bool opened = false;
  double moveDis = 0.0;

  @override
  void initState() {
    slideController = AnimationController(
        lowerBound: 0,
        upperBound: maxDis,
        duration: const Duration(seconds: 1),
        vsync: this)
      ..addListener(() {
        offset = slideController.value;
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    if (slideController != null) {
      slideController.dispose();
    }
    super.dispose();
  }

  void closeItems() {
    slideController.animateTo(0.0);
    opened = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onNavigator(),
      onHorizontalDragDown: (DragDownDetails dragDownDetails) {
        closeItems();
        return widget.onActionDown();
      },
      onHorizontalDragUpdate: (DragUpdateDetails dragUpdateDetails) {
        setState(() {
          offset -= dragUpdateDetails.delta.dx;
          if (offset < 0) {
            offset = 0;
          }
          if (offset >= maxDis) {
            offset = maxDis;
          }
        });
      },
      onHorizontalDragEnd: (DragEndDetails dragEndDetails) {
        slideController.value = offset;
        if (offset >= maxDis) {
          opened = true;
        } else if (offset > maxDis / 2) {
          opened = true;
          slideController.animateTo(maxDis);
        } else {
          closeItems();
        }
      },
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                slideController.animateTo(maxDis);
                widget.onDelete();
              },
              child: Container(
                alignment: Alignment.center,
                width: UIData.spaceSizeWidth110,
                height: UIData.spaceSizeWidth90,
                margin: EdgeInsets.only(
                  top: UIData.spaceSizeWidth20,
                  bottom: UIData.spaceSizeHeight16,
                  right: UIData.spaceSizeWidth20,
                ),
                color: Colors.red,
                child: Icon(
                  IconFont.icon_shanchutianchong,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: UIData.spaceSizeHeight16,
            left: -offset,
            right: offset,
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
