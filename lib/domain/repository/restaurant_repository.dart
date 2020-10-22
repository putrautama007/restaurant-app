import 'package:restaurant_app/domain/entity/add_review_entity.dart';
import 'package:restaurant_app/domain/entity/detail_restaurant_entity.dart';
import 'package:restaurant_app/domain/entity/restaurant_entity.dart';

abstract class RestaurantRepository {
  Future<RestaurantListEntity> getListRestaurant();
  Future<DetailRestaurantEntity> getRestaurantDetail(String restaurantId);
  Future<RestaurantListEntity> searchRestaurant(String restaurantName);
  Future<AddReviewsEntity> addReview(
      String restaurantId, String userName, String review);
}
