import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/domain/entity/restaurant_entity.dart';
import 'package:restaurant_app/domain/usecase/get_list_restaurant_usecase.dart';

part 'get_list_restaurant_event.dart';

part 'get_list_restaurant_state.dart';

class GetListRestaurantBloc
    extends Bloc<GetListRestaurantEvent, GetListRestaurantState> {
  GetListRestaurantUseCase getListRestaurantUseCase;

  GetListRestaurantBloc({this.getListRestaurantUseCase})
      : super(GetListRestaurantInitialState());

  @override
  Stream<GetListRestaurantState> mapEventToState(
      GetListRestaurantEvent event) async* {
    if (event is GetListRestaurant) {
      yield GetListRestaurantLoadingState();
      var _listRestaurant = await getListRestaurantUseCase.getListRestaurant();
      yield GetListRestaurantLoadedState(listRestaurant: _listRestaurant);
    }
  }
}
