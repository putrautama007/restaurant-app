import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:restaurant_app/data/remote/model/restaurant_model.dart';

abstract class RemoteDataSource {
  Future<RestaurantListModel> getRestaurantList();
  Future<RestaurantListModel> getRestaurantListByName();
}

class RemoteDataSourceImpl extends RemoteDataSource {
  @override
  Future<RestaurantListModel> getRestaurantList() async {
    return await rootBundle
        .loadString('assets/data/local_restaurant.json')
        .then((localRestaurant) =>
            RestaurantListModel.fromJson(jsonDecode(localRestaurant)));
  }

  @override
  Future<RestaurantListModel> getRestaurantListByName() async{
    return await rootBundle
        .loadString('assets/data/local_restaurant.json')
        .then((localRestaurant) =>
        RestaurantListModel.fromJson(jsonDecode(localRestaurant)));
  }
}
