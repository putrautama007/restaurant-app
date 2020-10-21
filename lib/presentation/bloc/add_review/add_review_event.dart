part of 'add_review_bloc.dart';

abstract class AddReviewEvent extends Equatable {
  const AddReviewEvent();
}

class AddReview extends AddReviewEvent {
  final String restaurantId;
  final String userName;
  final String review;

  AddReview(
      {@required this.restaurantId,
      @required this.userName,
      @required this.review});

  @override
  List<Object> get props => [restaurantId, userName, review];
}
