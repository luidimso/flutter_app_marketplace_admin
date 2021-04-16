import 'package:flutter/material.dart';

class OrderTileHeaderComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Test"),
                Text("Test")
              ],
            )
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text("Products price: R\$0,00",
              style: TextStyle(
                fontWeight: FontWeight.w500
              ),
            ),
            Text("Total price: R\$0,00",
              style: TextStyle(
                fontWeight: FontWeight.w500
              )
            )
          ],
        )
      ],
    );
  }
}
