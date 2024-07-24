part of 'rating_bloc.dart';

abstract class FindRatingState extends Equatable {
  const FindRatingState();

  @override
  List<Object> get props => [];
}

class FindRatingInitial extends FindRatingState {
  const FindRatingInitial();
}

class FindRatingLoading extends FindRatingState {
  const FindRatingLoading();
}

class FindRatingError extends FindRatingState {
  final Failure failure;

  const FindRatingError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class FindRatingDone extends FindRatingState {
  final RatingEntity rating;

  const FindRatingDone({required this.rating});

  @override
  List<Object> get props => [rating];
}
