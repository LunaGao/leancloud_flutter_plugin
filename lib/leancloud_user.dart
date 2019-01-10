import 'package:leancloud_flutter_plugin/leancloud_flutter_plugin.dart';
import 'package:leancloud_flutter_plugin/leancloud_object.dart';

class AVUser extends AVObject{

  var _userName;

  AVUser() : super("_User");

//  AVUser currentUser() {
//    var leancloudFlutterPlugin = LeancloudFlutterPlugin.getInstance();
//    String jsonString = leancloudFlutterPlugin.currentUser();
//    return leancloudFlutterPlugin.currentUser();
//  }
}