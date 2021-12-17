import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/utils/ui_data.dart';

import 'commom_slider.dart';

class CommonBasicSlider extends StatefulWidget {
  final double currentValue;
  final ValueChanged<double> onChange;
  final Color? activeColor;
  final Color? inactiveColor;
  final double overlayRadius;
  final double enabledThumbRadius;
  final double trackHeight;
  final int quarterTurns;

  CommonBasicSlider(
      {Key? key,
      required this.currentValue,
      required this.onChange,
      this.activeColor,
      this.inactiveColor,
      this.overlayRadius = 4,
      this.enabledThumbRadius = 4,
      this.trackHeight = 4,
      this.quarterTurns = 3})
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
      quarterTurns: widget.quarterTurns,
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackHeight: widget.trackHeight,
          trackShape: FullWidthTrackShape(), // 轨道形状，可以自定义
          thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: widget.enabledThumbRadius),
          overlayShape: RoundSliderOverlayShape(
            overlayRadius: widget.overlayRadius,
          ),
        ),
        child: Slider(
          value: widget.currentValue,
          activeColor: widget.activeColor ?? UIData.primaryColor,
          inactiveColor: widget.inactiveColor ?? UIData.videoStateDefaultColor,
          onChanged: widget.onChange,
        ),
      ),
    );
  }
}
