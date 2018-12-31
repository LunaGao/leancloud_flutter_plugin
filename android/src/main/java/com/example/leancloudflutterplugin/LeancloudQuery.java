package com.example.leancloudflutterplugin;

import java.util.List;

import cn.leancloud.AVObject;
import cn.leancloud.AVQuery;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

class LeancloudQuery {

    /**
     *
     *
     * get
     * equalTo
     * notEqualTo
     * greaterThan
     * greaterThanOrEqualTo
     * lessThan
     * lessThanOrEqualTo
     * whereStartsWith
     * whereContains
     * whereMatches
     * limit
     * skip
     *
     * @param call
     * @param result
     * @return
     */
    static void query(MethodCall call, MethodChannel.Result result) {
        String avQuery_string = LeancloudArgsConverter.getStringValue(call, result, "avQuery");
        AVQuery<AVObject> avQuery = LeancloudQueryConverter.convertStringToAVObject(avQuery_string);
        List<AVObject> list = avQuery.find();
        //TODO list need to be JSON type
        result.success(list);
    }
}
