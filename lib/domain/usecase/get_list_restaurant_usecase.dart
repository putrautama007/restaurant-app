import 'package:restaurant_app/domain/entity/restaurant_entity.dart';
import 'package:restaurant_app/domain/repository/restaurant_repository.dart';

abstract class GetListRestaurantUseCase {
  Future<List<RestaurantEntity>> getListRestaurant();
}

class GetListRestaurantUseCaseImpl extends GetListRestaurantUseCase {
  RestaurantRepository restaurantRepository;

  GetListRestaurantUseCaseImpl({
    required this.restaurantRepository,
  });

  @override
  Future<List<RestaurantEntity>> getListRestaurant() =>
      restaurantRepository.getListRestaurant();
}
