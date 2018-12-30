package com.example.leancloudflutterplugin;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

class LeancloudArgsConverter {
    static String getStringValue(MethodCall call, MethodChannel.Result result, String key) {
        Object arg = call.argument(key);
        if (arg == null) {
            result.error("Arg '" + key + "' can't be null, set empty value. PLEASE FIX IT!", null, null);
            return "";
        } else {
            return arg.toString();
        }
    }

    static int getIntValue(MethodCall call, MethodChannel.Result result, String key) {
        Object arg = call.argument(key);
        if (arg == null) {
            result.error("Arg '" + key + "' can't be null, set 0 value. PLEASE FIX IT!", null, null);
            return 0;
        } else {
            return (int)arg;
        }
    }
}
