import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/domain/entity/restaurant_entity.dart';
import 'package:restaurant_app/domain/usecase/get_list_restaurant_usecase.dart';
import 'package:restaurant_app/presentation/bloc/restaurant_list_bloc/get_list_restaurant_bloc.dart';

class MockGetListRestaurantUseCase extends Mock
    implements GetListRestaurantUseCase {}

void main() {
  GetListRestaurantUseCase mockGetListRestaurantUseCase;

  setUp(() {
    mockGetListRestaurantUseCase = MockGetListRestaurantUseCase();
  });

  blocTest<GetListRestaurantBloc, GetListRestaurantState>(
    'get list restaurant bloc add event get list restaurant'
    'should return GetListRestaurantLoadingState, GetListRestaurantLoadedState ',
    build: () {
      RestaurantListEntity response = RestaurantListEntity(
        error: false,
        message: "message",
        restaurants: [
          RestaurantEntity(
            id: 'id',
            name: "name",
            rating: "rating",
            pictureId: "pictureId",
            description: 'description',
            city: 'city',
          ),
        ],
      );
      when(mockGetListRestaurantUseCase.getListRestaurant())
          .thenAnswer((_) async => response);
      return GetListRestaurantBloc(
          getListRestaurantUseCase: mockGetListRestaurantUseCase);
    },
    act: (bloc) => bloc.add(GetListRestaurant()),
    expect: [
      GetListRestaurantLoadingState(),
      GetListRestaurantLoadedState(
        listRestaurant: [
          RestaurantEntity(
            id: 'id',
            name: "name",
            rating: "rating",
            pictureId: "pictureId",
            description: 'description',
            city: 'city',
          ),
        ],
      ),
    ],
  );

  blocTest<GetListRestaurantBloc, GetListRestaurantState>(
    'get list restaurant bloc add event get list restaurant'
    'should return GetListRestaurantLoadingState, GetListRestaurantFailedState ',
    build: () {
      RestaurantListEntity response = RestaurantListEntity(
        error: true,
        message: "message",
        restaurants: [
          RestaurantEntity(
            id: 'id',
            name: "name",
            rating: "rating",
            pictureId: "pictureId",
            description: 'description',
            city: 'city',
          ),
        ],
      );
      when(mockGetListRestaurantUseCase.getListRestaurant())
          .thenAnswer((_) async => response);
      return GetListRestaurantBloc(
          getListRestaurantUseCase: mockGetListRestaurantUseCase);
    },
    act: (bloc) => bloc.add(GetListRestaurant()),
    expect: [
      GetListRestaurantLoadingState(),
      GetListRestaurantFailedState(message: "message"),
    ],
  );
}
