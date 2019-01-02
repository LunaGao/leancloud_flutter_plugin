import 'package:flutter/material.dart';

import 'package:leancloud_flutter_plugin/leancloud_flutter_plugin.dart';
import 'package:leancloud_flutter_plugin_example/list_screen.dart';

void main() {
  initPlatformState();
  runApp(MyApp());
}

void initPlatformState() async {
  String appId = "";
  String appKey = "";
  await LeancloudFlutterPlugin.setLogLevel(6);
  await LeancloudFlutterPlugin.initialize(appId, appKey);
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
