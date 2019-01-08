import 'dart:convert';

import 'package:leancloud_flutter_plugin/leancloud_flutter_plugin.dart';

class AVObject {

  /// private property for Class Name
  String _className;
  /// private property for Class Fields
  Map<String, dynamic> _fields;

  /// Create an AVObject with Class Name
  AVObject(this._className);

  /// Never call this function manually.
  /// This function used for AVQuery. It's convert from string to AVObject.
  AVObject fromQuery(String queriedString) {
    Map<String, Object> queriedFields = jsonDecode(queriedString);
    queriedFields.forEach((key, value) {
      if (key == "className") this._className = value;
      this.put(key, value);
    });
    return this;
  }

  /// Add or Update field value with [value] into this Object by [key]
  void put(String key, Object value) {
    if (this._fields == null) {
      this._fields = new Map();
    }
    this._fields.addAll({key: value});
  }

  /// Get this Object Id
  String getObjectId() {
    return this._fields["objectId"];
  }

  /// Get [key] field value
  dynamic get(String key) {
    return this._fields[key];
  }

  /// Overwritten toString() function, to return this object's JSON string.
  String toString() {
    if (this._fields == null) {
      throw Exception("Empty field, before save or create, you must to add field!");
    }
    String fieldsString = jsonEncode(this._fields);
    Map<String, String> object = new Map();
    object.addAll({"className": this._className});
    object.addAll({"fields": fieldsString});
    return jsonEncode(object);
  }

  /// Save or Update this object to leancloud database
  Future<AVObject> save() async {
    LeancloudFlutterPlugin leancloudFlutterPlugin = LeancloudFlutterPlugin.getInstance();
    String objectString = await leancloudFlutterPlugin.saveOrCreate(this);
    _addSystemFields(objectString);
    return this;
  }

  /// Delete this object from leancloud database
  /// But this object value will still in memory, until you manually set this object to null.
  Future<bool> delete() async {
    LeancloudFlutterPlugin leancloudFlutterPlugin = LeancloudFlutterPlugin.getInstance();
    bool isDeleted = await leancloudFlutterPlugin.delete(this);
    return isDeleted;
  }

  /// add system fields into this object.
  void _addSystemFields(String objectString) {
    Map<String, Object> systemFields = jsonDecode(objectString);
    systemFields.forEach((key, value) {
      this.put(key, value);
    });
  }
}