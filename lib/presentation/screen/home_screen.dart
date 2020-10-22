import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/presentation/screen/favorite_restaurant/favorite_restaurant_list_screen.dart';
import 'package:restaurant_app/presentation/screen/restaurant_list_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomNavigationIndex = 0;

  List<Widget> _listWidget = [
    RestaurantListScreen(),
    FavoriteRestaurantListScreen(),
  ];

  List<BottomNavigationBarItem> _bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Restaurant",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.bookmark),
      label: "Bookmark",
    ),
  ];

  void _onBottomNavigationTapped(int index) {
    setState(() {
      _bottomNavigationIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavigationIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavigationIndex,
        items: _bottomNavigationBarItems,
        onTap: _onBottomNavigationTapped,
      ),
    );
  }
}
