import 'package:flutter/material.dart';

class OrderTileComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4
      ),
      child: Card(
        child: ExpansionTile(
          title: Text("#123 - Test",
            style: TextStyle(
              color: Colors.green
            ),
          ),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 8,
                top: 0
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text("Test"),
                        subtitle: Text("Test"),
                        trailing: Text("Text",
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {},
                        child: Text("Delete"),
                        textColor: Colors.red,
                      ),
                      FlatButton(
                        onPressed: () {},
                        child: Text("Back step"),
                        textColor: Colors.grey[850],
                      ),
                      FlatButton(
                        onPressed: () {},
                        child: Text("Next step"),
                        textColor: Colors.green,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
