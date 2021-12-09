import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:primeVedio/commom/commom_text.dart';
import 'package:primeVedio/utils/ui_data.dart';

class AboutUsPage extends StatefulWidget {
  AboutUsPage({Key? key}) : super(key: key);
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  String appName =  '';
  String version = '';
  String buildNumber = '';

  void getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  void initState() {
    super.initState();
    getPackageInfo();
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
        title: CommonText.mainTitle('关于我们'),
      ),
      body: Container(
          alignment: Alignment.center,
        padding: EdgeInsets.all(UIData.spaceSizeWidth32),
        child: Column(
          children: [
            CommonText.text24(appName),
            CommonText.text24('$version + $buildNumber'),
            SizedBox(height: UIData.spaceSizeHeight32),
            CommonText.text14('本软件仅供学习交流 \n 如有雷同，纯属克隆'),
          ],
        ),
      ),
    );
  }
}
