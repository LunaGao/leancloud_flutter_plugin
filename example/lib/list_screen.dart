import 'package:flutter/material.dart';

import 'package:leancloud_flutter_plugin/leancloud_object.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  AVObject _theObject;

  _createAnObject() {
    AVObject object = new AVObject("DemoObject");
    object.put("description", "created!");
    object.put("value", "int->10, boolean->true, float->10.01, ");
    object.put("int_value", 10);
    object.put("boolean_value", true);
    object.put("float", 10.01);
    object.save().then((object) {
      _theObject = object;
      print(object);
      setState(() { });
    });
  }

  _updateObject() {
    _theObject.put("description", "updated!");
    _theObject.save().then((object) {
      print(object);
      setState(() { });
    });
  }

  _deleteObject() {
    _theObject.delete().then((isDeleted) {
      if (isDeleted) {
        print("Deleted!");
        _theObject = null;
        setState(() { });
      }
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
              Text(_theObject == null
                  ? "Please click 'create an Object' button"
                  : (_theObject.get("description") == null
                  ? "ERROR" : _theObject.get("description"))),
              FlatButton(
                onPressed: _createAnObject,
                child: Text('create an Object'),
              ),
              FlatButton(
                onPressed: _updateObject,
                child: Text('update the Object'),
              ),
              FlatButton(
                onPressed: _deleteObject,
                child: Text('delete the Object'),
              ),
            ],
          )
    );
  }

}