# LeanCloud flutter plugin

[Leancloud](https://leancloud.cn/)

LeanCloud flutter plugin by Luna Gao

Developing by IntelliJ IDEA.

## Getting Started

### Install

Not yet...

### How to use
Before your `runApp` function, initialize the leancloud. Such as the `example` app does.

**Steps:** 
* initialize plugin
* setup log level *(Optional, default value is `OFF`)*
* setup region *(Optional, default value is `NorthChina`)*
* initialize leancloud
* save object or you can do whet ever you want :)

#### Initialize plugin
Plugin is *Singleton mode*. Please **NOT** initialize it by yourself.
```
LeancloudFlutterPlugin leancloudFlutterPlugin = LeancloudFlutterPlugin.getInstance();
```
#### Log Level *(Optional)*
Setup log level must be before call **initialize leancloud** function.
```
leancloudFlutterPlugin.setLogLevel(4);
```
#### Region *(Optional)*
Setup region must be before call **initialize leancloud** function.
```
leancloudFlutterPlugin.setRegion(0);
```
#### Initialize Leancloud
```
leancloudFlutterPlugin.initialize(appId, appKey);
```
#### Save or Create an Object
```
AVObject object = new AVObject("YOUR_OBJECT");
object.put("FIELD_NAME", "VALUE"); // String
object.put("OR_INT", 10); // int
object.put("OR_BOOLEAN", true); // boolean
object.put("OR_FLOAT", 10.01); // float
object.save().then((object) {
  print(object);
});
```

### Example

#### Setup AppID and AppKey
I don't have an appId or an appKey. Please click [here](https://leancloud.cn/docs/start.html)
* open `example/lib/main.dart` file.
* replace `YOUR_APP_ID` to your appId.
* replace `YOUR_APP_KEY` to your appKey.

#### Android
According [Flutter document](https://flutter.io/docs/development/packages-and-plugins/developing-packages#step-2b-add-android-platform-code-javakt)
* Run flutter build command
```
cd example
flutter build apk
```
* Launch Android Studio.
* Select `Import project` in `Welcome to Android Studio` dialog, or select `File > New > Import Project…` in the menu, and select the `example/android/build.gradle` file.
* In the `Gradle Sync` dialog, select `OK`.
* In the `Android Gradle Plugin Update` dialog, select `Don’t remind me again for this project`.
* Run this example app from Android Studio by pressing the ▶ button.
  
#### iOS
According [Flutter document](https://flutter.io/docs/development/packages-and-plugins/developing-packages#step-2c-add-ios-platform-code-hmswift)
* Run flutter build command.
```
cd example
flutter build ios --no-codesign
```
* Launch Xcode.
* Select `File > Open`, and select the `example/ios/Runner.xcworkspace` file.
* Run this example app by pressing the ▶ button.

## Entity to Json in Flutter
* AVObject ( The entity is not stable. )
```
{
    "className" : "CLASS NAME VALUE",
    "fields": [
        "objectId" : "XXXXXXXXXXXXXXXXXXXXXXXX",
        "ACL" : "XXXXXXXXXXXXX",
        "createdAt" : "XXXXXXXXXXXXXXX",
        "updatedAt" : "XXXXXXXXXXXXXXX",
        "YOUR FIELD" : "YOUR FIELD VALUE",
        ...
    ]
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
