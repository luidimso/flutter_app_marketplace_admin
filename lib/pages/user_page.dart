import 'package:flutter/material.dart';
import 'package:flutter_app_marketplace_admin/component/userTile_component.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8
          ),
          child: TextField(
            style: TextStyle(
                color: Colors.white
            ),
            decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(
                    color: Colors.white
                ),
                icon: Icon(Icons.search,
                  color: Colors.white,
                ),
                border: InputBorder.none
            ),
          ),
        ),
        Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return UserTileComponent();
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: 5
            )
        )
      ],
    );
  }
}
