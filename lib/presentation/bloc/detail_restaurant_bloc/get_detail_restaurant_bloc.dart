import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/domain/entity/detail_restaurant_entity.dart';
import 'package:restaurant_app/domain/usecase/get_restaurant_detail_usecase.dart';

part 'get_detail_restaurant_event.dart';

part 'get_detail_restaurant_state.dart';

class GetDetailRestaurantBloc
    extends Bloc<GetDetailRestaurantEvent, GetDetailRestaurantState> {
  GetRestaurantDetailUseCase getRestaurantDetailUseCase;

  GetDetailRestaurantBloc({required this.getRestaurantDetailUseCase})
      : super(GetDetailRestaurantInitialState()) {
    on<GetDetailRestaurant>((event, emit) async {
      emit(GetDetailRestaurantLoadingState());
      final detailRestaurant = await getRestaurantDetailUseCase
          .getRestaurantDetail(event.restaurantId);
      if (detailRestaurant.error != true) {
        emit(
            GetDetailRestaurantLoadedState(detailRestaurant: detailRestaurant));
      } else {
        emit(GetDetailRestaurantFailedState(message: detailRestaurant.message));
      }
    });
  }
}
