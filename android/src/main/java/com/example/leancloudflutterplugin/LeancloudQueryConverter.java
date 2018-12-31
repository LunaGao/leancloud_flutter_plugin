package com.example.leancloudflutterplugin;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import java.lang.reflect.Method;

import cn.leancloud.AVObject;
import cn.leancloud.AVQuery;

class LeancloudQueryConverter {

    static AVQuery<AVObject> convertStringToAVObject(String avQueryString) throws Exception {
        JSONObject avQueryJson = JSON.parseObject(avQueryString);
        String className = avQueryJson.getString("className");
        AVQuery<AVObject> avQuery = new AVQuery<>(className);
        for (Object queryObject: avQueryJson.getJSONArray("queries")) {
            JSONObject queryJson = (JSONObject)queryObject;
            String method_String = queryJson.getString("queryMethod");
            String arg1 = queryJson.getString("arg1");

            if (queryJson.containsKey("arg2")) {
                Object arg2_object = queryJson.get("arg2");
                if (arg2_object.getClass().equals(String.class)) {
                    String arg2 = (String) arg2_object;
                    Method queryMethod = avQuery.getClass().getMethod(method_String, String.class, String.class);
                    queryMethod.invoke(avQuery, arg1, arg2);
                } else if (arg2_object.getClass().equals(int.class)) {
                    int arg2 = (int) arg2_object;
                    Method queryMethod = avQuery.getClass().getMethod(method_String, String.class, int.class);
                    queryMethod.invoke(avQuery, arg1, arg2);
                }
            } else {
                Method queryMethod = avQuery.getClass().getMethod(method_String, String.class);
                queryMethod.invoke(avQuery, arg1);
            }
        }
        return avQuery;
    }

}
