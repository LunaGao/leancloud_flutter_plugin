import 'package:flutter/material.dart';

import 'package:leancloud_flutter_plugin/leancloud_flutter_plugin.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  TextEditingController _userNameTextFieldController = TextEditingController();
  TextEditingController _passwordTextFieldController = TextEditingController();
  String signSessionToken = "";
  String loginSessionToken = "";

  _signin() {
    AVUser avUser = new AVUser();
    avUser.setUsername(_userNameTextFieldController.text);
    avUser.setPassword(_passwordTextFieldController.text);
    avUser.signUp().then((object) {
      avUser = object;
      signSessionToken = avUser.getSessionToken();
      setState(() { });
    });
  }

  _login() {
    AVUser avUser = new AVUser();
    avUser.setUsername(_userNameTextFieldController.text);
    avUser.setPassword(_passwordTextFieldController.text);
    avUser.login().then((object) {
      avUser = object;
      loginSessionToken = avUser.getSessionToken();
      setState(() { });
    });
  }

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
            TextField(
              controller: _userNameTextFieldController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter a username'
              ),
            ),
            TextField(
              controller: _passwordTextFieldController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter a password'
              ),
            ),
            FlatButton(
              onPressed: _signin,
              child: Text('Sign in'),
            ),
            FlatButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            Text("Sign in Session Token: " + signSessionToken),
            Text("Login in Session Token: " + loginSessionToken),
          ],
        )
    );
  }
}