import 'package:equatable/equatable.dart';

class RestaurantListEntity extends Equatable {
  final bool error;
  final String message;
  final List<RestaurantEntity> restaurants;

  RestaurantListEntity({this.restaurants, this.message, this.error});

  @override
  List<Object> get props => [restaurants, message, error];
}

class RestaurantEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final String rating;
  final MenusEntity menus;

  RestaurantEntity(
      {this.id,
      this.name,
      this.description,
      this.pictureId,
      this.city,
      this.rating,
      this.menus});

  @override
  List<Object> get props =>
      [id, name, description, pictureId, city, rating, menus];
}

class MenusEntity extends Equatable {
  final List<FoodsEntity> foods;
  final List<DrinksEntity> drinks;

  MenusEntity({this.foods, this.drinks});

  @override
  List<Object> get props => [foods, drinks];
}

class FoodsEntity extends Equatable {
  final String name;

  FoodsEntity({this.name});

  @override
  List<Object> get props => [name];
}

class DrinksEntity extends Equatable {
  final String name;

  DrinksEntity({this.name});

  @override
  List<Object> get props => [name];
}
