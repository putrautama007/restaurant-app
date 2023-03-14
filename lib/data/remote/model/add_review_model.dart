import 'package:equatable/equatable.dart';

class AddReviewsModel extends Equatable {
  final bool error;
  final String message;

  AddReviewsModel({required this.error, required this.message});

  @override
  List<Object> get props => [error];

  factory AddReviewsModel.fromJson(Map<String, dynamic> json) =>
      AddReviewsModel(
        error: json['error'] ?? false,
        message: json['message'] ?? "",
      );
}
