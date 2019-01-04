import 'package:flutter/material.dart';

import 'package:leancloud_flutter_plugin/leancloud_object.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  AVObject _updateObject;

  _createAnObject() {
    AVObject object = new AVObject("DemoObject");
    object.put("description", "created!");
    object.put("value", "int->10, boolean->true, float->10.01, ");
    object.put("int_value", 10);
    object.put("boolean_value", true);
    object.put("float", 10.01);
    object.save().then((object) {
      _updateObject = object;
      print(object);
      setState(() { });
    });
  }

  _saveObject() {
    _updateObject.put("description", "updated!");
    _updateObject.save().then((object) {
      print(object);
      setState(() { });
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
              FlatButton(
                onPressed: _saveObject,
                child: Text('save the Object'),
              ),
              Text(_updateObject == null
                  ? "Please click 'create an Object' button"
                  : (_updateObject.get("description") == null
                  ? "ERROR" : _updateObject.get("description"))),
            ],
          )
    );
  }

}