import 'dart:convert';

import 'package:leancloud_flutter_plugin/leancloud_flutter_plugin.dart';
import 'package:leancloud_flutter_plugin/leancloud_object.dart';

class AVQuery {

  /// private property for Class Name
  String _className;
  /// private property for query conditions
  List<Map<String, dynamic>> _queries;

  /// Create an AVQuery with Class Name
  AVQuery(this._className) {
    this._queries = new List();
  }

  /// Overwritten toString() function, to return this object's JSON string.
  String toString() {
    String queriesString = jsonEncode(this._queries);
    Map<String, String> object = new Map();
    object.addAll({"className": _className});
    object.addAll({"queries": queriesString});
    return jsonEncode(object);
  }

  /// Get an AVObject object by object Id
  Future<AVObject> get(String objectId) async {
    _setQueriesValue("get", objectId, null);
    LeancloudFlutterPlugin leancloudFlutterPlugin = LeancloudFlutterPlugin.getInstance();
    String objectString = await leancloudFlutterPlugin.query(this);
    AVObject object = new AVObject("");
    object.fromQuery(objectString);
    return object;
  }

  /// Find AVObjects with all conditions
  Future<List<AVObject>> find() async {
    LeancloudFlutterPlugin leancloudFlutterPlugin = LeancloudFlutterPlugin.getInstance();
    String objectsString = await leancloudFlutterPlugin.query(this);
    Map<String, Object> objectsJson = jsonDecode(objectsString);
    List<AVObject> lists = new List();
    for (String objectString in objectsJson["objects"]) {
      AVObject object = new AVObject("");
      object.fromQuery(objectString);
      lists.add(object);
    }
    return lists;
  }

  /// Set equal to condition
  AVQuery whereEqualTo(String key, dynamic value) {
    _setQueriesValue("equalTo", key, value);
    return this;
  }

  /// Set not equal to condition
  AVQuery whereNotEqualTo(String key, dynamic value) {
    _setQueriesValue("notEqualTo", key, value);
    return this;
  }

  /// Set greater than condition
  AVQuery whereGreaterThan(String key, dynamic value) {
    _setQueriesValue("greaterThan", key, value);
    return this;
  }

  /// Set greater than or equal to condition
  AVQuery whereGreaterThanOrEqualTo(String key, dynamic value) {
    _setQueriesValue("greaterThanOrEqualTo", key, value);
    return this;
  }

  /// Set less than condition
  AVQuery whereLessThan(String key, dynamic value) {
    _setQueriesValue("lessThan", key, value);
    return this;
  }

  /// Set where less than or equal to condition
  AVQuery whereLessThanOrEqualTo(String key, dynamic value) {
    _setQueriesValue("lessThanOrEqualTo", key, value);
    return this;
  }

  /// Private function, set conditions json value
  _setQueriesValue(String queryMethod, dynamic arg1, dynamic arg2) {
    Map<String, String> queryClass = new Map();
    queryClass.addAll({"queryMethod": queryMethod});
    queryClass.addAll({"arg1": arg1});
    if (arg2 != null) {
      queryClass.addAll({"arg2": arg2});
    }
    this._queries.add(queryClass);
  }
}