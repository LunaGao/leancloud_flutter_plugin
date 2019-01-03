
import 'dart:convert';

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

  String toString() {
    String fieldsString = jsonEncode(fields);
    Map<String, String> object = new Map();
    object.addAll({"className": className});
    object.addAll({"fields": fieldsString});
    return jsonEncode(object);
  }
}