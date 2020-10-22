import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/domain/entity/detail_restaurant_entity.dart';
import 'package:restaurant_app/domain/repository/restaurant_repository.dart';
import 'package:restaurant_app/domain/usecase/get_restaurant_detail_usecase.dart';

class MockRestaurantRepository extends Mock implements RestaurantRepository {}

void main() {
  RestaurantRepository mockRestaurantRepository;
  GetRestaurantDetailUseCase getRestaurantDetailUseCase;

  setUp(() {
    mockRestaurantRepository = MockRestaurantRepository();
    getRestaurantDetailUseCase = GetRestaurantDetailUseCaseImpl(
        restaurantRepository: mockRestaurantRepository);
  });

  test(
      'use case call get restaurant detail method'
      'with restaurant id parameter should return detail restaurant entity',
      () async {
    DetailRestaurantEntity response;
    when(mockRestaurantRepository.getRestaurantDetail("id"))
        .thenAnswer((_) async => response);

    final result = await getRestaurantDetailUseCase.getRestaurantDetail('id');
    expect(result, response);
    verify(mockRestaurantRepository.getRestaurantDetail('id'));
    verifyNoMoreInteractions(mockRestaurantRepository);
  });
}
