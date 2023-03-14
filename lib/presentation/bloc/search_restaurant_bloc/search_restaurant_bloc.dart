import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/domain/entity/restaurant_entity.dart';
import 'package:restaurant_app/domain/usecase/serch_restaurant_usecase.dart';

part 'search_restaurant_event.dart';

part 'search_restaurant_state.dart';

class SearchRestaurantBloc
    extends Bloc<SearchRestaurantEvent, SearchRestaurantState> {
  SearchRestaurantUseCase searchRestaurantUseCase;

  SearchRestaurantBloc({required this.searchRestaurantUseCase})
      : super(SearchRestaurantInitialState()) {
    on<SearchRestaurant>((event, emit) async {
      emit(SearchRestaurantLoadingState());
      final _listRestaurant = await searchRestaurantUseCase
          .getListRestaurantByName(event.searchText);
      emit(SearchRestaurantLoadedState(listRestaurant: _listRestaurant));
    });
  }
}
