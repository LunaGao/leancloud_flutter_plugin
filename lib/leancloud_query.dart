import 'dart:convert';

import 'package:leancloud_flutter_plugin/leancloud_flutter_plugin.dart';
import 'package:leancloud_flutter_plugin/leancloud_object.dart';

class AVQuery {

  /// private property for Class Name
  var _className;
  /// private property for query conditions
  var _queries = [];

  /// CQL query
  static Future<List<AVObject>> doCloudQuery(String cql) async {
    var leancloudFlutterPlugin = LeancloudFlutterPlugin.getInstance();
    var objectsString = await leancloudFlutterPlugin.doCloudQuery(cql);
    var objectsJson = jsonDecode(objectsString);
    List<AVObject> lists = [];
    for (var objectString in objectsJson["objects"]) {
      AVObject object = new AVObject("");
      object.fromQuery(objectString);
      lists.add(object);
    }
    return lists;
  }

  /// Create an AVQuery with Class Name
  AVQuery(this._className);

  /// Overwritten toString() function, to return this object's JSON string.
  String toString() {
    var queriesString = jsonEncode(this._queries);
    var object = <String, String>{};
    object.addAll({"className": _className});
    object.addAll({"queries": queriesString});
    return jsonEncode(object);
  }

  /// Get an AVObject object by object Id
  Future<AVObject> get(String objectId) async {
    _setQueriesValue("get", objectId, null);
    var leancloudFlutterPlugin = LeancloudFlutterPlugin.getInstance();
    var objectString = await leancloudFlutterPlugin.query(this);
    var object = new AVObject("");
    object.fromQuery(objectString);
    return object;
  }

  /// Find AVObjects with all conditions
  Future<List<AVObject>> find() async {
    var leancloudFlutterPlugin = LeancloudFlutterPlugin.getInstance();
    var objectsString = await leancloudFlutterPlugin.query(this);
    var objectsJson = jsonDecode(objectsString);
    List<AVObject> lists = [];
    for (var objectString in objectsJson["objects"]) {
      AVObject object = new AVObject("");
      object.fromQuery(objectString);
      lists.add(object);
    }
    return lists;
  }

  /// set query result limit count
  AVQuery limit(int limit) {
    _setQueriesValue("limit", limit, null);
    return this;
  }

  /// set query result by ascending
  AVQuery orderByAscending(String key) {
    _setQueriesValue("orderByAscending", key, null);
    return this;
  }

  /// set query result by descending
  AVQuery orderByDescending(String key) {
    _setQueriesValue("orderByDescending", key, null);
    return this;
  }

  /// set query order by [key] column ascending
  AVQuery addAscendingOrder(String key) {
    _setQueriesValue("addAscendingOrder", key, null);
    return this;
  }

  /// set query order by [key] column descending
  AVQuery addDescendingOrder(String key) {
    _setQueriesValue("addDescendingOrder", key, null);
    return this;
  }

  /// set query result skip count
  AVQuery skip(int skip) {
    _setQueriesValue("skip", skip, null);
    return this;
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
    var queryClass = <String, String>{};
    queryClass.addAll({"queryMethod": queryMethod});
    queryClass.addAll({"arg1": arg1});
    if (arg2 != null) {
      queryClass.addAll({"arg2": arg2});
    }
    this._queries.add(queryClass);
  }
}