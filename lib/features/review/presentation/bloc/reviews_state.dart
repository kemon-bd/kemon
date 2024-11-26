part of 'reviews_bloc.dart';

abstract class FindListingReviewsState extends Equatable {
  final List<int> filter;
  const FindListingReviewsState({
    this.filter = const [],
  });

  @override
  List<Object> get props => [filter];
}

class FindListingReviewsInitial extends FindListingReviewsState {
  const FindListingReviewsInitial() : super(filter: const []);

  @override
  List<Object> get props => [filter];
}

class FindListingReviewsLoading extends FindListingReviewsState {
  const FindListingReviewsLoading({
    required super.filter,
  });

  @override
  List<Object> get props => [filter];
}

class FindListingReviewsError extends FindListingReviewsState {
  final Failure failure;

  const FindListingReviewsError({
    required this.failure,
    required super.filter,
  });

  @override
  List<Object> get props => [failure, filter];
}

class FindListingReviewsDone extends FindListingReviewsState {
  final List<ReviewEntity> reviews;

  const FindListingReviewsDone({
    required this.reviews,
    required super.filter,
  });

  @override
  List<Object> get props => [reviews, filter];
}
