import 'package:flutter/material.dart';
import 'package:flutter_app_marketplace_admin/component/inputField_component.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.store_mall_directory,
                    color: Colors.pinkAccent,
                    size: 160,
                  ),
                  InputFieldComponent(
                    icon: Icons.person_outline,
                    placeholder: "Username",
                    password: false,
                  ),
                  InputFieldComponent(
                    icon: Icons.lock_outline,
                    placeholder: "Password",
                    password: true,
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    height: 50,
                    child: RaisedButton(
                        color: Colors.pinkAccent,
                        child: Text("Login"),
                        textColor: Colors.white,
                        onPressed: () {}
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
