package com.lunagao.leancloudflutterplugin;

import android.content.Context;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** LeancloudFlutterPlugin */
public class LeancloudFlutterPlugin implements MethodCallHandler {

  private static Context _applicationContext;

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "leancloud_flutter_plugin");
    channel.setMethodCallHandler(new LeancloudFlutterPlugin());
    _applicationContext = registrar.context().getApplicationContext();
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    switch (call.method) {
      case "initialize":
        LeancloudFunction.initialize(call, result, _applicationContext);
        break;
      case "setLogLevel":
        LeancloudFunction.setLogLevel(call, result);
        break;
      case "setRegion":
        LeancloudFunction.setRegion(call, result);
        break;
      case "saveOrCreate":
        LeancloudObject saveOrCreateObject = new LeancloudObject();
        saveOrCreateObject.saveOrCreate(call, result);
        break;
      case "delete":
        LeancloudObject deleteObject = new LeancloudObject();
        deleteObject.delete(call, result);
        break;
      case "query":
        LeancloudQuery leancloudQuery = new LeancloudQuery();
        leancloudQuery.query(call, result);
        break;
      case "doCloudQuery":
        LeancloudQuery doCloudQueryQuery = new LeancloudQuery();
        doCloudQueryQuery.doCloudQuery(call, result);
        break;
      default:
        result.notImplemented();
    }
  }
}
