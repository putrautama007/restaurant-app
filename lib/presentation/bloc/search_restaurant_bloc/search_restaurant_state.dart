part of 'search_restaurant_bloc.dart';

abstract class SearchRestaurantState extends Equatable {
  const SearchRestaurantState();
}

class SearchRestaurantInitialState extends SearchRestaurantState {
  @override
  List<Object> get props => [];
}

class SearchRestaurantLoadingState extends SearchRestaurantState {
  @override
  List<Object> get props => [];
}

class SearchRestaurantLoadedState extends SearchRestaurantState {
  final List<RestaurantEntity> listRestaurant;

  SearchRestaurantLoadedState({this.listRestaurant});

  @override
  List<Object> get props => [listRestaurant];
}
