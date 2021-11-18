import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/utils/constant.dart';
import 'package:primeVedio/utils/ui_data.dart';

class CommonImgDisplay extends StatelessWidget{

  final String url;
  CommonImgDisplay(this.url);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(UIData.spaceSizeWidth12),
        child: Image(
            image: CachedNetworkImageProvider(url),
            alignment: Alignment.topCenter,
            fit: BoxFit.cover),
      ),
      onTap: () {
        Navigator.pushNamed(context, Constant.detail);
      },
    );
  }
}
