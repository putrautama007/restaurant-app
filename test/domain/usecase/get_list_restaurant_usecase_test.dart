import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/domain/entity/restaurant_entity.dart';
import 'package:restaurant_app/domain/repository/restaurant_repository.dart';
import 'package:restaurant_app/domain/usecase/get_list_restaurant_usecase.dart';

class MockRestaurantRepository extends Mock implements RestaurantRepository {}

void main() {
  RestaurantRepository mockRestaurantRepository;
  GetListRestaurantUseCase getListRestaurantUseCase;

  setUp(() {
    mockRestaurantRepository = MockRestaurantRepository();
    getListRestaurantUseCase = GetListRestaurantUseCaseImpl(
        restaurantRepository: mockRestaurantRepository);
  });

  test(
      'use case call get list restaurant method'
      ' should return restaurant list entity', () async {
    RestaurantListEntity response;
    when(mockRestaurantRepository.getListRestaurant())
        .thenAnswer((_) async => response);

    final result = await getListRestaurantUseCase.getListRestaurant();
    expect(result, response);
    verify(mockRestaurantRepository.getListRestaurant());
    verifyNoMoreInteractions(mockRestaurantRepository);
  });
}
