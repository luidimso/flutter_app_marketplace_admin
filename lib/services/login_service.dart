import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_marketplace_admin/validators/login_validator.dart';
import 'package:rxdart/rxdart.dart';

enum LoginState {IDLE, LOADING, SUCCESS, FAIL}

class LoginService extends BlocBase with LoginValidator {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();

  Stream<String> get outEmail => _emailController.stream.transform(emailValidator);
  Stream<String> get outPassword => _passwordController.stream.transform(passwordValidator);
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Stream<bool> get outBtnValid => Observable.combineLatest2(outEmail, outPassword, (a, b) => true);
  Stream<LoginState> get outState => _stateController.stream;
  StreamSubscription _authListener;

  LoginService() {
    _authListener = FirebaseAuth.instance.onAuthStateChanged.listen((user) async {
      if(user != null) {
        if(await verifyPrivileges(user)) {
          _stateController.add(LoginState.SUCCESS);
        } else {
          FirebaseAuth.instance.signOut();
          _stateController.add(LoginState.FAIL);
        }
      } else {
        _stateController.add(LoginState.IDLE);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.close();
    _passwordController.close();
    _stateController.close();
    _authListener.cancel();
  }

  void submit() {
    final email = _emailController.value;
    final password = _passwordController.value;

    _stateController.add(LoginState.LOADING);

    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).catchError((e) {
      _stateController.add(LoginState.FAIL);
    });
  }

  Future<bool> verifyPrivileges(FirebaseUser user) async {
    return await Firestore.instance.collection("admin").document(user.uid).get().then((value) {
      if(value.data != null){
        return true;
      } else {
        return false;
      }
    }).catchError((e) {
      return false;
    });
  }
}