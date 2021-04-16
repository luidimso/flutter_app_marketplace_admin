import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserTileComponent extends StatelessWidget {
  final textStyle = TextStyle(
    color: Colors.white
  );
  final Map<String, dynamic> user;

  UserTileComponent(this.user);

  @override
  Widget build(BuildContext context) {
    if(user.containsKey("money")) {
      return ListTile(
        title: Text(user["name"],
          style: textStyle,
        ),
        subtitle: Text(user["email"],
          style: textStyle,
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text("Orders: ${user["orders"]}",
              style: textStyle,
            ),
            Text("Spent: R\$${user["money"].toStringAsFixed(2)}",
              style: textStyle,
            )
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
              width: 200,
              child: Shimmer.fromColors(
                  child: Container(
                    color: Colors.white.withAlpha(50),
                    margin: EdgeInsets.symmetric(
                      vertical: 4
                    ),
                  ),
                  baseColor: Colors.white,
                  highlightColor: Colors.grey
              ),
            ),
            SizedBox(
              height: 20,
              width: 50,
              child: Shimmer.fromColors(
                  child: Container(
                    color: Colors.white.withAlpha(50),
                    margin: EdgeInsets.symmetric(
                        vertical: 4
                    ),
                  ),
                  baseColor: Colors.white,
                  highlightColor: Colors.grey
              ),
            )
          ],
        ),
      );
    }
  }
}
