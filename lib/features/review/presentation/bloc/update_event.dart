part of 'update_bloc.dart';

abstract class UpdateReviewEvent extends Equatable {
  const UpdateReviewEvent();

  @override
  List<Object> get props => [];
}

class UpdateReview extends UpdateReviewEvent {
  final Identity listing;
  final List<XFile> attachments;
  final ReviewEntity review;

  const UpdateReview({
    required this.review,
    required this.listing,
    required this.attachments,
  });
  @override
  List<Object> get props => [review, listing, attachments];
}
