import 'package:equatable/equatable.dart';

class RestaurantListEntity extends Equatable {
  final List<RestaurantEntity> restaurants;

  RestaurantListEntity({
    required this.restaurants,
  });

  @override
  List<Object> get props => [
        restaurants,
      ];
}

class RestaurantEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final String rating;
  final MenusEntity menus;

  RestaurantEntity({
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
}

class MenusEntity extends Equatable {
  final List<FoodsEntity> foods;
  final List<DrinksEntity> drinks;

  MenusEntity({
    required this.foods,
    required this.drinks,
  });

  @override
  List<Object> get props => [
        foods,
        drinks,
      ];
}

class FoodsEntity extends Equatable {
  final String name;

  FoodsEntity({
    required this.name,
  });

  @override
  List<Object> get props => [
        name,
      ];
}

class DrinksEntity extends Equatable {
  final String name;

  DrinksEntity({
    required this.name,
  });

  @override
  List<Object> get props => [
        name,
      ];
}
