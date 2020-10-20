import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:restaurant_app/data/local/model/restaurant_model.dart';

abstract class LocalDataSource {
  Future<RestaurantListModel> getRestaurantList();
}

class LocalDataSourceImpl extends LocalDataSource {
  @override
  Future<RestaurantListModel> getRestaurantList() async {
    return await rootBundle
        .loadString('assets/data/local_restaurant.json')
        .then((localRestaurant) =>
            RestaurantListModel.fromJson(jsonDecode(localRestaurant)));
  }
}
