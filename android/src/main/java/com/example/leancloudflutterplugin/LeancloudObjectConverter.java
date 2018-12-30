package com.example.leancloudflutterplugin;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import cn.leancloud.AVObject;

class LeancloudObjectConverter {

    static AVObject convertStringToAVObject(String avObjectString) {
        JSONObject avObjectJson = JSON.parseObject(avObjectString);
        String className = avObjectJson.getString("className");
        AVObject avObject = new AVObject(className);
        for (String key : avObjectJson.keySet()) {
            //TODO if those value is Date or byte[] type?
            //TODO more data type? e.g. AVGeoPoint？
            avObject.put(key, avObjectJson.get(key));
        }
        return avObject;
    }

}
