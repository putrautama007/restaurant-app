import 'package:equatable/equatable.dart';

class AddReviewsEntity extends Equatable {
  final bool error;
  final String message;

  AddReviewsEntity({this.error, this.message});

  @override
  List<Object> get props => [error, message];
}
