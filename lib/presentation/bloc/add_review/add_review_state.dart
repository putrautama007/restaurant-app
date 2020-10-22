part of 'add_review_bloc.dart';

abstract class AddReviewState extends Equatable {
  const AddReviewState();
}

class AddReviewInitialState extends AddReviewState {
  @override
  List<Object> get props => [];
}

class AddReviewLoadingState extends AddReviewState {
  @override
  List<Object> get props => [];
}

class AddReviewSuccessState extends AddReviewState {
  @override
  List<Object> get props => [];
}

class AddReviewNameEmptyState extends AddReviewState {
  @override
  List<Object> get props => [];
}

class AddReviewReviewEmptyState extends AddReviewState {
  @override
  List<Object> get props => [];
}

class AddReviewFailedState extends AddReviewState {
  @override
  List<Object> get props => [];
}
