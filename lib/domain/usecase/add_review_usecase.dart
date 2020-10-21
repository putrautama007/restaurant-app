import 'package:flutter/foundation.dart';
import 'package:restaurant_app/domain/entity/add_review_entity.dart';
import 'package:restaurant_app/domain/repository/restaurant_repository.dart';

abstract class AddReviewUseCase {
  Future<AddReviewsEntity> addReview(
      String restaurantId, String userName, String review);
}

class AddReviewUseCaseImpl extends AddReviewUseCase {
  RestaurantRepository restaurantRepository;

  AddReviewUseCaseImpl({@required this.restaurantRepository});

  @override
  Future<AddReviewsEntity> addReview(
          String restaurantId, String userName, String review) =>
      restaurantRepository.addReview(restaurantId, userName, review);
}
