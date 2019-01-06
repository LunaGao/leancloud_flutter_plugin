import 'dart:convert';

import 'package:leancloud_flutter_plugin/leancloud_flutter_plugin.dart';

class AVQuery<T> {

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

  Future<T> get(String objectId) async {
    if (queries == null) {
      queries = new Map();
    }
    queries.addAll({"get": objectId});
    LeancloudFlutterPlugin leancloudFlutterPlugin = LeancloudFlutterPlugin.getInstance();
    T object = await leancloudFlutterPlugin.query(this);
    return object;
  }

}