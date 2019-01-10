import 'package:flutter/material.dart';

import 'package:leancloud_flutter_plugin/leancloud_object.dart';
import 'package:leancloud_flutter_plugin/leancloud_query.dart';

import 'user_screen.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  AVObject _theObject;
  String _queryObjectValue;

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
        _queryObjectValue = null;
        setState(() { });
      }
    });
  }

  _queryObject() {
    AVQuery avQuery = new AVQuery("DemoObject");
    avQuery.get(_theObject.getObjectId()).then((object) {
      print("Queryed!");
      _queryObjectValue = object.getObjectId();
      setState(() { });
    });
  }

  _queryAllObject() {
    AVQuery avQuery = new AVQuery("DemoObject");
    avQuery.whereEqualTo("description", "created!");
//    avQuery.whereNotEqualTo("int_value", 20);
//    avQuery.whereGreaterThan("int_value", 20);
//    avQuery.whereGreaterThanOrEqualTo("int_value", 20);
//    avQuery.whereLessThan("int_value", 20);
//    avQuery.whereLessThanOrEqualTo("int_value", 20);
    avQuery.limit(10);
    avQuery.skip(1);
    avQuery.find().then((objects) {
      print("All Objects Queryed!");
      setState(() { });
    });
  }

  _queryByCQL() {
    var cql = "select * from DemoObject where int_value = 20";
    AVQuery.doCloudQuery(cql).then((objects) {
      print(objects);
      print("Queryed!");
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
              Text(_theObject == null
                  ? "Please click 'create an Object' button first"
                  : (_queryObjectValue == null
                  ? "click the 'query the Object' button" : _queryObjectValue)),
              FlatButton(
                onPressed: _queryObject,
                child: Text('query the Object'),
              ),
              FlatButton(
                onPressed: _queryAllObject,
                child: Text('query all Objects'),
              ),
              FlatButton(
                onPressed: _queryByCQL,
                child: Text('query by CQL'),
              ),
              Text('login function'),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserScreen()),
                  );
                },
                child: Text('LOGIN'),
              ),
            ],
          )
    );
  }

}