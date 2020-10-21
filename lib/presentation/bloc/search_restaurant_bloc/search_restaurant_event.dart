part of 'search_restaurant_bloc.dart';

abstract class SearchRestaurantEvent extends Equatable {
  const SearchRestaurantEvent();
}

class SearchRestaurant extends SearchRestaurantEvent {
  final String searchText;

  SearchRestaurant({this.searchText});

  @override
  List<Object> get props => [];
}
