import 'package:flutter/material.dart';
import 'package:primeVedio/utils/ui_data.dart';

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double circleWidth = UIData.spaceSizeWidth20;
    Path path = Path();
    path.moveTo(0, circleWidth * 2);
    path.lineTo(0, size.height - circleWidth);
    path.quadraticBezierTo(0, size.height, circleWidth, size.height);
    path.lineTo(size.width - circleWidth, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - circleWidth);
    path.lineTo(size.width, circleWidth * 2);
    path.quadraticBezierTo(
        size.width, circleWidth, size.width - circleWidth, circleWidth);
    path.lineTo(size.width / 2, 0);
    path.lineTo(circleWidth, circleWidth);
    path.quadraticBezierTo(0, circleWidth, 0, circleWidth * 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper old) => false;
}

// https://gist.github.com/coman3/e631fd55cd9cdf9bd4efe8ecfdbb85a7
@immutable
class ClipShadowPath extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<Path> clipper;
  final Widget child;

  ClipShadowPath({
    required this.shadow,
    required this.clipper,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      key: UniqueKey(),
      painter: _ClipShadowShadowPainter(
        clipper: this.clipper,
        shadow: this.shadow,
      ),
      child: ClipPath(child: child, clipper: this.clipper),
    );
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({required this.shadow, required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
