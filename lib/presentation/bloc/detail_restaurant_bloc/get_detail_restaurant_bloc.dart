import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/domain/entity/detail_restaurant_entity.dart';
import 'package:restaurant_app/domain/usecase/get_restaurant_detail_usecase.dart';

part 'get_detail_restaurant_event.dart';

part 'get_detail_restaurant_state.dart';

class GetDetailRestaurantBloc
    extends Bloc<GetDetailRestaurantEvent, GetDetailRestaurantState> {
  GetRestaurantDetailUseCase getRestaurantDetailUseCase;

  GetDetailRestaurantBloc({this.getRestaurantDetailUseCase})
      : super(GetDetailRestaurantInitialState());

  @override
  Stream<GetDetailRestaurantState> mapEventToState(
      GetDetailRestaurantEvent event) async* {
    if (event is GetDetailRestaurant) {
      yield GetDetailRestaurantLoadingState();
      var detailRestaurant = await getRestaurantDetailUseCase
          .getRestaurantDetail(event.restaurantId);
      if (detailRestaurant.error != true) {
        yield GetDetailRestaurantLoadedState(
            detailRestaurant: detailRestaurant);
      } else {
        yield GetDetailRestaurantFailedState(message: detailRestaurant.message);
      }
    }
  }
}
