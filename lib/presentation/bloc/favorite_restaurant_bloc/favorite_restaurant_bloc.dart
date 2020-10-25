import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/local/model/restaurant_table.dart';
import 'package:restaurant_app/domain/usecase/favorite_resaturant_usecase.dart';

part 'favorite_restaurant_event.dart';

part 'favorite_restaurant_state.dart';

class FavoriteRestaurantBloc
    extends Bloc<FavoriteRestaurantEvent, FavoriteRestaurantState> {
  FavoriteRestaurantUseCase favoriteRestaurantUseCase;

  FavoriteRestaurantBloc({@required this.favoriteRestaurantUseCase})
      : super(FavoriteRestaurantInitialState());

  @override
  Stream<FavoriteRestaurantState> mapEventToState(
      FavoriteRestaurantEvent event) async* {
    if (event is GetListFavoriteRestaurant) {
      yield FavoriteRestaurantLoadingState();
      var listFavoriteRestaurant =
          await favoriteRestaurantUseCase.getFavoriteRestaurantList();
      if (listFavoriteRestaurant.isEmpty) {
        yield FavoriteRestaurantFailedState();
      } else {
        yield FavoriteRestaurantSuccessGetListState(
            listRestaurantTableData: listFavoriteRestaurant);
      }
    } else if (event is GetListFavoriteRestaurantById) {
      yield FavoriteRestaurantLoadingState();
      var favoriteRestaurant =
          await favoriteRestaurantUseCase.getFavoriteRestaurantById(event.id);
      if (favoriteRestaurant != null) {
        yield FavoriteRestaurantSuccessGetListByIdState(
            restaurantTableData: favoriteRestaurant);
      } else {
        yield FavoriteRestaurantFailedState();
      }
    } else if (event is InsertFavoriteRestaurant) {
      try {
        yield FavoriteRestaurantLoadingState();
        await favoriteRestaurantUseCase
            .insertFavoriteRestaurant(event.restaurantTableData);
        yield FavoriteRestaurantSuccessInsertState();
      } catch (e) {
        yield FavoriteRestaurantFailedState();
      }
    } else if (event is DeleteFavoriteRestaurant) {
      try {
        yield FavoriteRestaurantLoadingState();
        await favoriteRestaurantUseCase
            .deleteFavoriteRestaurant(event.restaurantTableData);
        yield FavoriteRestaurantSuccessDeleteState();
      } catch (e) {
        yield FavoriteRestaurantFailedState();
      }
    }
  }
}
