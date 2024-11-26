part of 'react_bloc.dart';

sealed class ReactOnReviewState extends Equatable {
  const ReactOnReviewState();

  @override
  List<Object> get props => [];
}

final class ReactOnReviewInitial extends ReactOnReviewState {
  const ReactOnReviewInitial();
}

final class ReactOnReviewError extends ReactOnReviewState {
  final Failure failure;

  const ReactOnReviewError({
    required this.failure,
  });
}

final class ReactOnReviewLoading extends ReactOnReviewState {
  const ReactOnReviewLoading();
}

final class ReactOnReviewDone extends ReactOnReviewState {
  const ReactOnReviewDone();
}
