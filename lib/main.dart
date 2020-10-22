import 'package:flutter/material.dart';
import 'package:restaurant_app/domain/router/route_path.dart';
import 'package:restaurant_app/external/navigation.dart';
import 'package:restaurant_app/presentation/screen/detail_restaurant_screen/detail_restaurant_screen.dart';
import 'package:restaurant_app/presentation/screen/home_screen.dart';
import 'package:restaurant_app/presentation/screen/search_restaurant_screen.dart';
import 'package:restaurant_app/presentation/screen/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: navigationKey,
      initialRoute: RoutePath.splash,
      routes: {
        RoutePath.splash: (context) => SplashScreen(),
        RoutePath.home: (context) => HomeScreen(),
        RoutePath.searchRestaurant: (context) => SearchRestaurantScreen(),
        RoutePath.restaurantDetail: (context) => DetailRestaurantScreen(
              restaurantEntity: ModalRoute.of(context).settings.arguments,
            ),
      },
    );
  }
}
