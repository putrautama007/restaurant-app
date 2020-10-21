import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_app/data/remote/datasource/api_constant.dart';
import 'package:restaurant_app/data/remote/model/detail_restaurant_model.dart';
import 'package:restaurant_app/data/remote/model/list_restaurant_model.dart';

abstract class RemoteDataSource {
  Future<RestaurantListModel> getRestaurantList();
  Future<DetailRestaurantModel> getRestaurantDetail(String restaurantId);
  Future<RestaurantListModel> getRestaurantListByName();
}

class RemoteDataSourceImpl extends RemoteDataSource {
  Dio dio;

  RemoteDataSourceImpl({this.dio});

  @override
  Future<RestaurantListModel> getRestaurantList() async {
    try{
      Response _response = await dio.get(ApiConstant.listRestaurant);
      return RestaurantListModel.fromJson(_response.data);
    }on DioError catch (e){
      return RestaurantListModel.fromJson(e.response.data);
    }
  }

  @override
  Future<RestaurantListModel> getRestaurantListByName() async{
    return await rootBundle
        .loadString('assets/data/local_restaurant.json')
        .then((localRestaurant) =>
        RestaurantListModel.fromJson(jsonDecode(localRestaurant)));
  }

  @override
  Future<DetailRestaurantModel> getRestaurantDetail(String restaurantId) async{
    try{
      Response _response = await dio.get("${ApiConstant.detailRestaurant}$restaurantId");
      return DetailRestaurantModel.fromJson(_response.data);
    }on DioError catch (e){
      return DetailRestaurantModel.fromJson(e.response.data);
    }
  }
}
