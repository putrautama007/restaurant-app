import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/local/model/restaurant_table.dart';

abstract class LocalDataSource {
  Future<List<RestaurantTableData>> getFavoriteRestaurantList();

  Future<RestaurantTableData> getFavoriteRestaurantById(String id);

  Future insertFavoriteRestaurant(RestaurantTableData restaurantTableData);

  Future deleteFavoriteRestaurant(RestaurantTableData restaurantTableData);
}

class LocalDataSourceImpl extends LocalDataSource {
  AppDatabase appDatabase;

  LocalDataSourceImpl({@required this.appDatabase});

  @override
  Future deleteFavoriteRestaurant(RestaurantTableData restaurantTableData) =>
      appDatabase.restaurantDao.deleteFavoriteRestaurant(restaurantTableData);

  @override
  Future<RestaurantTableData> getFavoriteRestaurantById(String id) =>
      appDatabase.restaurantDao.getFavoriteRestaurantById(id);

  @override
  Future<List<RestaurantTableData>> getFavoriteRestaurantList() =>
      appDatabase.restaurantDao.getFavoriteRestaurantList();

  @override
  Future insertFavoriteRestaurant(RestaurantTableData restaurantTableData) =>
      appDatabase.restaurantDao.insertFavoriteRestaurant(restaurantTableData);
}
