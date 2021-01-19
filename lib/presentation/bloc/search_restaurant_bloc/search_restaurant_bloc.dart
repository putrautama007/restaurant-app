import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/domain/entity/restaurant_entity.dart';
import 'package:restaurant_app/domain/usecase/serch_restaurant_usecase.dart';

part 'search_restaurant_event.dart';

part 'search_restaurant_state.dart';

class SearchRestaurantBloc
    extends Bloc<SearchRestaurantEvent, SearchRestaurantState> {
  SearchRestaurantUseCase searchRestaurantUseCase;

  SearchRestaurantBloc({this.searchRestaurantUseCase})
      : super(SearchRestaurantInitialState());

  @override
  Stream<SearchRestaurantState> mapEventToState(
      SearchRestaurantEvent event) async* {
    if (event is SearchRestaurant) {
      yield SearchRestaurantLoadingState();
      var _listRestaurant = await searchRestaurantUseCase
          .getListRestaurantByName(event.searchText);
      yield SearchRestaurantLoadedState(listRestaurant: _listRestaurant);
    }
  }
}
