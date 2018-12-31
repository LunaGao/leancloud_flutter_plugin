# LeanCloud flutter plugin

https://leancloud.cn/

LeanCloud flutter plugin by Luna Gao

Developing by IntelliJ IDEA.

## Getting Started

### Install

Not yet...

### Example

Still working...


## Entity to Json in Flutter
* AVObject ( The entity is not stable. )
```
{
    "className" : "CLASS NAME VALUE",
    "objectId" : "XXXXXXXXXXXXXXXXXXXXXXXX",
    "ACL" : "XXXXXXXXXXXXX",
    "createdAt" : "XXXXXXXXXXXXXXX",
    "updatedAt" : "XXXXXXXXXXXXXXX",
    "YOUR FIELD" : "YOUR FIELD VALUE",
    ...
}
```

* AVQuery ( The entity is not stable.)
```
{
    "className":"CLASS NAME VALUE",
    "queries":[
        {
            "queryMethod":"get",
            "arg1":"OBJECT ID"
        },
        {
            "queryMethod":"equalTo",
            "arg1":"FIELD NAME",
            "arg2":"FIELD VALUE"
        },
        ...
    ]
}
```

### AVQuery
Leancloud [document](https://github.com/leancloud/java-sdk-all/wiki/1.%E5%AD%98%E5%82%A8-3-AVQuery)
#### queryFunction
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

## More Details
### iOS
iOS is based on Objective-C. SDK installed by `pod`. More details you can check [here](https://leancloud.cn/docs/sdk_setup-objc.html).

### Android
Android is based on Java. SDK installed by `gradle`. Using [Java Unified SDK](https://blog.leancloud.cn/6376/). More details you can check [here](https://github.com/leancloud/java-sdk-all).
