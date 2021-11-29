import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/utils/ui_data.dart';


class CommonImg extends StatelessWidget {
  final String vodPic;

  CommonImg({required this.vodPic});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: vodPic,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (content, url) => SizedBox(
        width: UIData.spaceSizeHeight50,
        height: UIData.spaceSizeHeight50,
        child: Center(
          child: CircularProgressIndicator(
                  strokeWidth: 2.0, color: UIData.primaryColor),
        ),
      ),
      errorWidget: (context, url, error) => Image.asset(UIData.defaultImg),
    );
  }
}
