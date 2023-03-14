import 'package:equatable/equatable.dart';

class RestaurantListModel extends Equatable {
  final List<RestaurantModel> restaurants;

  RestaurantListModel({
    required this.restaurants,
  });

  @override
  List<Object> get props => [
        restaurants,
      ];

  factory RestaurantListModel.fromJson(Map<String, dynamic> json) =>
      RestaurantListModel(
        restaurants: List<RestaurantModel>.from(
          json['restaurants'].map(
            (restaurant) => RestaurantModel.fromJson(
              restaurant,
            ),
          ),
        ),
      );
}

class RestaurantModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final String rating;
  final MenusModel menus;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  @override
  List<Object> get props => [
        id,
        name,
        description,
        pictureId,
        city,
        rating,
        menus,
      ];

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        pictureId: json['pictureId'],
        city: json['city'],
        rating: json['rating'].toString(),
        menus: MenusModel.fromJson(
          json['menus'],
        ),
      );
}

class MenusModel extends Equatable {
  final List<FoodsModel> foods;
  final List<DrinksModel> drinks;

  MenusModel({
    required this.foods,
    required this.drinks,
  });

  @override
  List<Object> get props => [foods, drinks];

  factory MenusModel.fromJson(Map<String, dynamic> json) => MenusModel(
        foods: List<FoodsModel>.from(
          json['foods'].map(
            (food) => FoodsModel.fromJson(
              food,
            ),
          ),
        ),
        drinks: List<DrinksModel>.from(
          json['drinks'].map(
            (drink) => DrinksModel.fromJson(
              drink,
            ),
          ),
        ),
      );
}

class FoodsModel extends Equatable {
  final String name;

  FoodsModel({
    required this.name,
  });

  @override
  List<Object> get props => [
        name,
      ];

  factory FoodsModel.fromJson(Map<String, dynamic> json) => FoodsModel(
        name: json['name'],
      );
}

class DrinksModel extends Equatable {
  final String name;

  DrinksModel({
    required this.name,
  });

  @override
  List<Object> get props => [
        name,
      ];

  factory DrinksModel.fromJson(Map<String, dynamic> json) => DrinksModel(
        name: json['name'],
      );
}
