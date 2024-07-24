part of 'rating_bloc.dart';

abstract class FindRatingEvent extends Equatable {
  const FindRatingEvent();

  @override
  List<Object> get props => [];
}

class FindRating extends FindRatingEvent {
  final String urlSlug;

  const FindRating({
    required this.urlSlug,
  });
  @override
  List<Object> get props => [urlSlug];
}
