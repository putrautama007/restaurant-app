import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/local/model/restaurant_table.dart';
import 'package:restaurant_app/domain/repository/local_restaurant_repository.dart';

abstract class FavoriteRestaurantUseCase {
  Future insertFavoriteRestaurant(RestaurantTableData restaurantTableData);

  Future deleteFavoriteRestaurant(RestaurantTableData restaurantTableData);

  Future<RestaurantTableData> getFavoriteRestaurantById(String id);

  Future<List<RestaurantTableData>> getFavoriteRestaurantList();
}

class FavoriteRestaurantUseCaseImpl extends FavoriteRestaurantUseCase {
  LocalRestaurantRepository localRestaurantRepository;

  FavoriteRestaurantUseCaseImpl({@required this.localRestaurantRepository});

  @override
  Future insertFavoriteRestaurant(RestaurantTableData restaurantTableData) =>
      localRestaurantRepository.insertFavoriteRestaurant(restaurantTableData);

  @override
  Future deleteFavoriteRestaurant(RestaurantTableData restaurantTableData) =>
      localRestaurantRepository.deleteFavoriteRestaurant(restaurantTableData);

  @override
  Future<RestaurantTableData> getFavoriteRestaurantById(String id) =>
      localRestaurantRepository.getFavoriteRestaurantById(id);

  @override
  Future<List<RestaurantTableData>> getFavoriteRestaurantList() =>
      localRestaurantRepository.getFavoriteRestaurantList();
}
