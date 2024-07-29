part of 'recent_bloc.dart';

sealed class RecentReviewsState extends Equatable {
  const RecentReviewsState();

  @override
  List<Object> get props => [];
}

final class RecentReviewsInitial extends RecentReviewsState {}

final class RecentReviewsError extends RecentReviewsState {
  final Failure failure;

  const RecentReviewsError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

final class RecentReviewsLoading extends RecentReviewsState {
  const RecentReviewsLoading();

  @override
  List<Object> get props => [];
}

final class RecentReviewsDone extends RecentReviewsState {
  final List<ReviewEntity> reviews;

  const RecentReviewsDone({
    required this.reviews,
  });

  @override
  List<Object> get props => [reviews];
}
