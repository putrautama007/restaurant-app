import 'package:flutter/material.dart';
import 'package:restaurant_app/domain/entity/restaurant_entity.dart';
import 'package:restaurant_app/presentation/screen/detail_restaurant_screen/detail_restaurant_screen.dart';

abstract class RestaurantListRouter {
  goToDetailListRestaurant(context, RestaurantEntity restaurantEntity);
}

class RestaurantListRouterImpl extends RestaurantListRouter {
  @override
  goToDetailListRestaurant(context, RestaurantEntity restaurantEntity) =>
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailRestaurantScreen(
                  restaurantEntity: restaurantEntity)));
}
