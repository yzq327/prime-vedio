import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/utils/ui_data.dart';

class CollectionDetailPage extends StatefulWidget {
  CollectionDetailPage({Key? key}) : super(key: key);
  @override
  _CollectionDetailPageState createState() => _CollectionDetailPageState();
}

class _CollectionDetailPageState extends State<CollectionDetailPage> {

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
        title: CommonText.mainTitle('默认收藏夹'),
      ),
      body: Container(

      ),
    );
  }
}
