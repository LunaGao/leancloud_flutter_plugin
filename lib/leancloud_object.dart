import 'dart:convert';

import 'package:leancloud_flutter_plugin/leancloud_flutter_plugin.dart';

class AVObject {

  String className;
  Map<String, dynamic> fields;

  AVObject(this.className);

  // this function will change className!
  AVObject fromQuery(String queriedString) {
    Map<String, Object> queriedFields = jsonDecode(queriedString);
    queriedFields.forEach((key, value) {
      if (key == "className") className = value;
      this.put(key, value);
    });
    return this;
  }

  void put(String key, Object value) {
    if (fields == null) {
      fields = new Map();
    }
    fields.addAll({key: value});
  }

  String getObjectId() {
    return fields["objectId"];
  }

  dynamic get(String key) {
    return fields[key];
  }

  String toString() {
    if (fields == null) {
      throw Exception("Empty field, before save or create, you must to add field!");
    }
    String fieldsString = jsonEncode(fields);
    Map<String, String> object = new Map();
    object.addAll({"className": className});
    object.addAll({"fields": fieldsString});
    return jsonEncode(object);
  }

  Future<AVObject> save() async {
    LeancloudFlutterPlugin leancloudFlutterPlugin = LeancloudFlutterPlugin.getInstance();
    String objectString = await leancloudFlutterPlugin.saveOrCreate(this);
    _addSystemFields(objectString);
    return this;
  }

  Future<bool> delete() async {
    LeancloudFlutterPlugin leancloudFlutterPlugin = LeancloudFlutterPlugin.getInstance();
    bool isDeleted = await leancloudFlutterPlugin.delete(this);
    return isDeleted;
  }

  void _addSystemFields(String objectString) {
    Map<String, Object> systemFields = jsonDecode(objectString);
    systemFields.forEach((key, value) {
      this.put(key, value);
    });
  }
}