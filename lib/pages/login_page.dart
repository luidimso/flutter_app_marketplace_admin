import 'package:flutter/material.dart';
import 'package:flutter_app_marketplace_admin/component/inputField_component.dart';
import 'package:flutter_app_marketplace_admin/services/login_service.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginService = LoginService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loginService.outState.listen((event) {
      switch(event) {
        case LoginState.SUCCESS:
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => HomePage()
          ));
          break;
        case LoginState.FAIL:
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Error"),
              content: Text("You don't have the necessary privileges"),
            )
          );
          break;
        case LoginState.LOADING:
        case LoginState.IDLE:
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _loginService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: StreamBuilder<LoginState>(
        stream: _loginService.outState,
        initialData: LoginState.LOADING,
        builder: (context, snapshot) {
          switch(snapshot.data) {
            case LoginState.LOADING:
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
                ),
              );
              break;
            case LoginState.SUCCESS:
            case LoginState.FAIL:
            case LoginState.IDLE:
            default:
              return Stack(
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
                            validator: _loginService.outEmail,
                            onChanged: _loginService.changeEmail,
                          ),
                          InputFieldComponent(
                            icon: Icons.lock_outline,
                            placeholder: "Password",
                            password: true,
                            validator: _loginService.outPassword,
                            onChanged: _loginService.changePassword,
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          StreamBuilder<bool>(
                              stream: _loginService.outBtnValid,
                              builder: (context, snapshot) {
                                return SizedBox(
                                  height: 50,
                                  child: RaisedButton(
                                      color: Colors.pinkAccent,
                                      child: Text("Login"),
                                      textColor: Colors.white,
                                      disabledColor: Colors.pinkAccent.withAlpha(140),
                                      onPressed: snapshot.hasData ? _loginService.submit : null
                                  ),
                                );
                              }
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
              break;
          }
        },
      ),
    );
  }
}
