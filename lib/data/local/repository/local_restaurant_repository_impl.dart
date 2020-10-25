import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/local/datasource/local_data_source.dart';
import 'package:restaurant_app/data/local/model/restaurant_table.dart';
import 'package:restaurant_app/domain/repository/local_restaurant_repository.dart';

class LocalRestaurantRepositoryImpl extends LocalRestaurantRepository {
  LocalDataSource localDataSource;

  LocalRestaurantRepositoryImpl({@required this.localDataSource});

  @override
  Future deleteFavoriteRestaurant(RestaurantTableData restaurantTableData) =>
      localDataSource.deleteFavoriteRestaurant(restaurantTableData);

  @override
  Future<RestaurantTableData> getFavoriteRestaurantById(String id) =>
      localDataSource.getFavoriteRestaurantById(id);

  @override
  Future<List<RestaurantTableData>> getFavoriteRestaurantList() =>
      localDataSource.getFavoriteRestaurantList();

  @override
  Future insertFavoriteRestaurant(RestaurantTableData restaurantTableData) =>
      localDataSource.insertFavoriteRestaurant(restaurantTableData);
}
