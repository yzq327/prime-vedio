import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/ui/home/video_detail_page.dart';
import 'package:primeVedio/utils/routes.dart';
import 'package:primeVedio/utils/ui_data.dart';

import 'commom_image.dart';

class CommonImgDisplay extends StatelessWidget{
  final String vodPic;
  final int vodId;
  final String vodName;
  final bool? recordRoute;

  CommonImgDisplay({required this.vodPic, required this.vodId, required this.vodName, this.recordRoute = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(UIData.spaceSizeWidth12),
        child: CommonImg(vodPic: vodPic),
      ),
      onTap: () {
        if(recordRoute == true) {
          Navigator.pushNamed(context, Routes.detail, arguments: VideoDetailPageParams(vodId: vodId, vodName: vodName, vodPic: vodPic));
        } else {
          Navigator.pushReplacementNamed(context, Routes.detail, arguments: VideoDetailPageParams(vodId: vodId, vodName: vodName));
        }
      },
    );
  }
}
