part of 'details_bloc.dart';

abstract class FindReviewDetailsState extends Equatable {
  const FindReviewDetailsState();

  @override
  List<Object> get props => [];
}

class FindReviewDetailsInitial extends FindReviewDetailsState {
  const FindReviewDetailsInitial();
}

class FindReviewDetailsLoading extends FindReviewDetailsState {
  const FindReviewDetailsLoading();
}

class FindReviewDetailsError extends FindReviewDetailsState {
  final Failure failure;

  const FindReviewDetailsError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class FindReviewDetailsDone extends FindReviewDetailsState {
  final ReviewDetailsEntity review;

  const FindReviewDetailsDone({required this.review});

  @override
  List<Object> get props => [review];
}
