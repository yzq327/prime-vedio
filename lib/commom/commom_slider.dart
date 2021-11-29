import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/utils/commom_srting_helper.dart';
import 'package:primeVedio/utils/ui_data.dart';

class FullWidthTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight!) / 2;
    // 让轨道宽度等于 Slider 宽度
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class CommonSlider extends StatefulWidget {
  late final Duration position;
  late final  Duration duration;
  final ValueChanged<double> onChangeEnd;

  CommonSlider({Key? key, required this.position, required this.duration, required this.onChangeEnd})
      : super(key: key);

  _CommonSliderState createState() => _CommonSliderState();
}

class _CommonSliderState extends State<CommonSlider> {
  bool isChangeSlider = false;
  late double tempDuration;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CommonSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  RotatedBox(
      quarterTurns: 4,
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackHeight: UIData.spaceSizeHeight4,
          trackShape:
          FullWidthTrackShape(), // 轨道形状，可以自定义
          thumbShape: RoundSliderThumbShape(
              enabledThumbRadius:
              UIData.spaceSizeWidth6),
          overlayShape: RoundSliderOverlayShape(
            overlayRadius: UIData.spaceSizeWidth16,
          ),
        ),
        child: Slider(
          value: isChangeSlider
              ? tempDuration
              : widget.position.inSeconds.toDouble(),
          min: 0,
          max: widget.duration.inSeconds.toDouble(),
          divisions: widget.duration.inSeconds,
          activeColor: UIData.primaryColor,
          inactiveColor: UIData.videoStateDefaultColor,
          label: isChangeSlider
              ? '${StringsHelper.formatDuration(Duration(seconds: tempDuration.toInt()))}'
              : '${StringsHelper.formatDuration(widget.position)}',
          onChangeStart: (double value) {
            setState(() {
              tempDuration = value;
              isChangeSlider = true;
            });
          },
          onChangeEnd: (double value) {
            widget.onChangeEnd(value);
            setState(() {
              tempDuration = value;
              isChangeSlider = false;
            });
          },
          onChanged: (double value) {
            setState(() {
              tempDuration = value;
            });
          },
        ),
      ),
    );

  }
}
