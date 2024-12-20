part of 'react_bloc.dart';

sealed class ReactOnReviewEvent extends Equatable {
  const ReactOnReviewEvent();

  @override
  List<Object> get props => [];
}

class ReactOnReview extends ReactOnReviewEvent {
  final Identity review;
  final Reaction reaction;
    final Identity listing;

  const ReactOnReview({
    required this.review,
    required this.reaction,
    required this.listing,
  });
}
