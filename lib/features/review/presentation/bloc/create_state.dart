part of 'create_bloc.dart';

abstract class CreateReviewState extends Equatable {
  const CreateReviewState();

  @override
  List<Object> get props => [];
}

class CreateReviewInitial extends CreateReviewState {
  const CreateReviewInitial();
}

class CreateReviewLoading extends CreateReviewState {
  const CreateReviewLoading();
}

class CreateReviewError extends CreateReviewState {
  final Failure failure;

  const CreateReviewError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class CreateReviewDone extends CreateReviewState {
  const CreateReviewDone();

  @override
  List<Object> get props => [];
}
