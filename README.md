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

## Example App

[Example App README.md](https://github.com/LunaGao/leancloud_flutter_plugin/blob/master/example/README.md)


