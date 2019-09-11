import 'package:test/test.dart';
import 'package:leancloud_flutter_plugin/leancloud_flutter_plugin.dart';

void main() {
  test('my first unit test', () {
    var lfp = LeancloudFlutterPlugin.getInstance();
    lfp.setServer(LeancloudOSService.API, "#LeancloudOSService#");
    lfp.initialize("#appId#", "#appKey#");
    AVObject object = new AVObject("DemoObject");
    object.put("description", "maomishen!");
    object.put("value", "int->10, boolean->true, float->10.01, ");
    object.put("int_value", 10);
    object.put("boolean_value", true);
    object.put("float", 10.01);
    object.save().then((object) {
      expect(object.get("description"), "maomishen!");
      print(object);
    });
  });
}
