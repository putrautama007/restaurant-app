import 'package:flutter/foundation.dart';
import 'package:restaurant_app/domain/entity/restaurant_entity.dart';
import 'package:restaurant_app/domain/repository/restaurant_repository.dart';

abstract class SearchRestaurantUseCase {
  Future<List<RestaurantEntity>> getListRestaurantByName(String restaurantName);
}

class SearchRestaurantUseCaseImpl extends SearchRestaurantUseCase {
  RestaurantRepository restaurantRepository;

  SearchRestaurantUseCaseImpl({@required this.restaurantRepository});

  @override
  Future<List<RestaurantEntity>> getListRestaurantByName(
          String restaurantName) =>
      restaurantRepository.getListRestaurantByName(restaurantName);
}
