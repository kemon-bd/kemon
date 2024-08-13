part of 'reviews_bloc.dart';

abstract class FindListingReviewsEvent extends Equatable {
  const FindListingReviewsEvent();

  @override
  List<Object> get props => [];
}

class FindListingReviews extends FindListingReviewsEvent {
  final String urlSlug;

  const FindListingReviews({
    required this.urlSlug,
  });
  @override
  List<Object> get props => [urlSlug];
}

class RefreshListingReviews extends FindListingReviewsEvent {
  final String urlSlug;

  const RefreshListingReviews({
    required this.urlSlug,
  });
  @override
  List<Object> get props => [urlSlug];
}
