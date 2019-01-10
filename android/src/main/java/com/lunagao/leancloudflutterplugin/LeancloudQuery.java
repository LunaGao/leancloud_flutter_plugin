package com.lunagao.leancloudflutterplugin;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import java.util.List;

import cn.leancloud.AVObject;
import cn.leancloud.AVQuery;
import cn.leancloud.query.AVCloudQueryResult;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.reactivex.Observer;
import io.reactivex.disposables.Disposable;

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
    void query(MethodCall call, final MethodChannel.Result result) {
        JSONObject avQueryJson = LeancloudArgsConverter.getAVQueryJsonObject(call, result);
        assert avQueryJson != null;
        String className = avQueryJson.getString("className");
        String queriesString = avQueryJson.getString("queries");
        JSONArray queriesJson = JSON.parseArray(queriesString);
        AVQuery<AVObject> avQuery = new AVQuery<>(className);
        for (Object oneQueryObject : queriesJson) {
            JSONObject oneQuery;
            if (oneQueryObject instanceof JSONObject) {
                oneQuery = (JSONObject) oneQueryObject;
            } else {
                oneQuery = (JSONObject) JSON.toJSON(oneQueryObject);
            }

            switch (oneQuery.getString("queryMethod")) {
                case "get":
                    avQuery.getInBackground(oneQuery.getString("arg1")).subscribe(new Observer<AVObject>() {
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
                    return;
                case "equalTo":
                    avQuery.whereEqualTo(oneQuery.getString("arg1"), oneQuery.get("arg2"));
                    break;
                case "notEqualTo":
                    avQuery.whereNotEqualTo(oneQuery.getString("arg1"), oneQuery.get("arg2"));
                    break;
                case "greaterThan":
                    avQuery.whereGreaterThan(oneQuery.getString("arg1"), oneQuery.get("arg2"));
                    break;
                case "greaterThanOrEqualTo":
                    avQuery.whereGreaterThanOrEqualTo(oneQuery.getString("arg1"), oneQuery.get("arg2"));
                    break;
                case "lessThan":
                    avQuery.whereLessThan(oneQuery.getString("arg1"), oneQuery.get("arg2"));
                    break;
                case "lessThanOrEqualTo":
                    avQuery.whereLessThanOrEqualTo(oneQuery.getString("arg1"), oneQuery.get("arg2"));
                    break;
                case "orderByAscending":
                    avQuery.orderByAscending(oneQuery.getString("arg1"));
                    break;
                case "orderByDescending":
                    avQuery.orderByDescending(oneQuery.getString("arg1"));
                    break;
                case "addAscendingOrder":
                    avQuery.addAscendingOrder(oneQuery.getString("arg1"));
                    break;
                case "addDescendingOrder":
                    avQuery.addDescendingOrder(oneQuery.getString("arg1"));
                    break;
                case "limit":
                    avQuery.limit(oneQuery.getIntValue("arg1"));
                    break;
                case "skip":
                    avQuery.skip(oneQuery.getIntValue("arg1"));
                    break;
                default:
                    result.error("params-error", "no such query queryMethod name, please check again", null);
                    break;
            }

        }
        avQuery.findInBackground().subscribe(new Observer<List<AVObject>>() {
            @Override
            public void onSubscribe(Disposable disposable) {}

            @Override
            public void onNext(List<AVObject> avObjects) {
                JSONObject jsonObject = new JSONObject();
                JSONArray jsonArray = new JSONArray();
                for (AVObject object : avObjects) {
                    jsonArray.add(object.toJSONObject().toJSONString());
                }
                jsonObject.put("objects", jsonArray);
                result.success(jsonObject.toJSONString());
            }

            @Override
            public void onError(Throwable throwable) {
                result.error("leancloud-error", throwable.getMessage(), null);
            }

            @Override
            public void onComplete() {}
        });
    }

    void doCloudQuery(MethodCall call, final MethodChannel.Result result) {
        String cqlString = LeancloudArgsConverter.getStringValue(call, result, "cql");
        AVQuery.doCloudQueryInBackground(cqlString).subscribe(new Observer<AVCloudQueryResult>() {
            @Override
            public void onSubscribe(Disposable disposable) {}

            @Override
            public void onNext(AVCloudQueryResult avCloudQueryResult) {
                List<? extends AVObject> avObjects = avCloudQueryResult.getResults();
                JSONObject jsonObject = new JSONObject();
                JSONArray jsonArray = new JSONArray();
                for (AVObject object : avObjects) {
                    jsonArray.add(object.toJSONObject().toJSONString());
                }
                jsonObject.put("objects", jsonArray);
                result.success(jsonObject.toJSONString());
            }

            @Override
            public void onError(Throwable throwable) {
                result.error("leancloud-error", throwable.getMessage(), null);
            }

            @Override
            public void onComplete() {}
        });
    }
}
