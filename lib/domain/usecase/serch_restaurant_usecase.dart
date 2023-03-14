import 'package:restaurant_app/domain/entity/restaurant_entity.dart';
import 'package:restaurant_app/domain/repository/restaurant_repository.dart';

abstract class SearchRestaurantUseCase {
  Future<RestaurantListEntity> searchRestaurant(String restaurantName);
}

class SearchRestaurantUseCaseImpl extends SearchRestaurantUseCase {
  RestaurantRepository restaurantRepository;

  SearchRestaurantUseCaseImpl({required this.restaurantRepository});

  @override
  Future<RestaurantListEntity> searchRestaurant(
          String restaurantName) =>
      restaurantRepository.searchRestaurant(restaurantName);
}
