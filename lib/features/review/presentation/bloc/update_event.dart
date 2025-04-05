part of 'update_bloc.dart';

abstract class UpdateReviewEvent extends Equatable {
  const UpdateReviewEvent();

  @override
  List<Object> get props => [];
}

class UpdateReview extends UpdateReviewEvent {
  final List<String> photos;
  final List<XFile> attachments;
  final ReviewCoreEntity review;

  const UpdateReview({
    required this.review,
    required this.photos,
    required this.attachments,
  });
  @override
  List<Object> get props => [review, photos, attachments];
}
