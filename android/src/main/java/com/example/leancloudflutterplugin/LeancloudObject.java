package com.example.leancloudflutterplugin;

import cn.leancloud.AVObject;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

class LeancloudObject {

    /**
     * Save or Create an AVObject
     *
     * @param call MethodCall from LeancloudFlutterPlugin.onMethodCall function
     * @param result MethodChannel.Result from LeancloudFlutterPlugin.onMethodCall function
     */
    static void saveOrCreate(MethodCall call, MethodChannel.Result result) {
        String avObject_string = LeancloudArgsConverter.getStringValue(call, result, "avObject");
        AVObject avObject = LeancloudObjectConverter.convertStringToAVObject(avObject_string);
        avObject.save();
        result.success(avObject.getObjectId());
    }

    /**
     * Delete an AVObject
     *
     * @param call MethodCall from LeancloudFlutterPlugin.onMethodCall function
     * @param result MethodChannel.Result from LeancloudFlutterPlugin.onMethodCall function
     */
    static void delete(MethodCall call, MethodChannel.Result result) {
        String avObject_string = LeancloudArgsConverter.getStringValue(call, result, "avObject");
        AVObject avObject = LeancloudObjectConverter.convertStringToAVObject(avObject_string);
        if (avObject.getObjectId().isEmpty()) {
            result.error("Delete an Leancloud Object, it's objectId can not be empty!", null, null);
        } else {
            avObject.delete();
        }
    }

}
