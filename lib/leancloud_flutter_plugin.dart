import 'dart:async';

import 'package:flutter/services.dart';

import 'package:leancloud_flutter_plugin/leancloud_object.dart';
import 'package:leancloud_flutter_plugin/leancloud_query.dart';

/// Leancloud flutter Plugin
class LeancloudFlutterPlugin {

  /// method channel
  static const MethodChannel _channel =
      const MethodChannel('leancloud_flutter_plugin');

  /// Singleton property
  static LeancloudFlutterPlugin _instancePlugin = new LeancloudFlutterPlugin();

  /// Get plugin instance
  static LeancloudFlutterPlugin getInstance() {
    return _instancePlugin;
  }

  var _logLevel = 0;

  /// Initialize the Native SDK
  void initialize(String appId, String appKey) {
    var args = <String, dynamic>{
      'appId': appId,
      'appKey': appKey,
    };
    _channel.invokeMethod('initialize', args);
  }

  /// Setup log level must be before called initialize function
  /// The call must be include args:
  ///  [level]  --> OFF(0), ERROR(1), WARNING(2), INFO(3), DEBUG(4), VERBOSE(5), ALL(6);
  void setLogLevel(LeancloudLoggerLevel level) {
    switch (level) {
      case LeancloudLoggerLevel.OFF:
        this._logLevel = 0;
        break;
      case LeancloudLoggerLevel.ERROR:
        this._logLevel = 1;
        break;
      case LeancloudLoggerLevel.WARNING:
        this._logLevel = 2;
        break;
      case LeancloudLoggerLevel.INFO:
        this._logLevel = 3;
        break;
      case LeancloudLoggerLevel.DEBUG:
        this._logLevel = 4;
        break;
      case LeancloudLoggerLevel.VERBOSE:
        this._logLevel = 5;
        break;
      case LeancloudLoggerLevel.ALL:
        this._logLevel = 6;
        break;
    }
    var args = <String, dynamic>{
      'level': this._logLevel,
    };
    _channel.invokeMethod('setLogLevel', args);
  }

  /// Setup region must be before called initialize function
  /// The call must be include args:
  ///  [region]  --> NorthChina(0), EastChina(1), NorthAmerica(2)
  ///      REGION.NorthChina - this is default value
  ///      REGION.EastChina
  ///      REGION.NorthAmerica
  void setRegion(LeancloudCloudRegion region) {
    int regionValue;
    switch (region) {
      case LeancloudCloudRegion.NorthChina:
        regionValue = 0;
        break;
      case LeancloudCloudRegion.EastChina:
        regionValue = 1;
        break;
      case LeancloudCloudRegion.NorthAmerica:
        regionValue = 2;
        break;
    }
    var args = <String, dynamic>{
      'region': regionValue,
    };
    _channel.invokeMethod('setRegion', args);
  }

  /// Save AVObject.
  /// Usually suggest using AVObject.save() function instead of this.
  Future<String> saveOrCreate(AVObject object) async {
    var args = <String, dynamic>{'avObject': object.toString()};
    var objectString = await _channel.invokeMethod('saveOrCreate', args);
    if (this._logLevel != 0) {
      print("[saveOrCreate function] -> " + objectString);
    }
    return objectString;
  }

  /// Delete object
  /// Usually suggest using AVObject.delete() function instead of this.
  Future<bool> delete(AVObject object) async {
    var args = <String, dynamic>{'avObject': object.toString()};
    return await _channel.invokeMethod('delete', args);
  }

  /// Query object(s)
  /// Usually suggest using AVQuery instead of this.
  Future<dynamic> query(AVQuery query) async {
    var args = <String, dynamic>{'avQuery': query.toString()};
    return await _channel.invokeMethod('query', args);
  }

  /// Using CQL Query object(s)
  /// Usually suggest using AVQuery instead of this.
  Future<dynamic> doCloudQuery(String cql) async {
    var args = <String, String>{'cql': cql};
    return await _channel.invokeMethod('doCloudQuery', args);
  }

  /// Get current User
  Future<String> currentUser() async {
    var currentUserJson = await _channel.invokeMethod('currentUser');
    return currentUserJson;
  }
}

/// Leancloud logger level
/// iOS only have ON or OFF. So when you set OFF, it's OFF. When you set another logger level, it's ON.
enum LeancloudLoggerLevel { OFF, ERROR, WARNING, INFO, DEBUG, VERBOSE, ALL }

/// Leancloud Region
/// iOS not have this property
enum LeancloudCloudRegion { NorthChina, EastChina, NorthAmerica }
