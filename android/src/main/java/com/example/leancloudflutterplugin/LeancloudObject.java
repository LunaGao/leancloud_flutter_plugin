package com.example.leancloudflutterplugin;

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
    static void saveOrCreate(MethodCall call, final MethodChannel.Result result) {
        String avObject_string = LeancloudArgsConverter.getStringValue(call, result, "avObject");
        AVObject avObject = LeancloudObjectConverter.convertStringToAVObject(avObject_string);
        avObject.saveInBackground().subscribe(new Observer<AVObject>() {
            @Override
            public void onSubscribe(Disposable disposable) {}

            @Override
            public void onNext(AVObject avObject) {
                result.success(avObject.toJSONObject().toJSONString());
            }

            @Override
            public void onError(Throwable throwable) {
                result.error(throwable.getMessage(), null, null);
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
    static void delete(MethodCall call, final MethodChannel.Result result) {
        String avObject_string = LeancloudArgsConverter.getStringValue(call, result, "avObject");
        AVObject avObject = LeancloudObjectConverter.convertStringToAVObject(avObject_string);
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
                    result.error("Delete error, " + throwable.getMessage(), null, null);
                }

                @Override
                public void onComplete() { }
            });
        }
    }

}
