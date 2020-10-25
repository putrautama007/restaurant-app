part of 'favorite_restaurant_bloc.dart';

abstract class FavoriteRestaurantState extends Equatable {
  const FavoriteRestaurantState();
}

class FavoriteRestaurantInitialState extends FavoriteRestaurantState {
  @override
  List<Object> get props => [];
}

class FavoriteRestaurantLoadingState extends FavoriteRestaurantState {
  @override
  List<Object> get props => [];
}

class FavoriteRestaurantFailedState extends FavoriteRestaurantState {
  @override
  List<Object> get props => [];
}

class FavoriteRestaurantSuccessGetListState extends FavoriteRestaurantState {
  final List<RestaurantTableData> listRestaurantTableData;

  FavoriteRestaurantSuccessGetListState(
      {@required this.listRestaurantTableData});

  @override
  List<Object> get props => [listRestaurantTableData];
}

class FavoriteRestaurantSuccessGetListByIdState
    extends FavoriteRestaurantState {
  final RestaurantTableData restaurantTableData;

  FavoriteRestaurantSuccessGetListByIdState(
      {@required this.restaurantTableData});

  @override
  List<Object> get props => [restaurantTableData];
}

class FavoriteRestaurantSuccessInsertState extends FavoriteRestaurantState {
  @override
  List<Object> get props => [];
}

class FavoriteRestaurantSuccessDeleteState extends FavoriteRestaurantState {
  @override
  List<Object> get props => [];
}
