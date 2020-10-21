import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/remote/datasource/api_constant.dart';
import 'package:restaurant_app/data/remote/datasource/remote_data_source.dart';
import 'package:restaurant_app/domain/entity/detail_restaurant_entity.dart';
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
          pictureId:
              "${ApiConstant.smallImageResolution}${restaurant.pictureId}",
          city: restaurant.city,
          rating: restaurant.rating.toString());
      listRestaurant.add(restaurantEntity);
    });

    var restaurantListEntity = RestaurantListEntity(
      error: restaurantData.error,
      message: restaurantData.message ?? "",
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

  @override
  Future<DetailRestaurantEntity> getRestaurantDetail(
      String restaurantId) async {
    var restaurantData =
        await localDataSource.getRestaurantDetail(restaurantId);
    List<CategoryEntity> categoryList = List<CategoryEntity>();
    restaurantData.restaurant.categories.forEach((category) {
      var categoryEntity = CategoryEntity(name: category.name);
      categoryList.add(categoryEntity);
    });

    List<FoodsEntity> foodList = List<FoodsEntity>();
    restaurantData.restaurant.menus.foods.forEach((food) {
      var foodEntity = FoodsEntity(name: food.name);
      foodList.add(foodEntity);
    });

    List<DrinksEntity> drinkList = List<DrinksEntity>();
    restaurantData.restaurant.menus.drinks.forEach((drink) {
      var drinkEntity = DrinksEntity(name: drink.name);
      drinkList.add(drinkEntity);
    });

    List<ConsumerReviewEntity> consumerReviewList =
        List<ConsumerReviewEntity>();
    restaurantData.restaurant.consumerReviews.forEach((consumerReview) {
      var consumerReviewEntity = ConsumerReviewEntity(
          name: consumerReview.name,
          review: consumerReview.review,
          date: consumerReview.date);
      consumerReviewList.add(consumerReviewEntity);
    });

    var detailRestaurantEntity = DetailRestaurantEntity(
      error: restaurantData.error,
      message: restaurantData.message,
      id: restaurantData.restaurant.id,
      name: restaurantData.restaurant.name,
      description: restaurantData.restaurant.description,
      pictureId:
          "${ApiConstant.mediumImageResolution}${restaurantData.restaurant.pictureId}",
      city: restaurantData.restaurant.city,
      address: restaurantData.restaurant.address,
      rating: restaurantData.restaurant.rating.toString(),
      categories: categoryList,
      menus: MenusEntity(
        foods: foodList,
        drinks: drinkList,
      ),
      consumerReviews: consumerReviewList,
    );
    return detailRestaurantEntity;
  }
}