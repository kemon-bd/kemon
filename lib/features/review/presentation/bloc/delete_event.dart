part of 'delete_bloc.dart';

abstract class DeleteReviewEvent extends Equatable {
  const DeleteReviewEvent();

  @override
  List<Object> get props => [];
}

class DeleteReview extends DeleteReviewEvent {
  final Identity review;

  const DeleteReview({
    required this.review,
  });
  @override
  List<Object> get props => [review];
}
