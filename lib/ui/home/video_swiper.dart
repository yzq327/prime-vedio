import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/models/video_list_model.dart';
import 'package:primeVedio/utils/ui_data.dart';

class VideoSwiper extends StatefulWidget{
  final List<VideoInfo> videoList;
  VideoSwiper({Key key, this.videoList}) : super(key: key);

  _VideoSwiperState createState()=> _VideoSwiperState();
}

class _VideoSwiperState extends State<VideoSwiper>{

  List<VideoInfo> get getVideoList => widget.videoList;

  @override
  void initState() {
    super.initState();
  }
  // //banner图片显示
  // Widget _buildImage({String imagePath, GestureTapCallback onTap}) {
  //   return Padding(
  //     padding:
  //     EdgeInsets.symmetric(horizontal: ScreenUtil().setSp(16)),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(ScreenUtil().setSp(4)),
  //       child: CommonImageWidget(imagePath,
  //           onTap: imagePath != null ? onTap : null, fit: BoxFit.fill, useDiskCache: true, transitionDuration: const Duration(milliseconds: 0)),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0,UIData.spaceSizeHeight16,0, UIData.spaceSizeHeight8),
      color: UIData.themeBgColor,
      height: UIData.spaceSizeHeight180,
      child: Column(
        children: [
          CommonText.normalTitle(getVideoList[0].vodName.toString()),
        ],
      ),
      // Swiper(
      //     autoplay: stateModel.bannerAutoPlay,
      //     autoplayDelay: 3000,
      //     duration: 300,
      //     loop: (stateModel.bannerList?.length ?? 1) > 1,
      //     itemBuilder: (BuildContext context, int index) {
      //       if (stateModel.bannerList == null ||
      //           stateModel.bannerList.length == 0) {
      //         return _buildImage();
      //       } else {
      //         BannerInfo bannerInfo = stateModel.bannerList[index];
      //         return _buildImage(
      //             imagePath: bannerInfo?.uuid,
      //             onTap: () {
      //               // Navigate.toNewPage(VideoDetailPage());
      //             });
      //       }
      //     },
      //     itemCount: stateModel.bannerList?.length ?? 1,
      //     pagination: _buildSwiperPagination()),
    );
  }
}
