import 'package:restaurant_app/domain/entity/detail_restaurant_entity.dart';
import 'package:restaurant_app/domain/repository/restaurant_repository.dart';

abstract class GetRestaurantDetailUseCase {
  Future<DetailRestaurantEntity> getRestaurantDetail(String restaurantId);
}

class GetRestaurantDetailUseCaseImpl extends GetRestaurantDetailUseCase {
  RestaurantRepository restaurantRepository;

  GetRestaurantDetailUseCaseImpl({required this.restaurantRepository});

  @override
  Future<DetailRestaurantEntity> getRestaurantDetail(String restaurantId) =>
      restaurantRepository.getRestaurantDetail(restaurantId);
}
