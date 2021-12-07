import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/utils/ui_data.dart';

class CommonRemovableItem extends StatefulWidget {
  final Key? moveItemKey;
  final VoidCallback onActionDown;
  final VoidCallback onNavigator;
  final Widget? child;
  CommonRemovableItem({
    Key? key,
    this.moveItemKey,
    required this.onActionDown,
    required this.onNavigator,
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
      onTap: () {
       widget.onNavigator();
      },
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
          //滑动到最大距离一半时，执行动画，至打开item
          opened = true;
          slideController.animateTo(maxDis);
        } else {
          closeItems();
        }
      },
      child: widget.child,
    );
  }
}
