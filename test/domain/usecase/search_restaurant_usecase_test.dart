import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/domain/entity/restaurant_entity.dart';
import 'package:restaurant_app/domain/repository/restaurant_repository.dart';
import 'package:restaurant_app/domain/usecase/search_restaurant_usecase.dart';

class MockRestaurantRepository extends Mock implements RestaurantRepository {}

void main() {
  RestaurantRepository mockRestaurantRepository;
  SearchRestaurantUseCase searchRestaurantUseCase;

  setUp(() {
    mockRestaurantRepository = MockRestaurantRepository();
    searchRestaurantUseCase = SearchRestaurantUseCaseImpl(
        restaurantRepository: mockRestaurantRepository);
  });

  test(
      'use case call search restaurant method'
      'with restaurant name parameter should return restaurant list entity',
      () async {
    RestaurantListEntity response;
    when(mockRestaurantRepository.searchRestaurant('restaurant name'))
        .thenAnswer((_) async => response);

    final result =
        await searchRestaurantUseCase.searchRestaurant('restaurant name');
    expect(result, response);
    verify(mockRestaurantRepository.searchRestaurant('restaurant name'));
    verifyNoMoreInteractions(mockRestaurantRepository);
  });
}
