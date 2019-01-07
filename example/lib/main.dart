import 'package:flutter/material.dart';

import 'package:leancloud_flutter_plugin/leancloud_flutter_plugin.dart';
import 'list_screen.dart';

void main() {
  initPlatformState();
  runApp(MyApp());
}

void initPlatformState() {
  LeancloudFlutterPlugin leancloudFlutterPlugin = LeancloudFlutterPlugin.getInstance();
  String appId = "YOUR_APP_ID";
  String appKey = "YOUR_APP_KEY";
  leancloudFlutterPlugin.setLogLevel(LeancloudLoggerLevel.DEBUG);
  leancloudFlutterPlugin.setRegion(LeancloudCloudRegion.NorthChina);
  leancloudFlutterPlugin.initialize(appId, appKey);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leancloud Plugin example app',
      home: ListScreen(),
    );
  }
}
