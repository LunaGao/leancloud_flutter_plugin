import 'dart:async';

import 'package:flutter/services.dart';

class LeancloudFlutterPlugin {
  static const MethodChannel _channel =
      const MethodChannel('leancloud_flutter_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<void> initialize(String appId, String appKey) async {
    Map args = <String, dynamic>{
      'appId': appId,
      'appKey': appKey,
    };
    await _channel.invokeMethod('initialize', args);
  }

  //
  // Setup log level must be before call initialize function
  //
  // The call must be include args:
  //  level  --> OFF(0), ERROR(1), WARNING(2), INFO(3), DEBUG(4), VERBOSE(5), ALL(6);
  //
  static Future<void> setLogLevel(int level) async {
    Map args = <String, dynamic>{
      'level': level,
    };
    await _channel.invokeMethod('setLogLevel', args);
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
  static setRegion(int region) {
    Map args = <String, dynamic>{
      'region': region,
    };
    _channel.invokeMethod('setRegion', args);
  }

  static saveOrCreate() {
    _channel.invokeMethod('saveOrCreate');
  }

  static delete() {
    _channel.invokeMethod('delete');
  }
  static query() {
    _channel.invokeMethod('query');
  }
}
