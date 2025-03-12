part of 'find_bloc.dart';

abstract class FindUserReviewsState extends Equatable {
  const FindUserReviewsState();

  @override
  List<Object> get props => [];
}

class FindUserReviewsInitial extends FindUserReviewsState {
  const FindUserReviewsInitial();
}

class FindUserReviewsLoading extends FindUserReviewsState {
  const FindUserReviewsLoading();
}

class FindUserReviewsError extends FindUserReviewsState {
  final Failure failure;

  const FindUserReviewsError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class FindUserReviewsDone extends FindUserReviewsState {
  final List<UserReviewEntity> reviews;

  const FindUserReviewsDone({required this.reviews});

  @override
  List<Object> get props => [reviews];
}
