import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/domain/entity/add_review_entity.dart';
import 'package:restaurant_app/domain/repository/restaurant_repository.dart';
import 'package:restaurant_app/domain/usecase/add_review_usecase.dart';

class MockRestaurantRepository extends Mock implements RestaurantRepository {}

void main() {
  RestaurantRepository mockRestaurantRepository;
  AddReviewUseCase addReviewUseCase;

  setUp(() {
    mockRestaurantRepository = MockRestaurantRepository();
    addReviewUseCase =
        AddReviewUseCaseImpl(restaurantRepository: mockRestaurantRepository);
  });

  test(
      'use case call add review method'
      'with restaurant id, user name, and review parameter should return object add review entity',
      () async {
    AddReviewsEntity response;
    when(mockRestaurantRepository.addReview(
            "rqdv5juczeskfw1e867", "Putra Utama", "makanannya enak"))
        .thenAnswer((_) async => response);

    final result = await addReviewUseCase.addReview(
        "rqdv5juczeskfw1e867", "Putra Utama", "makanannya enak");
    expect(result, response);
    verify(mockRestaurantRepository.addReview(
        "rqdv5juczeskfw1e867", "Putra Utama", "makanannya enak"));
    verifyNoMoreInteractions(mockRestaurantRepository);
  });
}
