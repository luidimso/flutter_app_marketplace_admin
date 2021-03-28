import 'package:flutter/material.dart';

class InputFieldComponent extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final bool password;

  InputFieldComponent({this.icon, this.password, this.placeholder});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        icon: Icon(icon,
          color: Colors.white,
        ),
        hintText: placeholder,
        hintStyle: TextStyle(
          color: Colors.white
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.pinkAccent
          )
        ),
        contentPadding: EdgeInsets.only(
          left: 5,
          right: 30,
          top: 30,
          bottom: 30
        )
      ),
      style: TextStyle(
        color: Colors.white
      ),
      obscureText: password,
    );
  }
}
