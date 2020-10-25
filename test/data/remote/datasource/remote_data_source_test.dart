import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/remote/datasource/remote_data_source.dart';
import 'package:restaurant_app/data/remote/model/add_review_model.dart';
import 'package:restaurant_app/data/remote/model/detail_restaurant_model.dart';
import 'package:restaurant_app/data/remote/model/list_restaurant_model.dart';

class DioAdapterMock extends Mock implements HttpClientAdapter {}

void main() {
  Dio dio;
  DioAdapterMock dioAdapterMock;
  RemoteDataSource remoteDataSource;

  setUp(() {
    dio = Dio();
    dioAdapterMock = DioAdapterMock();
    dio.httpClientAdapter = dioAdapterMock;
    remoteDataSource = RemoteDataSourceImpl(dio: dio);
  });

  group('remote data source test', () {
    test(
        'remote data source call method get restaurant list should return list restaurant',
        () async {
      final responsePayload = jsonEncode({
        "error": false,
        "message": "success",
        "count": 20,
        "restaurants": [
          {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description":
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2
          }
        ]
      });
      final httpResponse =
          ResponseBody.fromString(responsePayload, 200, headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType]
      });
      when(dioAdapterMock.fetch(any, any, any))
          .thenAnswer((_) async => httpResponse);

      final response = await remoteDataSource.getRestaurantList();

      expect(response, isA<RestaurantListModel>());
    });

    test(
        'remote data source call method search restaurant'
        'with restaurant name parameter should return list restaurant',
        () async {
      final responsePayload = jsonEncode({
        "error": false,
        "message": "success",
        "count": 20,
        "restaurants": [
          {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description":
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2
          }
        ]
      });
      final httpResponse =
          ResponseBody.fromString(responsePayload, 200, headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType]
      });
      when(dioAdapterMock.fetch(any, any, any))
          .thenAnswer((_) async => httpResponse);

      final response = await remoteDataSource.searchRestaurant("Melting Pot");

      expect(response, isA<RestaurantListModel>());
    });

    test(
        'remote data source call method get restaurant detail'
        'with restaurant id parameter should return restaurant data', () async {
      final responsePayload = jsonEncode({
        "error": false,
        "message": "success",
        "restaurant": {
          "id": "rqdv5juczeskfw1e867",
          "name": "Melting Pot",
          "description":
              "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
          "city": "Medan",
          "address": "Jln. Pandeglang no 19",
          "pictureId": "14",
          "categories": [
            {"name": "Italia"},
            {"name": "Modern"}
          ],
          "menus": {
            "foods": [
              {"name": "Paket rosemary"},
              {"name": "Toastie salmon"}
            ],
            "drinks": [
              {"name": "Es krim"},
              {"name": "Sirup"}
            ]
          },
          "rating": 4.2,
          "consumerReviews": [
            {
              "name": "Ahmad",
              "review": "Tidak rekomendasi untuk pelajar!",
              "date": "13 November 2019"
            },
            {
              "name": "BangJago",
              "review": "Punten numpang e2e test",
              "date": "22 Oktober 2020"
            },
          ]
        }
      });
      final httpResponse =
          ResponseBody.fromString(responsePayload, 200, headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType]
      });
      when(dioAdapterMock.fetch(any, any, any))
          .thenAnswer((_) async => httpResponse);

      final response =
          await remoteDataSource.getRestaurantDetail("rqdv5juczeskfw1e867");

      expect(response, isA<DetailRestaurantModel>());
    });

    test(
        'remote data source call method add review'
        'with restaurant id, user name, and comment parameter should return review status',
        () async {
      final responsePayload =
          jsonEncode({"error": false, "message": "success"});
      final httpResponse =
          ResponseBody.fromString(responsePayload, 200, headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType]
      });
      when(dioAdapterMock.fetch(any, any, any))
          .thenAnswer((_) async => httpResponse);

      final response = await remoteDataSource.addReview(
          "rqdv5juczeskfw1e867", "Putra Utama", "makanannya enak");

      expect(response, isA<AddReviewsModel>());
    });
  });
}
