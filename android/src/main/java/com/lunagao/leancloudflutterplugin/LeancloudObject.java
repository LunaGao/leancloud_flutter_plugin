package com.lunagao.leancloudflutterplugin;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import java.util.List;

import cn.leancloud.AVObject;
import cn.leancloud.types.AVNull;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.reactivex.Observer;
import io.reactivex.disposables.Disposable;

class LeancloudObject {

    /**
     * Save or Create an AVObject
     *
     * @param call MethodCall from LeancloudFlutterPlugin.onMethodCall function
     * @param result MethodChannel.Result from LeancloudFlutterPlugin.onMethodCall function
     */
    void saveOrCreate(MethodCall call, final MethodChannel.Result result) {
        String avObject_string = LeancloudArgsConverter.getStringValue(call, result, "avObject");
        AVObject avObject = this.convertStringToAVObject(avObject_string);
        avObject.saveInBackground().subscribe(new Observer<AVObject>() {
            @Override
            public void onSubscribe(Disposable disposable) {}

            @Override
            public void onNext(AVObject avObject) {
                result.success(avObject.toJSONObject().toJSONString());
            }

            @Override
            public void onError(Throwable throwable) {
                result.error("leancloud-error", throwable.getMessage(), null);
            }

            @Override
            public void onComplete() {}
        });
    }

    /**
     * Delete an AVObject
     *
     * @param call MethodCall from LeancloudFlutterPlugin.onMethodCall function
     * @param result MethodChannel.Result from LeancloudFlutterPlugin.onMethodCall function
     */
    void delete(MethodCall call, final MethodChannel.Result result) {
        String avObject_string = LeancloudArgsConverter.getStringValue(call, result, "avObject");
        AVObject avObject = this.convertStringToAVObject(avObject_string);
        if (avObject.getObjectId().isEmpty()) {
            result.error("Delete an Leancloud Object, it's objectId can not be empty!", null, null);
        } else {
            avObject.deleteInBackground().subscribe(new Observer<AVNull>() {
                @Override
                public void onSubscribe(Disposable disposable) { }

                @Override
                public void onNext(AVNull avNull) {
                    result.success(true);
                }

                @Override
                public void onError(Throwable throwable) {
                    result.error("leancloud-error", throwable.getMessage(), null);
                }

                @Override
                public void onComplete() { }
            });
        }
    }

    private AVObject convertStringToAVObject(String avObjectString) {
        JSONObject avObjectJson = JSON.parseObject(avObjectString);
        String className = avObjectJson.getString("className");
        String fieldsString = avObjectJson.getString("fields");
        JSONObject fieldsJson = JSON.parseObject(fieldsString);
        AVObject avObject = new AVObject(className);
        for (String key : fieldsJson.keySet()) {
            //TODO if those value is Date or byte[] type?
            //TODO more data type? e.g. AVGeoPoint？
            if (key.equals("createdAt")) continue;
            if (key.equals("updatedAt")) continue;
            if (key.equals("objectId")) avObject.setObjectId(fieldsJson.get(key).toString());
            else avObject.put(key, fieldsJson.get(key));
        }
        return avObject;
    }

}
