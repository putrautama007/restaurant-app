part of 'get_list_restaurant_bloc.dart';

abstract class GetListRestaurantState extends Equatable {
  const GetListRestaurantState();
}

class GetListRestaurantInitialState extends GetListRestaurantState {
  @override
  List<Object> get props => [];
}

class GetListRestaurantLoadingState extends GetListRestaurantState {
  @override
  List<Object> get props => [];
}

class GetListRestaurantLoadedState extends GetListRestaurantState {
  final List<RestaurantEntity> listRestaurant;

  GetListRestaurantLoadedState({required this.listRestaurant});

  @override
  List<Object> get props => [listRestaurant];
}

class GetListRestaurantFailedState extends GetListRestaurantState {
  final String message;

  GetListRestaurantFailedState({required this.message});

  @override
  List<Object> get props => [message];
}
