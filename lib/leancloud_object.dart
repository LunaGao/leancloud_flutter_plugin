import 'dart:convert';

import 'package:leancloud_flutter_plugin/leancloud_flutter_plugin.dart';

class AVObject {

  String className;
  Map<String, dynamic> fields;

  AVObject(this.className);

  void put(String key, Object value) {
    if (fields == null) {
      fields = new Map();
    }
    fields.addAll({key: value});
  }

  dynamic get(String key) {
    return fields[key];
  }

  String toString() {
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

  void _addSystemFields(String objectString) {
    Map<String, Object> systemFields = jsonDecode(objectString);
    systemFields.forEach((key, value) {
      this.put(key, value);
    });
  }
}