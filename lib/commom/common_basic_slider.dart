import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/utils/ui_data.dart';

import 'commom_slider.dart';

class CommonBasicSlider extends StatefulWidget {
  final double currentValue;
  final ValueChanged<double> onChange;

  CommonBasicSlider({Key? key, required this.currentValue, required this.onChange})
      : super(key: key);

  _CommonBasicSliderState createState() => _CommonBasicSliderState();
}

class _CommonBasicSliderState extends State<CommonBasicSlider> {
  bool isChangeSlider = false;
  late double tempDuration;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CommonBasicSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
        quarterTurns: 3,
        child: SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: UIData.spaceSizeHeight4,
            trackShape:
            FullWidthTrackShape(), // 轨道形状，可以自定义
            thumbShape: RoundSliderThumbShape(
                enabledThumbRadius:
                UIData.spaceSizeWidth4),
            overlayShape: RoundSliderOverlayShape(
              overlayRadius: UIData.spaceSizeWidth4,
            ),
          ),
          child: Slider(
            value: widget.currentValue,
            activeColor: UIData.primaryColor,
            inactiveColor: UIData.videoStateDefaultColor,
            onChanged: widget.onChange,
          ),
        ),
      );

  }
}
