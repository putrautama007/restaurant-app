import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/domain/entity/restaurant_entity.dart';
import 'package:restaurant_app/domain/usecase/search_restaurant_usecase.dart';
import 'package:restaurant_app/presentation/bloc/search_restaurant_bloc/search_restaurant_bloc.dart';

class MockSearchRestaurantUseCase extends Mock
    implements SearchRestaurantUseCase {}

void main() {
  SearchRestaurantUseCase mockSearchRestaurantUseCase;

  setUp(() {
    mockSearchRestaurantUseCase = MockSearchRestaurantUseCase();
  });

  blocTest<SearchRestaurantBloc, SearchRestaurantState>(
    'search restaurant  bloc add event search restaurant with restaurant name'
    ' should return SearchRestaurantLoadingState, SearchRestaurantLoadedState ',
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
      when(mockSearchRestaurantUseCase.searchRestaurant("restaurant"))
          .thenAnswer((_) async => response);
      return SearchRestaurantBloc(
          searchRestaurantUseCase: mockSearchRestaurantUseCase);
    },
    act: (bloc) => bloc.add(SearchRestaurant(searchText: 'restaurant')),
    expect: [
      SearchRestaurantLoadingState(),
      SearchRestaurantLoadedState(
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

  blocTest<SearchRestaurantBloc, SearchRestaurantState>(
    'search restaurant  bloc add event search restaurant with restaurant name'
    ' should return SearchRestaurantLoadingState, SearchRestaurantFailedState ',
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
      when(mockSearchRestaurantUseCase.searchRestaurant("restaurant"))
          .thenAnswer((_) async => response);
      return SearchRestaurantBloc(
          searchRestaurantUseCase: mockSearchRestaurantUseCase);
    },
    act: (bloc) => bloc.add(SearchRestaurant(searchText: 'restaurant')),
    expect: [
      SearchRestaurantLoadingState(),
      SearchRestaurantFailedState(message: "message"),
    ],
  );
}
