import 'package:equatable/equatable.dart';

class RestaurantListModel extends Equatable {
  final bool error;
  final String message;
  final int count;
  final int found;
  final List<RestaurantModel> restaurants;

  RestaurantListModel({this.restaurants,this.error,this.message,this.count,this.found});

  @override
  List<Object> get props => [restaurants,error,message,count,found];

  factory RestaurantListModel.fromJson(Map<String, dynamic> json) =>
      RestaurantListModel(
        error: json['error'],
        message: json['message'] ?? "",
        count: json['count'] ?? 0,
        found: json['found'] ?? 0,
        restaurants: List<RestaurantModel>.from(json['restaurants']
            .map((restaurant) => RestaurantModel.fromJson(restaurant))),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RestaurantModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  RestaurantModel(
      {this.id,
      this.name,
      this.description,
      this.pictureId,
      this.city,
      this.rating});

  @override
  List<Object> get props =>
      [id, name, description, pictureId, city, rating];

  factory RestaurantModel.fromJson(Map<String, dynamic> json) => RestaurantModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        pictureId: json['pictureId'],
        city: json['city'],
        rating: json['rating'].toDouble(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['pictureId'] = this.pictureId;
    data['city'] = this.city;
    data['rating'] = this.rating;
    return data;
  }
}