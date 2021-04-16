import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_marketplace_admin/component/orderTileHeader_component.dart';

class OrderTileComponent extends StatelessWidget {
  final DocumentSnapshot order;
  final states = ["", "Preparing", "Transporting", "Awaiting delivery", "Delivered"];

  OrderTileComponent(this.order);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4
      ),
      child: Card(
        child: ExpansionTile(
          initiallyExpanded: order.data["status"] != 4,
          title: Text("#${order.documentID.substring(order.documentID.length - 7, order.documentID.length)} - ${states[order.data["status"]]}",
            style: TextStyle(
              color: order.data["status"] == 4 ? Colors.green : Colors.grey[850]
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
                  OrderTileHeaderComponent(order),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: order.data["products"].map<Widget>((product) {
                      return ListTile(
                        title: Text(product["resume"]["title"] + " " + product["size"]),
                        subtitle: Text(product["category"] + " / " + product["product"]),
                        trailing: Text(product["quantity"].toString(),
                          style: TextStyle(
                              fontSize: 20
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Firestore.instance.collection("users").document(order["user"]).collection("orders").document(order.documentID).delete();
                          order.reference.delete();
                        },
                        child: Text("Delete"),
                        textColor: Colors.red,
                      ),
                      FlatButton(
                        onPressed: order.data["status"] > 1 ? () {
                          order.reference.updateData({"status": order.data["status"] - 1});
                        } : null,
                        child: Text("Back step"),
                        textColor: Colors.grey[850],
                      ),
                      FlatButton(
                        onPressed: order.data["status"] < 4 ? () {
                          order.reference.updateData({"status": order.data["status"] + 1});
                        } : null,
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
