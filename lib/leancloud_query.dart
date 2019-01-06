import 'dart:convert';

import 'package:leancloud_flutter_plugin/leancloud_flutter_plugin.dart';
import 'package:leancloud_flutter_plugin/leancloud_object.dart';

class AVQuery {

  String className;

  AVQuery(this.className);
  Map<String, dynamic> queries;

  String toString() {
    String fieldsString = jsonEncode(queries);
    Map<String, String> object = new Map();
    object.addAll({"className": className});
    object.addAll({"queries": fieldsString});
    return jsonEncode(object);
  }

  Future<AVObject> get(String objectId) async {
    if (queries == null) {
      queries = new Map();
    }
    queries.addAll({"get": objectId});
    LeancloudFlutterPlugin leancloudFlutterPlugin = LeancloudFlutterPlugin.getInstance();
    String objectString = await leancloudFlutterPlugin.query(this);
    AVObject object = new AVObject("");
    object.fromQuery(objectString);
    return object;
  }

}