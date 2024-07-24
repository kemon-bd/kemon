part of 'find_bloc.dart';

abstract class FindReviewState extends Equatable {
  const FindReviewState();

  @override
  List<Object> get props => [];
}

class FindReviewInitial extends FindReviewState {
  const FindReviewInitial();
}

class FindReviewLoading extends FindReviewState {
  const FindReviewLoading();
}

class FindReviewError extends FindReviewState {
  final Failure failure;

  const FindReviewError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class FindReviewDone extends FindReviewState {
  final List<ReviewEntity> reviews;

  const FindReviewDone({required this.reviews});

  @override
  List<Object> get props => [reviews];
}
