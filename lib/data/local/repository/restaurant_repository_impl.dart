import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/local/datasource/local_data_source.dart';
import 'package:restaurant_app/domain/entity/restaurant_entity.dart';
import 'package:restaurant_app/domain/repository/restaurant_repository.dart';

class RestaurantRepositoryIml extends RestaurantRepository {
  LocalDataSource localDataSource;

  RestaurantRepositoryIml({@required this.localDataSource});

  @override
  Future<List<RestaurantEntity>> getListRestaurant() async {
    List<RestaurantEntity> _listRestaurant = [];
    var _restaurantData = await localDataSource.getRestaurantList();
    _restaurantData.restaurants.forEach((restaurant) {
      List<FoodsEntity> _foodList = [];
      restaurant.menus.foods.forEach((food) {
        var foodEntity = FoodsEntity(name: food.name);
        _foodList.add(foodEntity);
      });

      List<DrinksEntity> _drinkList = [];
      restaurant.menus.drinks.forEach((drink) {
        var drinkEntity = DrinksEntity(name: drink.name);
        _drinkList.add(drinkEntity);
      });

      var _restaurantEntity = RestaurantEntity(
          id: restaurant.id,
          name: restaurant.name,
          description: restaurant.description,
          pictureId: restaurant.pictureId,
          city: restaurant.city,
          rating: restaurant.rating,
          menus: MenusEntity(
            foods: _foodList,
            drinks: _drinkList,
          ));
      _listRestaurant.add(_restaurantEntity);
    });

    return _listRestaurant;
  }

  @override
  Future<List<RestaurantEntity>> getListRestaurantByName(String restaurantName) async {
    List<RestaurantEntity> listRestaurant = [];
    List<RestaurantEntity> filterListRestaurant = [];
    var restaurantData = await localDataSource.getRestaurantList();
    restaurantData.restaurants.forEach((restaurant) {
      List<FoodsEntity> foodList = [];
      restaurant.menus.foods.forEach((food) {
        var foodEntity = FoodsEntity(name: food.name);
        foodList.add(foodEntity);
      });

      List<DrinksEntity> drinkList = [];
      restaurant.menus.drinks.forEach((drink) {
        var drinkEntity = DrinksEntity(name: drink.name);
        drinkList.add(drinkEntity);
      });

      var restaurantEntity = RestaurantEntity(
          id: restaurant.id,
          name: restaurant.name,
          description: restaurant.description,
          pictureId: restaurant.pictureId,
          city: restaurant.city,
          rating: restaurant.rating,
          menus: MenusEntity(
            foods: foodList,
            drinks: drinkList,
          ));
      listRestaurant.add(restaurantEntity);
    });
    filterListRestaurant = listRestaurant
        .where((food) => food.name.toLowerCase().contains(restaurantName.toLowerCase()))
        .toList();
    return filterListRestaurant;
  }
}
