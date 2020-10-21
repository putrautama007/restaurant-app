import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/remote/datasource/api_constant.dart';
import 'package:restaurant_app/data/remote/datasource/remote_data_source.dart';
import 'package:restaurant_app/domain/entity/restaurant_entity.dart';
import 'package:restaurant_app/domain/repository/restaurant_repository.dart';

class RestaurantRepositoryIml extends RestaurantRepository {
  RemoteDataSource localDataSource;

  RestaurantRepositoryIml({@required this.localDataSource});

  @override
  Future<RestaurantListEntity> getListRestaurant() async {
    List<RestaurantEntity> listRestaurant = List<RestaurantEntity>();
    var restaurantData = await localDataSource.getRestaurantList();
    restaurantData.restaurants.forEach((restaurant) {
      var restaurantEntity = RestaurantEntity(
          id: restaurant.id,
          name: restaurant.name,
          description: restaurant.description,
          pictureId: "${ApiConstant.smallImageResolution}${restaurant.pictureId}",
          city: restaurant.city,
          rating: restaurant.rating.toString()
      );
      listRestaurant.add(restaurantEntity);
    });

    var restaurantListEntity = RestaurantListEntity(
      error: restaurantData.error,
      message: restaurantData.message,
      restaurants: listRestaurant,
    );

    return restaurantListEntity;
  }

  @override
  Future<List<RestaurantEntity>> getListRestaurantByName(
      String restaurantName) async {
    List<RestaurantEntity> listRestaurant = List<RestaurantEntity>();
    List<RestaurantEntity> filterListRestaurant = List<RestaurantEntity>();
    var restaurantData = await localDataSource.getRestaurantList();
    restaurantData.restaurants.forEach((restaurant) {

      var restaurantEntity = RestaurantEntity(
          id: restaurant.id,
          name: restaurant.name,
          description: restaurant.description,
          pictureId: restaurant.pictureId,
          city: restaurant.city,
          rating: restaurant.rating.toString());
      listRestaurant.add(restaurantEntity);
    });
    filterListRestaurant = listRestaurant
        .where((food) =>
            food.name.toLowerCase().contains(restaurantName.toLowerCase()))
        .toList();
    return filterListRestaurant;
  }
}
