import 'package:leancloud_flutter_plugin/leancloud_flutter_plugin.dart';
import 'package:leancloud_flutter_plugin/src/leancloud_object.dart';

class AVUser extends AVObject{

  AVUser() : super("_User");

  /// This function used for AVQuery. It's convert from string to AVUser.
  AVUser.fromQueryBackString(String queriedString) : super.fromQueryBackString(queriedString);

  ///
  static Future<AVUser> signUpOrLoginByMobilePhone(String mobileNumber, String smsCode) async {
    var leancloudFlutterPlugin = LeancloudFlutterPlugin.getInstance();
    String queriedString = await leancloudFlutterPlugin.signUpOrLoginByMobilePhone(mobileNumber, smsCode);
    return AVUser.fromQueryBackString(queriedString);
  }

  /// email verify
  static Future<bool> requestEmailVerify(String email) async {
    var leancloudFlutterPlugin = LeancloudFlutterPlugin.getInstance();
    bool isSuccess = await leancloudFlutterPlugin.requestEmailVerify(email);
    return isSuccess;
  }

  /// Add or Update field value with [value] into this Object by [key]
  void put(String key, Object value) {
    super.put(key, value);
  }

  /// set user name
  void setUsername(String userName) {
    this.put("userName", userName);
  }

  /// set password
  void setPassword(String password) {
    this.put("password", password);
  }

  /// set email
  void setEmail(String email) {
    this.put("email", email);
  }

  get getUsername {
    super.get("userName");
  }

  get getEmail {
    super.get("email");
  }

  Future<AVUser> save() async{
    super.save();
    return this;
  }

  void signUp() async{
    var leancloudFlutterPlugin = LeancloudFlutterPlugin.getInstance();
    String queriedString = await leancloudFlutterPlugin.signUp(this);
    //TODO need to check how to assign return value to itself.
    AVUser.fromQueryBackString(queriedString);
  }


//  AVUser currentUser() {
//    var leancloudFlutterPlugin = LeancloudFlutterPlugin.getInstance();
//    String jsonString = leancloudFlutterPlugin.currentUser();
//    return leancloudFlutterPlugin.currentUser();
//  }
}