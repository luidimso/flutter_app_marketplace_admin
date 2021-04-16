import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_marketplace_admin/component/orderTile_component.dart';
import 'package:flutter_app_marketplace_admin/services/order_service.dart';

class OrderPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final _orderService = BlocProvider.of<OrderService>(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16
      ),
      child: StreamBuilder<List>(
        stream: _orderService.outOrders,
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
              ),
            );
          } else if(snapshot.data.length == 0) {
            return Center(
              child: Text("No order found!",
                style: TextStyle(
                    color: Colors.pinkAccent
                ),
              ),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return OrderTileComponent(snapshot.data[index]);
                }
            );
          }
        },
      ),
    );
  }
}
