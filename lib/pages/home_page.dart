import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_marketplace_admin/pages/order_page.dart';
import 'package:flutter_app_marketplace_admin/pages/product_page.dart';
import 'package:flutter_app_marketplace_admin/pages/user_page.dart';
import 'package:flutter_app_marketplace_admin/services/order_service.dart';
import 'package:flutter_app_marketplace_admin/services/user_service.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController;
  int _page = 0;
  UserService _userService;
  OrderService _orderService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    _userService = UserService();
    _orderService = OrderService();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.pinkAccent,
          primaryColor: Colors.white,
          textTheme: Theme.of(context).textTheme.copyWith(
            caption: TextStyle(
              color: Colors.white54
            )
          )
        ),
        child: BottomNavigationBar(
          currentIndex: _page,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text("Clients")
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                title: Text("Orders")
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.list),
                title: Text("Products")
            )
          ],
          onTap: (page) {
            _pageController.animateToPage(page,
                duration: Duration(
                  milliseconds: 500
                ),
                curve: Curves.ease
            );
          },
        ),
      ),
      body: SafeArea(
        child: BlocProvider<UserService>(
          bloc: _userService,
          child: BlocProvider<OrderService>(
            bloc: _orderService,
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _page = page;
                });
              },
              children: <Widget>[
                UserPage(),
                OrderPage(),
                ProductPage()
              ],
            ),
          ),
        )
      ),
      floatingActionButton: _buildFloatingButton(),
    );
  }

  Widget _buildFloatingButton() {
    switch(_page) {
      case 0:
        return null;
        break;
      case 1:
        return SpeedDial(
          child: Icon(Icons.sort),
          backgroundColor: Colors.pinkAccent,
          overlayOpacity: 0.4,
          overlayColor: Colors.black,
          children: [
            SpeedDialChild(
              child: Icon(Icons.arrow_downward,
                color: Colors.pinkAccent,
              ),
              backgroundColor: Colors.white,
              label: "Done on bottom",
              labelStyle: TextStyle(
                fontSize: 14
              ),
              onTap: () {
                _orderService.setSortCriteria(SortCriteria.DONE_LAST);
              }
            ),
            SpeedDialChild(
              child: Icon(Icons.arrow_upward,
                color: Colors.pinkAccent,
              ),
              backgroundColor: Colors.white,
              label: "Done on top",
              labelStyle: TextStyle(
                  fontSize: 14
              ),
              onTap: () {
                _orderService.setSortCriteria(SortCriteria.DONE_FIRST);
              }
            )
          ],
        );
        break;
    }
  }
}
