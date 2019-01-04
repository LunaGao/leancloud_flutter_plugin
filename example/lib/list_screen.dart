import 'package:flutter/material.dart';

import 'package:leancloud_flutter_plugin/leancloud_object.dart';
import 'package:leancloud_flutter_plugin/leancloud_flutter_plugin.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  _createAnObject() {
    AVObject object = new AVObject("DemoObject");
    object.put("description", "come from flutter plugin on Android");
    object.put("value", "int->10, boolean->true, float->10.01, ");
    object.put("int_value", 10);
    object.put("boolean_value", true);
    object.put("float", 10.01);
    object.save().then((object) {
      print(object);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text('Leancloud Plugin example app'),
          ),
          body: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),
            children: <Widget>[
              FlatButton(
                onPressed: _createAnObject,
                child: Text('create an Object'),
              ),
              const Text('I\'m dedicating every day to you'),
              const Text('Domestic life was never quite my style'),
              const Text('When you smile, you knock me out, I fall apart'),
              const Text('And I thought I was so smart'),
            ],
          )
    );
  }

}