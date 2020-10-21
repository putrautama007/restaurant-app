import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_app/data/remote/datasource/api_constant.dart';
import 'package:restaurant_app/data/remote/model/list_restaurant_model.dart';

abstract class RemoteDataSource {
  Future<RestaurantListModel> getRestaurantList();
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
    // return await rootBundle
    //     .loadString('assets/data/local_restaurant.json')
    //     .then((localRestaurant) =>
    //         RestaurantListModel.fromJson(jsonDecode(localRestaurant)));
  }

  @override
  Future<RestaurantListModel> getRestaurantListByName() async{
    return await rootBundle
        .loadString('assets/data/local_restaurant.json')
        .then((localRestaurant) =>
        RestaurantListModel.fromJson(jsonDecode(localRestaurant)));
  }
}
