import 'dart:async';

class LoginValidator {
  final emailValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if(email.contains("@")) {
        sink.add(email);
      } else {
        sink.addError("Enter a valid email");
      }
    }
  );

  final passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
        if(password.length > 4) {
          sink.add(password);
        } else {
          sink.addError("Invalid password, it should contains at least 4 characters");
        }
      }
  );
}