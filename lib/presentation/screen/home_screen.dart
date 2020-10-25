import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/domain/router/route_path.dart';
import 'package:restaurant_app/external/notification_utils.dart';
import 'package:restaurant_app/presentation/screen/favorite_restaurant/favorite_restaurant_list_screen.dart';
import 'package:restaurant_app/presentation/screen/restaurant_list_screen.dart';
import 'package:restaurant_app/presentation/screen/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomNavigationIndex = 0;
  final NotificationUtils _notificationUtils = NotificationUtils();

  List<Widget> _listWidget = [
    RestaurantListScreen(),
    FavoriteRestaurantListScreen(),
    SettingsScreen(),
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
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "Settings",
    ),
  ];

  void _onBottomNavigationTapped(int index) {
    setState(() {
      _bottomNavigationIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _notificationUtils.configureSelectNotificationSubject(
        RoutePath.restaurantDetail);
  }
  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
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
