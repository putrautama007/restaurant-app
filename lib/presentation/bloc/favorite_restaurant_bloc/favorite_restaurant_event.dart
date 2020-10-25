part of 'favorite_restaurant_bloc.dart';

abstract class FavoriteRestaurantEvent extends Equatable {
  const FavoriteRestaurantEvent();
}

class GetListFavoriteRestaurant extends FavoriteRestaurantEvent {
  @override
  List<Object> get props => [];
}

class GetListFavoriteRestaurantById extends FavoriteRestaurantEvent {
  final String id;

  GetListFavoriteRestaurantById({@required this.id});

  @override
  List<Object> get props => [id];
}

class InsertFavoriteRestaurant extends FavoriteRestaurantEvent {
  final RestaurantTableData restaurantTableData;

  InsertFavoriteRestaurant({@required this.restaurantTableData});

  @override
  List<Object> get props => [restaurantTableData];
}

class DeleteFavoriteRestaurant extends FavoriteRestaurantEvent {
  final RestaurantTableData restaurantTableData;

  DeleteFavoriteRestaurant({@required this.restaurantTableData});

  @override
  List<Object> get props => [restaurantTableData];
}
