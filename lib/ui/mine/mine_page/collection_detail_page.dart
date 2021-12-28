import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/commom/commom_image.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/commom/common_dialog.dart';
import 'package:primeVedio/commom/common_hint_text_contain.dart';
import 'package:primeVedio/commom/common_img_display.dart';
import 'package:primeVedio/commom/common_toast.dart';
import 'package:primeVedio/models/common/common_model.dart';
import 'package:primeVedio/table/db_util.dart';
import 'package:primeVedio/table/table_init.dart';
import 'package:primeVedio/utils/constants.dart';
import 'package:primeVedio/utils/ui_data.dart';

class CollectionDetailPageParams {
  final int collectId;
  final String collectName;

  CollectionDetailPageParams({
    required this.collectId,
    required this.collectName,
  });
}

class CollectionDetailPage extends StatefulWidget {
  final CollectionDetailPageParams collectionDetailPageParams;

  CollectionDetailPage({Key? key, required this.collectionDetailPageParams})
      : super(key: key);
  @override
  _CollectionDetailPageState createState() => _CollectionDetailPageState();
}

class _CollectionDetailPageState extends State<CollectionDetailPage>
    with TickerProviderStateMixin {
  List<CollectVideoDetail> collectVideoDetailList = [];
  late DBUtil dbUtil;

  @override
  void initState() {
    super.initState();
    initDB();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initDB() async {
    TablesInit tables = TablesInit();
    tables.init();
    dbUtil = new DBUtil();
    queryData();
  }

  void queryData() async {
    await dbUtil.open();
    List<Map> data = await dbUtil.queryList(
        "SELECT * FROM collection_detail where collect_id = ${widget.collectionDetailPageParams.collectId} ORDER By create_time DESC");
    setState(() {
      collectVideoDetailList =
          data.map((i) => CollectVideoDetail.fromJson(i)).toList();
    });
    await dbUtil.close();
  }

  void setCollectionSurfacePlot(String vodPic) async {
    await dbUtil.open();
    await dbUtil.update('UPDATE my_collections SET img = ? WHERE id = ?',
        [vodPic, widget.collectionDetailPageParams.collectId]);
    CommonToast.show(
      context: context,
      message: "设置成功",
      type: ToastType.success,
    );
    await dbUtil.close();
  }

  Widget _buildVideoInfo(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onLongPress: () {
            CommonDialog.showAlertDialog(
              context,
              title: '设为封面',
              positiveBtnText: '设置为封面',
              onConfirm: () {
                setCollectionSurfacePlot(
                    collectVideoDetailList[index].vodPic);
              },
              content: Container(
                  margin: EdgeInsets.symmetric(
                      vertical: UIData.spaceSizeHeight16,
                      horizontal: UIData.spaceSizeWidth50),
                  width: UIData.spaceSizeWidth160,
                  height: UIData.spaceSizeHeight200,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(UIData.spaceSizeWidth12),
                    child:
                        CommonImg(vodPic: collectVideoDetailList[index].vodPic),
                  )),
            );
          },
          child: Container(
            width: UIData.spaceSizeWidth160,
            height: UIData.spaceSizeHeight200,
            child: CommonImgDisplay(
                vodPic: collectVideoDetailList[index].vodPic,
                vodId: collectVideoDetailList[index].vodId,
                vodName: collectVideoDetailList[index].vodName),
          ),
        ),
        Container(
            width: UIData.spaceSizeWidth160,
            alignment: Alignment.topLeft,
            margin: EdgeInsets.symmetric(vertical: UIData.spaceSizeHeight8),
            child: CommonText.normalText(collectVideoDetailList[index].vodName,
                color: UIData.mainTextColor)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIData.themeBgColor,
      appBar: AppBar(
        elevation: 0,
        title:
            CommonText.mainTitle(widget.collectionDetailPageParams.collectName),
      ),
      body: collectVideoDetailList.length == 0
          ? CommonHintTextContain(text: '收藏夹暂无内容哦，去收藏影片吧')
          : Padding(
            padding: EdgeInsets.symmetric(horizontal: UIData.spaceSizeWidth16),
            child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  mainAxisSpacing: UIData.spaceSizeHeight8,
                  crossAxisSpacing: UIData.spaceSizeWidth16,
                ),
                itemCount: collectVideoDetailList.length,
                itemBuilder: (BuildContext context, int index) =>
                    _buildVideoInfo(index),
              ),
          ),
    );
  }
}
