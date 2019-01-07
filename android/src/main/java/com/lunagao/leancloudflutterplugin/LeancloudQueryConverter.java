package com.lunagao.leancloudflutterplugin;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import cn.leancloud.AVObject;
import cn.leancloud.AVQuery;

class LeancloudQueryConverter {

    /**
     * convert String to AVQuery
     * @param avQueryString flutter query json String
     * @return AVQuery
     * @throws NoSuchMethodException no such method
     * @throws IllegalAccessException illegal access
     * @throws InvocationTargetException invocation target
     */
    static AVQuery<AVObject> convertStringToAVObject(String avQueryString)
            throws NoSuchMethodException, IllegalAccessException, InvocationTargetException {
        JSONObject avQueryJson = JSON.parseObject(avQueryString);
        String className = avQueryJson.getString("className");
        String fieldsString = avQueryJson.getString("queries");
        JSONObject fieldsJson = JSON.parseObject(fieldsString);
        AVQuery<AVObject> avQuery = new AVQuery<>(className);
        for (String key : fieldsJson.keySet()) {
            if (key.equals("get")) {
                avQuery.get(fieldsJson.get(key).toString());
            }

            JSONObject queryJson = (JSONObject)fieldsJson.get(key);
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
