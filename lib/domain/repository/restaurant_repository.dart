import 'package:restaurant_app/domain/entity/restaurant_entity.dart';

abstract class RestaurantRepository {
  Future<RestaurantListEntity> getListRestaurant();
  Future<List<RestaurantEntity>> getListRestaurantByName(String restaurantName);
}
