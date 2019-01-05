# Example App for LeanCloud flutter plugin 

## Getting Started

### Setup Leancloud Data
* Create an Class named `DemoObject`
* Set ACL to unlimited (`无限制`). _**(This is important because if the Class is limited, we can't update or delete any object. It's not a bug, it's leancloud design for security.)**_

### Setup AppID and AppKey
"Oh, I don't have an appId or an appKey." Please click [here](https://leancloud.cn/docs/start.html)
* open `example/lib/main.dart` file.
* replace `YOUR_APP_ID` to your appId.
* replace `YOUR_APP_KEY` to your appKey.

### Android
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
  
### iOS
According [Flutter document](https://flutter.io/docs/development/packages-and-plugins/developing-packages#step-2c-add-ios-platform-code-hmswift)
* Run flutter build command.
```
cd example
flutter build ios --no-codesign
```
* Launch Xcode.
* Select `File > Open`, and select the `example/ios/Runner.xcworkspace` file.
* Run this example app by pressing the ▶ button.