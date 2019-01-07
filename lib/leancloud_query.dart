import 'dart:convert';

import 'package:leancloud_flutter_plugin/leancloud_flutter_plugin.dart';
import 'package:leancloud_flutter_plugin/leancloud_object.dart';

class AVQuery {

  String className;
  List<Map<String, dynamic>> queries;

  AVQuery(this.className) {
    queries = new List();
  }

  String toString() {
    String queriesString = jsonEncode(queries);
    Map<String, String> object = new Map();
    object.addAll({"className": className});
    object.addAll({"queries": queriesString});
    return jsonEncode(object);
  }

  Future<AVObject> get(String objectId) async {
    _setQueriesValue("get", objectId, null);
    LeancloudFlutterPlugin leancloudFlutterPlugin = LeancloudFlutterPlugin.getInstance();
    String objectString = await leancloudFlutterPlugin.query(this);
    AVObject object = new AVObject("");
    object.fromQuery(objectString);
    return object;
  }

  Future<List<AVObject>> find() async {
    LeancloudFlutterPlugin leancloudFlutterPlugin = LeancloudFlutterPlugin.getInstance();
    String objectsString = await leancloudFlutterPlugin.query(this);
    Map<String, Object> objectsJson = jsonDecode(objectsString);
    List<AVObject> lists = new List();
    //TODO
    for (String objectString in objectsJson["objects"]) {
      AVObject object = new AVObject("");
      object.fromQuery(objectString);
      lists.add(object);
    }
    return lists;
  }

  AVQuery whereEqualTo(String key, dynamic value) {
    _setQueriesValue("equalTo", key, value);
    return this;
  }

  AVQuery whereNotEqualTo(String key, dynamic value) {
    _setQueriesValue("notEqualTo", key, value);
    return this;
  }

  AVQuery whereGreaterThan(String key, dynamic value) {
    _setQueriesValue("greaterThan", key, value);
    return this;
  }

  AVQuery whereGreaterThanOrEqualTo(String key, dynamic value) {
    _setQueriesValue("greaterThanOrEqualTo", key, value);
    return this;
  }

  AVQuery whereLessThan(String key, dynamic value) {
    _setQueriesValue("lessThan", key, value);
    return this;
  }

  AVQuery whereLessThanOrEqualTo(String key, dynamic value) {
    _setQueriesValue("lessThanOrEqualTo", key, value);
    return this;
  }

  _setQueriesValue(String queryMethod, dynamic arg1, dynamic arg2) {
    Map<String, String> queryClass = new Map();
    queryClass.addAll({"queryMethod": queryMethod});
    queryClass.addAll({"arg1": arg1});
    if (arg2 != null) {
      queryClass.addAll({"arg2": arg2});
    }
    queries.add(queryClass);
  }
}