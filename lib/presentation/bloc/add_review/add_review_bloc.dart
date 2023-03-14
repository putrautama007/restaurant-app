import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/domain/usecase/add_review_usecase.dart';

part 'add_review_event.dart';

part 'add_review_state.dart';

class AddReviewBloc extends Bloc<AddReviewEvent, AddReviewState> {
  AddReviewUseCase addReviewUseCase;

  AddReviewBloc({required this.addReviewUseCase})
      : super(AddReviewInitialState()) {
    on<AddReview>(
      (event, emit) async {
        emit(AddReviewLoadingState());
        if (event.userName.isNotEmpty && event.review.isNotEmpty) {
          var listRestaurant = await addReviewUseCase.addReview(
              event.restaurantId, event.userName, event.review);
          if (listRestaurant.error != true) {
            emit(AddReviewSuccessState());
          } else {
            emit(AddReviewFailedState());
          }
        } else if (event.userName.isEmpty) {
          emit(AddReviewNameEmptyState());
        } else if (event.review.isEmpty) {
          emit(AddReviewReviewEmptyState());
        }
      },
    );
  }
}
