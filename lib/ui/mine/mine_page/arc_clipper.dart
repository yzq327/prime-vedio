import 'package:flutter/material.dart';
import 'package:primeVedio/utils/ui_data.dart';

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = UIData.spaceSizeHeight60;
    Path path = Path();
    path.moveTo(0, height);
    path.quadraticBezierTo(size.width / 2, 0, size.width, height);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper old) => false;
}
