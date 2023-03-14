import 'package:dio/dio.dart';
import 'package:restaurant_app/data/remote/datasource/api_constant.dart';
import 'package:restaurant_app/data/remote/model/add_review_model.dart';
import 'package:restaurant_app/data/remote/model/detail_restaurant_model.dart';
import 'package:restaurant_app/data/remote/model/list_restaurant_model.dart';

abstract class RemoteDataSource {
  Future<RestaurantListModel> getRestaurantList();

  Future<DetailRestaurantModel> getRestaurantDetail(String restaurantId);

  Future<RestaurantListModel> searchRestaurant(String restaurantName);

  Future<AddReviewsModel> addReview(
      String restaurantId, String userName, String review);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  Dio dio;

  RemoteDataSourceImpl({required this.dio});

  @override
  Future<RestaurantListModel> getRestaurantList() async {
    try {
      Response _response = await dio.get(ApiConstant.listRestaurant);
      return RestaurantListModel.fromJson(_response.data);
    } on DioError catch (e) {
      return RestaurantListModel.fromJson(e.response!.data);
    }
  }

  @override
  Future<RestaurantListModel> searchRestaurant(String restaurantName) async {
    try {
      Response _response =
          await dio.get("${ApiConstant.searchRestaurant}$restaurantName");
      return RestaurantListModel.fromJson(_response.data);
    } on DioError catch (e) {
      return RestaurantListModel.fromJson(e.response!.data);
    }
  }

  @override
  Future<DetailRestaurantModel> getRestaurantDetail(String restaurantId) async {
    try {
      Response _response =
          await dio.get("${ApiConstant.detailRestaurant}$restaurantId");
      return DetailRestaurantModel.fromJson(_response.data);
    } on DioError catch (e) {
      return DetailRestaurantModel.fromJson(e.response!.data);
    }
  }

  @override
  Future<AddReviewsModel> addReview(
      String restaurantId, String userName, String review) async {
    try {
      var body = {"id": restaurantId, "name": userName, "review": review};
      var header = {"X-Auth-Token": "12345"};
      Response _response = await dio.post("${ApiConstant.reviewRestaurant}",
          data: body,
          options: Options(
            method: "POST",
            contentType: Headers.jsonContentType,
            headers: header,
          ));
      return AddReviewsModel.fromJson(_response.data);
    } on DioError catch (e) {
      return AddReviewsModel.fromJson(e.response!.data);
    }
  }
}
