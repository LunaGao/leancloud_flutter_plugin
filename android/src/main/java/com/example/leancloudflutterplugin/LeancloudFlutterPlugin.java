package com.example.leancloudflutterplugin;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** LeancloudFlutterPlugin */
public class LeancloudFlutterPlugin implements MethodCallHandler {
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "leancloud_flutter_plugin");
    channel.setMethodCallHandler(new LeancloudFlutterPlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    switch (call.method) {
      case "getPlatformVersion":
        result.success("Android " + android.os.Build.VERSION.RELEASE);
        break;
      case "initialize":
        LeancloudFunction.initialize(call, result);
        break;
      case "setLogLevel":
        LeancloudFunction.setLogLevel(call, result);
        break;
      case "setRegion":
        LeancloudFunction.setRegion(call, result);
        break;
      case "saveOrCreate":
        LeancloudObject.saveOrCreate(call, result);
        break;
      case "delete":
        LeancloudObject.delete(call, result);
        break;
      case "query":
        LeancloudQuery.query(call, result);
        break;
      default:
        result.notImplemented();
    }
  }
}
