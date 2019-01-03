package com.example.leancloudflutterplugin;

import java.lang.reflect.InvocationTargetException;
import java.util.List;

import cn.leancloud.AVObject;
import cn.leancloud.AVQuery;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

class LeancloudQuery {

    /**
     * query AVObject
     * More detail please check: https://github.com/leancloud/java-sdk-all/wiki/1.%E5%AD%98%E5%82%A8-3-AVQuery
     *
     * function:
     *  get
     *  whereEqualTo
     *  whereNotEqualTo
     *  whereGreaterThan
     *  whereGreaterThanOrEqualTo
     *  whereLessThan
     *  whereLessThanOrEqualTo
     *  whereStartsWith
     *  whereContains
     *  whereMatches
     *  limit
     *  skip
     *
     * @param call MethodCall from LeancloudFlutterPlugin.onMethodCall function
     * @param result MethodChannel.Result from LeancloudFlutterPlugin.onMethodCall function
     */
    static void query(MethodCall call, MethodChannel.Result result) {
        String avQuery_string = LeancloudArgsConverter.getStringValue(call, result, "avQuery");
        try {
            AVQuery<AVObject> avQuery = LeancloudQueryConverter.convertStringToAVObject(avQuery_string);
            List<AVObject> list = avQuery.find();
            //TODO list need to be JSON type
            result.success(list);
        } catch (NoSuchMethodException ex) {
            result.error("NoSuchMethodException, please check queryMethod", null, null);
        } catch (IllegalAccessException ex) {
            result.error("IllegalAccessException, Do you call an illegal access method?", null, null);
        } catch (InvocationTargetException ex) {
            result.error("InvocationTargetException, I don't know what's happen,:( check everything again?", null, null);
        }
    }
}
