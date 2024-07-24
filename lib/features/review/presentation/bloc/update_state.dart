part of 'update_bloc.dart';

abstract class UpdateReviewState extends Equatable {
  const UpdateReviewState();

  @override
  List<Object> get props => [];
}

class UpdateReviewInitial extends UpdateReviewState {
  const UpdateReviewInitial();
}

class UpdateReviewLoading extends UpdateReviewState {
  const UpdateReviewLoading();
}

class UpdateReviewError extends UpdateReviewState {
  final Failure failure;

  const UpdateReviewError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class UpdateReviewDone extends UpdateReviewState {
  const UpdateReviewDone();

  @override
  List<Object> get props => [];
}
