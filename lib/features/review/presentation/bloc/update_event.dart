part of 'update_bloc.dart';

abstract class UpdateReviewEvent extends Equatable {
  const UpdateReviewEvent();

  @override
  List<Object> get props => [];
}

class UpdateReview extends UpdateReviewEvent {
  final ReviewEntity review;

  const UpdateReview({
    required this.review,
  });
  @override
  List<Object> get props => [review];
}
