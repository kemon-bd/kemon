part of 'reactions_bloc.dart';

sealed class FindReviewReactionsEvent extends Equatable {
  const FindReviewReactionsEvent();

  @override
  List<Object> get props => [];
}

class FindReviewReactions extends FindReviewReactionsEvent {
  final Identity review;

  const FindReviewReactions({
    required this.review,
  });
  @override
  List<Object> get props => [review];
}