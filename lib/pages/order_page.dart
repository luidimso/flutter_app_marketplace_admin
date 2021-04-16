import 'package:flutter/material.dart';
import 'package:flutter_app_marketplace_admin/component/orderTile_component.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16
      ),
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, snapshot) {
          return OrderTileComponent();
        }
      ),
    );
  }
}
