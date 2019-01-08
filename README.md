# LeanCloud flutter plugin
[![Bless](https://cdn.rawgit.com/LunaGao/BlessYourCodeTag/master/tags/god.svg)](http://lunagao.github.io/BlessYourCodeTag/)
[![Package version](https://img.shields.io/badge/dynamic/json.svg?url=https://pub.dartlang.org/packages/leancloud_flutter_plugin.json&label=dart&query=$.versions[-1:]&colorB=blue)](https://shields.io/)

[Leancloud](https://leancloud.cn/) flutter plugin by Luna Gao

[Dark packages](https://pub.dartlang.org/packages/leancloud_flutter_plugin)

## Description
This plugin depends on Leancloud Native(iOS / Android) SDK. It's just convert the code from dart to those native language(Objective-C / Java).

## Getting Started

### Install

* Add this to your package's pubspec.yaml file:
```
dependencies:
  leancloud_flutter_plugin: ^0.0.2
```
* Install packages from the command line:
```
flutter packages get
```
* Import it
```
import 'package:leancloud_flutter_plugin/leancloud_flutter_plugin.dart';
```

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

Import: `import 'package:leancloud_flutter_plugin/leancloud_flutter_plugin.dart';`

```
LeancloudFlutterPlugin leancloudFlutterPlugin = LeancloudFlutterPlugin.getInstance();
```
#### Log Level *(Optional)*
Setup log level must be earlier than **initialize leancloud** function.
```
leancloudFlutterPlugin.setLogLevel(LeancloudLoggerLevel.DEBUG);
```
#### Region *(Optional)*
Setup region must be earlier than **initialize leancloud** function.
```
leancloudFlutterPlugin.setRegion(LeancloudCloudRegion.NorthChina);
```
#### Initialize Leancloud
```
leancloudFlutterPlugin.initialize(appId, appKey);
```
#### Create and update an Object
Import: `import 'package:leancloud_flutter_plugin/leancloud_object.dart';`

```
// Create
AVObject object = new AVObject("YOUR_OBJECT");
object.put("FIELD_NAME", "VALUE"); // String
object.put("OR_INT", 10); // int
object.put("OR_BOOLEAN", true); // boolean
object.put("OR_FLOAT", 10.01); // float
object.save().then((object) {
  // Saved
  print(object);
  
  // and Update
  object.put("description", "updated!");
  object.save().then((object) {
    // Updated
    print(object);
  });
});

```
If your update your object, `{"code":403,"error":"Forbidden writing by object's ACL."}` happened, 
then please check leancloud data's ACL field. 

#### Delete an Object
```
// object is an AVObject
object.delete().then((isDeleted) {
  // Deleted
  if (isDeleted) {
    object = null; // you should set ref to null manually if you don't using this object
    print("Deleted!");
  }
});

```

#### Query an Object
Import: `import 'package:leancloud_flutter_plugin/leancloud_query.dart';`
```
// query by object_id
AVQuery avQuery = new AVQuery("DemoObject");
avQuery.get("OBJECT_ID").then((object) {
  print("Queryed!");
});

// query objects
AVQuery avQuery = new AVQuery("DemoObject");
avQuery.whereEqualTo("KEY", "VALUE"); // string value
avQuery.whereNotEqualTo("KEY", 10); // int value
avQuery.whereGreaterThan("KEY", true); // bool value
avQuery.whereGreaterThanOrEqualTo("KEY", "VALUE");
avQuery.whereLessThan("KEY", "VALUE");
avQuery.whereLessThanOrEqualTo("KEY", "VALUE");
avQuery.find().then((objects) {
  print("All Objects Queryed!");
});
```

## Example App

[Example App README.md](https://github.com/LunaGao/leancloud_flutter_plugin/blob/master/example/README.md)


