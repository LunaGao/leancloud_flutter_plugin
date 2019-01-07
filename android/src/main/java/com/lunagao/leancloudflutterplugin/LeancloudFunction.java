package com.lunagao.leancloudflutterplugin;

import android.content.Context;

import cn.leancloud.AVLogger;
import cn.leancloud.AVOSCloud;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

class LeancloudFunction {

    /**
     * initialize function
     *
     * The call must be include args:
     *  appId
     *  appKey
     *
     * @param call MethodCall from LeancloudFlutterPlugin.onMethodCall function
     * @param result MethodChannel.Result from LeancloudFlutterPlugin.onMethodCall function
     */
    static void initialize(MethodCall call, MethodChannel.Result result, Context context) {
        String appId = LeancloudArgsConverter.getStringValue(call, result, "appId");
        String appKey = LeancloudArgsConverter.getStringValue(call, result, "appKey");
        AVOSCloud.initialize(context, appId, appKey);
    }

    /**
     * Setup log level must be before call initialize function
     *
     * The call must be include args:
     *  level  --> OFF(0), ERROR(1), WARNING(2), INFO(3), DEBUG(4), VERBOSE(5), ALL(6);
     *
     * @param call MethodCall from LeancloudFlutterPlugin.onMethodCall function
     * @param result MethodChannel.Result from LeancloudFlutterPlugin.onMethodCall function
     */
    static void setLogLevel(MethodCall call, MethodChannel.Result result) {
        int level_int = LeancloudArgsConverter.getIntValue(call, result, "level");
        AVLogger.Level level = AVLogger.Level.OFF;
        switch (level_int) {
            case 0:
                // already assigned to this value
                break;
            case 1:
                level = AVLogger.Level.ERROR;
                break;
            case 2:
                level = AVLogger.Level.WARNING;
                break;
            case 3:
                level = AVLogger.Level.INFO;
                break;
            case 4:
                level = AVLogger.Level.DEBUG;
                break;
            case 5:
                level = AVLogger.Level.VERBOSE;
                break;
            case 6:
                level = AVLogger.Level.ALL;
                break;
            default:
                break;
        }
        AVOSCloud.setLogLevel(level);
    }

    /**
     * Setup region must be before call initialize function
     *
     * The call must be include args:
     *  region  --> NorthChina(0), EastChina(1), NorthAmerica(2)
     *      REGION.NorthChina - this is default value
     *      REGION.EastChina
     *      REGION.NorthAmerica
     *
     * @param call MethodCall from LeancloudFlutterPlugin.onMethodCall function
     * @param result MethodChannel.Result from LeancloudFlutterPlugin.onMethodCall function
     */
    static void setRegion(MethodCall call, MethodChannel.Result result) {
        int region_int = LeancloudArgsConverter.getIntValue(call, result, "region");
        AVOSCloud.REGION region = AVOSCloud.REGION.NorthChina;
        switch (region_int) {
            case 0:
                // already assigned to this value
                break;
            case 1:
                region = AVOSCloud.REGION.EastChina;
                break;
            case 2:
                region = AVOSCloud.REGION.NorthAmerica;
                break;
        }
        AVOSCloud.setRegion(region);
    }
}
