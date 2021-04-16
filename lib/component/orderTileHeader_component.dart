import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_marketplace_admin/services/user_service.dart';

class OrderTileHeaderComponent extends StatelessWidget {
  final DocumentSnapshot order;

  OrderTileHeaderComponent(this.order);

  @override
  Widget build(BuildContext context) {
    final _userService = BlocProvider.of<UserService>(context);
    final _user = _userService.getUser(order.data["user"]);

    return Row(
      children: <Widget>[
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_user["name"]),
                Text(_user["address"])
              ],
            )
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text("Products price: R\$${order.data["price"].toStringAsFixed(2)}",
              style: TextStyle(
                fontWeight: FontWeight.w500
              ),
            ),
            Text("Total price: R\$${order.data["total"].toStringAsFixed(2)}",
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
