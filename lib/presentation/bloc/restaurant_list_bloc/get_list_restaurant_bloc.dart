import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/domain/entity/restaurant_entity.dart';
import 'package:restaurant_app/domain/usecase/get_list_restaurant_usecase.dart';

part 'get_list_restaurant_event.dart';

part 'get_list_restaurant_state.dart';

class GetListRestaurantBloc
    extends Bloc<GetListRestaurantEvent, GetListRestaurantState> {
  GetListRestaurantUseCase getListRestaurantUseCase;

  GetListRestaurantBloc({required this.getListRestaurantUseCase})
      : super(GetListRestaurantInitialState()) {
    on<GetListRestaurant>((event, emit) async {
      emit(GetListRestaurantLoadingState());
      final listRestaurant = await getListRestaurantUseCase.getListRestaurant();
      if (listRestaurant.error != true) {
        emit(GetListRestaurantLoadedState(
            listRestaurant: listRestaurant.restaurants));
      } else {
        emit(GetListRestaurantFailedState(message: listRestaurant.message));
      }
    });
  }
}
