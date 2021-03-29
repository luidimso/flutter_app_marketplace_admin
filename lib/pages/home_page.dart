import 'package:flutter/material.dart';
import 'package:flutter_app_marketplace_admin/pages/user_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
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
        child: PageView(
          controller: _pageController,
          onPageChanged: (page) {
            setState(() {
              _page = page;
            });
          },
          children: <Widget>[
            UserPage(),
            Container(
              color: Colors.yellow,
            ),
            Container(
                color: Colors.green
            )
          ],
        ),
      ),
    );
  }
}
