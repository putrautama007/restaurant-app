import 'package:equatable/equatable.dart';

class DetailRestaurantEntity extends Equatable {
  final bool error;
  final String message;
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final String address;
  final String rating;
  final List<CategoryEntity> categories;
  final MenusEntity menus;
  final List<ConsumerReviewEntity> consumerReviews;

  DetailRestaurantEntity({
    required this.error,
    required this.message,
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.address,
    required this.rating,
    required this.categories,
    required this.menus,
    required this.consumerReviews,
  });

  @override
  List<Object> get props => [
        error,
        message,
        id,
        name,
        description,
        pictureId,
        city,
        address,
        rating,
        categories,
        menus,
        consumerReviews
      ];
}

class CategoryEntity extends Equatable {
  final String name;

  CategoryEntity({
    required this.name,
  });

  @override
  List<Object> get props => [name];
}

class MenusEntity extends Equatable {
  final List<FoodsEntity> foods;
  final List<DrinksEntity> drinks;

  MenusEntity({
    required this.foods,
    required this.drinks,
  });

  @override
  List<Object> get props => [foods, drinks];
}

class FoodsEntity extends Equatable {
  final String name;

  FoodsEntity({
    required this.name,
  });

  @override
  List<Object> get props => [name];
}

class DrinksEntity extends Equatable {
  final String name;

  DrinksEntity({
    required this.name,
  });

  @override
  List<Object> get props => [name];
}

class ConsumerReviewEntity extends Equatable {
  final String name;
  final String review;
  final String date;

  ConsumerReviewEntity({
    required this.name,
    required this.review,
    required this.date,
  });

  @override
  List<Object> get props => [
        name,
        review,
        date,
      ];
}
