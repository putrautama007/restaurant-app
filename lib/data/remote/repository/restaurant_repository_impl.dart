import 'package:restaurant_app/data/remote/datasource/api_constant.dart';
import 'package:restaurant_app/data/remote/datasource/remote_data_source.dart';
import 'package:restaurant_app/domain/entity/add_review_entity.dart';
import 'package:restaurant_app/domain/entity/detail_restaurant_entity.dart';
import 'package:restaurant_app/domain/entity/restaurant_entity.dart';
import 'package:restaurant_app/domain/repository/restaurant_repository.dart';

class RestaurantRepositoryIml extends RestaurantRepository {
  RemoteDataSource remoteDataSource;

  RestaurantRepositoryIml({required this.remoteDataSource});

  @override
  Future<RestaurantListEntity> getListRestaurant() async {
    List<RestaurantEntity> listRestaurant = [];
    var restaurantData = await remoteDataSource.getRestaurantList();
    restaurantData.restaurants.forEach((restaurant) {
      var restaurantEntity = RestaurantEntity(
          id: restaurant.id,
          name: restaurant.name,
          description: restaurant.description,
          pictureId: "${ApiConstant.smallImageResolution}${restaurant.pictureId}",
          city: restaurant.city,
          rating: restaurant.rating.toString());
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
  Future<RestaurantListEntity> searchRestaurant(String restaurantName) async {
    List<RestaurantEntity> listRestaurant = [];
    listRestaurant.clear();
    var restaurantData = await remoteDataSource.searchRestaurant(restaurantName);
    restaurantData.restaurants.forEach((restaurant) {
      var restaurantEntity = RestaurantEntity(
          id: restaurant.id,
          name: restaurant.name,
          description: restaurant.description,
          pictureId: "${ApiConstant.smallImageResolution}${restaurant.pictureId}",
          city: restaurant.city,
          rating: restaurant.rating.toString());
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
  Future<DetailRestaurantEntity> getRestaurantDetail(String restaurantId) async {
    var restaurantData = await remoteDataSource.getRestaurantDetail(restaurantId);
    List<CategoryEntity> categoryList = [];
    restaurantData.restaurant.categories.forEach((category) {
      var categoryEntity = CategoryEntity(name: category.name);
      categoryList.add(categoryEntity);
    });

    List<FoodsEntity> foodList = [];
    restaurantData.restaurant.menus.foods.forEach((food) {
      var foodEntity = FoodsEntity(name: food.name);
      foodList.add(foodEntity);
    });

    List<DrinksEntity> drinkList = [];
    restaurantData.restaurant.menus.drinks.forEach((drink) {
      var drinkEntity = DrinksEntity(name: drink.name);
      drinkList.add(drinkEntity);
    });

    List<ConsumerReviewEntity> consumerReviewList = [];
    restaurantData.restaurant.consumerReviews.forEach((consumerReview) {
      var consumerReviewEntity = ConsumerReviewEntity(
          name: consumerReview.name, review: consumerReview.review, date: consumerReview.date);
      consumerReviewList.add(consumerReviewEntity);
    });

    var detailRestaurantEntity = DetailRestaurantEntity(
      error: restaurantData.error,
      message: restaurantData.message,
      id: restaurantData.restaurant.id,
      name: restaurantData.restaurant.name,
      description: restaurantData.restaurant.description,
      pictureId: "${ApiConstant.smallImageResolution}${restaurantData.restaurant.pictureId}",
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

  @override
  Future<AddReviewsEntity> addReview(String restaurantId, String userName, String review) async {
    var consumerReview = await remoteDataSource.addReview(restaurantId, userName, review);
    var consumerReviewEntity =
        AddReviewsEntity(error: consumerReview.error, message: consumerReview.message);

    return consumerReviewEntity;
  }
}
