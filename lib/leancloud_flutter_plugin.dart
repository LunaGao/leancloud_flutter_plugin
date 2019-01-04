import 'dart:async';

import 'package:flutter/services.dart';

import 'package:leancloud_flutter_plugin/leancloud_object.dart';

class LeancloudFlutterPlugin {
  static const MethodChannel _channel =
      const MethodChannel('leancloud_flutter_plugin');

  static LeancloudFlutterPlugin _instancePlugin = new LeancloudFlutterPlugin();

  static LeancloudFlutterPlugin getInstance() {
    return _instancePlugin;
  }

  int logLevel = 0;

  void initialize(String appId, String appKey) {
    Map args = <String, dynamic>{
      'appId': appId,
      'appKey': appKey,
    };
    _channel.invokeMethod('initialize', args);
  }

  //
  // Setup log level must be before call initialize function
  //
  // The call must be include args:
  //  level  --> OFF(0), ERROR(1), WARNING(2), INFO(3), DEBUG(4), VERBOSE(5), ALL(6);
  //
  void setLogLevel(LeancloudLoggerLevel level) {
    switch (level) {
      case LeancloudLoggerLevel.OFF:
        this.logLevel = 0;
        break;
      case LeancloudLoggerLevel.ERROR:
        this.logLevel = 1;
        break;
      case LeancloudLoggerLevel.WARNING:
        this.logLevel = 2;
        break;
      case LeancloudLoggerLevel.INFO:
        this.logLevel = 3;
        break;
      case LeancloudLoggerLevel.DEBUG:
        this.logLevel = 4;
        break;
      case LeancloudLoggerLevel.VERBOSE:
        this.logLevel = 5;
        break;
      case LeancloudLoggerLevel.ALL:
        this.logLevel = 6;
        break;
    }
    Map args = <String, dynamic>{
      'level': this.logLevel,
    };
    _channel.invokeMethod('setLogLevel', args);
  }

  //
  // Setup region must be before call initialize function
  //
  // The call must be include args:
  //  region  --> NorthChina(0), EastChina(1), NorthAmerica(2)
  //      REGION.NorthChina - this is default value
  //      REGION.EastChina
  //      REGION.NorthAmerica
  //
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
    Map args = <String, dynamic>{
      'region': regionValue,
    };
    _channel.invokeMethod('setRegion', args);
  }

  //
  // save object
  //
  Future<String> saveOrCreate(AVObject object) async {
    Map args = <String, dynamic>{'avObject': object.toString()};
    String objectString = await _channel.invokeMethod('saveOrCreate', args);
    if (this.logLevel != 0) {
      print("[saveOrCreate function] -> " + objectString);
    }
    return objectString;
  }

  static delete() {
    _channel.invokeMethod('delete');
  }

  static query() {
    _channel.invokeMethod('query');
  }
}


enum LeancloudLoggerLevel { OFF, ERROR, WARNING, INFO, DEBUG, VERBOSE, ALL }

enum LeancloudCloudRegion { NorthChina, EastChina, NorthAmerica }
