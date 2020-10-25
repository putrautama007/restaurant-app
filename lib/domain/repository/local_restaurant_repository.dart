import 'package:restaurant_app/data/local/model/restaurant_table.dart';

abstract class LocalRestaurantRepository {
  Future<List<RestaurantTableData>> getFavoriteRestaurantList();

  Future<RestaurantTableData> getFavoriteRestaurantById(String id);

  Future insertFavoriteRestaurant(RestaurantTableData restaurantTableData);

  Future deleteFavoriteRestaurant(RestaurantTableData restaurantTableData);
}
