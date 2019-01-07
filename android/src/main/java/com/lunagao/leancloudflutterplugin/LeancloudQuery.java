package com.lunagao.leancloudflutterplugin;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

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
    void query(MethodCall call, MethodChannel.Result result) {
        JSONObject avQueryJson = LeancloudArgsConverter.getAVQueryJsonObject(call, result);
        assert avQueryJson != null;
        String className = avQueryJson.getString("className");
        String fieldsString = avQueryJson.getString("queries");
        JSONObject fieldsJson = JSON.parseObject(fieldsString);
        AVQuery<AVObject> avQuery = new AVQuery<>(className);
        try {
            if (fieldsJson.size() == 1 && fieldsJson.containsKey("get")) {
//                AVObject object = avQuery.get(fieldsJson.getString("get"));
                List<AVObject> objects = avQuery.find();
                AVObject object = avQuery.get("5c31b14544d904005d1e773c");
                result.success(object);
//                result.success("Android " + android.os.Build.VERSION.RELEASE);
            }

            //TODO list need to be JSON type
//            result.success(list);
        } catch (Exception ex) {
            result.error("aaa" + ex.getMessage(), null, null);
        }
//        } catch (NoSuchMethodException ex) {
//            result.error("NoSuchMethodException, please check queryMethod", null, null);
//        } catch (IllegalAccessException ex) {
//            result.error("IllegalAccessException, Do you call an illegal access method?", null, null);
//        } catch (InvocationTargetException ex) {
//            result.error("InvocationTargetException, I don't know what's happen,:( check everything again?", null, null);
//        }
    }
}
