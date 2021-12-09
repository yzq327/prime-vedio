import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/commom/commom_text.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIData.themeBgColor,
      appBar: AppBar(
        elevation: 0,
        title: CommonText.mainTitle(widget.collectionDetailPageParams.collectName),
      ),
      body: Container(),
    );
  }
}
