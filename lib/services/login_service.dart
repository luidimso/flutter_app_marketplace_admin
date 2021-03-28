import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_app_marketplace_admin/validators/login_validator.dart';
import 'package:rxdart/rxdart.dart';

class LoginService extends BlocBase with LoginValidator {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get outEmail => _emailController.stream.transform(emailValidator);
  Stream<String> get outPassword => _passwordController.stream.transform(passwordValidator);

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.close();
    _passwordController.close();
  }

}