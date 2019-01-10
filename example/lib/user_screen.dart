import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('User Page'),
        ),
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            Text("Please click 'create an Object' button"),
            FlatButton(
              onPressed: () {},
              child: Text('Sign in'),
            ),
            FlatButton(
              onPressed: () {},
              child: Text('Login in'),
            )
          ],
        )
    );
  }
}