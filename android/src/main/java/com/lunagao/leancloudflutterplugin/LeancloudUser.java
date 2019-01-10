package com.lunagao.leancloudflutterplugin;

import cn.leancloud.AVUser;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class LeancloudUser {

    void getCurrentUser(MethodCall call, final MethodChannel.Result result) {
        AVUser currentUser = AVUser.getCurrentUser();
        result.success(currentUser.toJSONString());
    }

}
