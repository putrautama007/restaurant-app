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

  RestaurantEntity(
      {this.id,
      this.name,
      this.description,
      this.pictureId,
      this.city,
      this.rating});

  @override
  List<Object> get props => [id, name, description, pictureId, city, rating];
}
