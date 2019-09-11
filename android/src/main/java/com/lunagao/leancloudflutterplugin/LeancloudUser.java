package com.lunagao.leancloudflutterplugin;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import cn.leancloud.AVException;
import cn.leancloud.AVUser;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.reactivex.Observer;
import io.reactivex.disposables.Disposable;

public class LeancloudUser {

    void getCurrentUser(MethodCall call, final MethodChannel.Result result) {
        AVUser currentUser = AVUser.getCurrentUser();
        result.success(currentUser.toJSONString());
    }

    void signUp(MethodCall call, final MethodChannel.Result result) {
        JSONObject avQueryJson = LeancloudArgsConverter.getAVUserJsonObject(call, result);
        assert avQueryJson != null;
        String fieldsString = avQueryJson.getString("fields");
        JSONObject fieldsJson = JSON.parseObject(fieldsString);
        AVUser user = new AVUser();
        user.setUsername(fieldsJson.getString("username"));
        user.setPassword(fieldsJson.getString("password"));
        user.signUpInBackground().subscribe(new Observer<AVUser>() {
            @Override
            public void onSubscribe(Disposable disposable) {}

            @Override
            public void onNext(AVUser avUser) {
                result.success(avUser.toJSONObject().toJSONString());
            }

            @Override
            public void onError(Throwable throwable) {
                AVException avException = new AVException(throwable);
                int code = avException.getCode();
                result.error("leancloud-error", throwable.getMessage(), code);
            }

            @Override
            public void onComplete() {}
        });
    }

    void login(MethodCall call, final MethodChannel.Result result) {
        JSONObject avQueryJson = LeancloudArgsConverter.getAVUserJsonObject(call, result);
        assert avQueryJson != null;
        String fieldsString = avQueryJson.getString("fields");
        JSONObject fieldsJson = JSON.parseObject(fieldsString);
        AVUser.logIn(fieldsJson.getString("username"), fieldsJson.getString("password")).subscribe(new Observer<AVUser>() {
            @Override
            public void onSubscribe(Disposable disposable) {}

            @Override
            public void onNext(AVUser avUser) {
                result.success(avUser.toJSONObject().toJSONString());
            }

            @Override
            public void onError(Throwable throwable) {
                AVException avException = new AVException(throwable);
                int code = avException.getCode();
                result.error("leancloud-error", throwable.getMessage(), code);
            }

            @Override
            public void onComplete() {}
        });
    }

}
