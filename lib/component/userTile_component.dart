import 'package:flutter/material.dart';

class UserTileComponent extends StatelessWidget {
  final textStyle = TextStyle(
    color: Colors.white
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Test",
        style: textStyle,
      ),
      subtitle: Text("Test",
        style: textStyle,
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text("Orders: 0",
            style: textStyle,
          ),
          Text("Spent: 0",
            style: textStyle,
          )
        ],
      ),
    );
  }
}
