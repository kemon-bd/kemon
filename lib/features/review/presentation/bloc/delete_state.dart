part of 'delete_bloc.dart';

abstract class DeleteReviewState extends Equatable {
  const DeleteReviewState();

  @override
  List<Object> get props => [];
}

class DeleteReviewInitial extends DeleteReviewState {
  const DeleteReviewInitial();
}

class DeleteReviewLoading extends DeleteReviewState {
  const DeleteReviewLoading();
}

class DeleteReviewError extends DeleteReviewState {
  final Failure failure;

  const DeleteReviewError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class DeleteReviewDone extends DeleteReviewState {
  const DeleteReviewDone();

  @override
  List<Object> get props => [];
}
