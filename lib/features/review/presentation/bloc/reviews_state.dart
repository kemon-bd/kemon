part of 'reviews_bloc.dart';

abstract class FindListingReviewsState extends Equatable {
  const FindListingReviewsState();

  @override
  List<Object> get props => [];
}

class FindListingReviewsInitial extends FindListingReviewsState {
  const FindListingReviewsInitial();
}

class FindListingReviewsLoading extends FindListingReviewsState {
  const FindListingReviewsLoading();
}

class FindListingReviewsError extends FindListingReviewsState {
  final Failure failure;

  const FindListingReviewsError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class FindListingReviewsDone extends FindListingReviewsState {
  final List<ReviewEntity> reviews;

  const FindListingReviewsDone({required this.reviews});

  @override
  List<Object> get props => [reviews];
}
