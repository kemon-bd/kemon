part of 'reactions_bloc.dart';

abstract class FindReviewReactionsState extends Equatable {
  const FindReviewReactionsState();

  @override
  List<Object> get props => [];
}

class FindReviewReactionsInitial extends FindReviewReactionsState {
  const FindReviewReactionsInitial();
}

class FindReviewReactionsLoading extends FindReviewReactionsState {
  const FindReviewReactionsLoading();
}

class FindReviewReactionsError extends FindReviewReactionsState {
  final Failure failure;

  const FindReviewReactionsError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class FindReviewReactionsDone extends FindReviewReactionsState {
  final List<ReactionEntity> reactions;

  const FindReviewReactionsDone({required this.reactions});

  @override
  List<Object> get props => [reactions];
}
