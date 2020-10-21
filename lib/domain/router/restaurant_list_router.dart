import 'package:flutter/material.dart';
import 'package:restaurant_app/presentation/screen/detail_restaurant_screen/detail_restaurant_screen.dart';
import 'package:restaurant_app/presentation/screen/search_restaurant_screen.dart';

abstract class RestaurantListRouter {
  goToDetailListRestaurant(context, String restaurantId);

  goToSearchRestaurant(context);
}

class RestaurantListRouterImpl extends RestaurantListRouter {
  @override
  goToDetailListRestaurant(context, String restaurantId) =>
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  DetailRestaurantScreen(restaurantId: restaurantId)));

  @override
  goToSearchRestaurant(context) => Navigator.push(context,
      MaterialPageRoute(builder: (context) => SearchRestaurantScreen()));
}
