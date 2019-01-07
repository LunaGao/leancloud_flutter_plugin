package com.lunagao.leancloudflutterplugin;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

class LeancloudArgsConverter {

    static JSONObject getAVQueryJsonObject(MethodCall call, MethodChannel.Result result) {
        String key = "avQuery";
        Object arg = call.argument("avQuery");
        if (arg == null) {
            result.error("missing-arg", "Arg '" + key + "' can't be null, set empty value. PLEASE FIX IT!", null);
            return null;
        } else {
            return JSON.parseObject(arg.toString());
        }
    }

    static String getStringValue(MethodCall call, MethodChannel.Result result, String key) {
        Object arg = call.argument(key);
        if (arg == null) {
            result.error("missing-arg", "Arg '" + key + "' can't be null, set empty value. PLEASE FIX IT!", null);
            return "";
        } else {
            return arg.toString();
        }
    }

    static int getIntValue(MethodCall call, MethodChannel.Result result, String key) {
        Object arg = call.argument(key);
        if (arg == null) {
            result.error("missing-arg", "Arg '" + key + "' can't be null, set 0 value. PLEASE FIX IT!", null);
            return 0;
        } else {
            return (int)arg;
        }
    }
}
