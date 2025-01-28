part of 'reviews_bloc.dart';

abstract class FindListingReviewsEvent extends Equatable {
  final List<int> filter;
  const FindListingReviewsEvent({
    this.filter = const [],
  });

  @override
  List<Object?> get props => [filter];
}

class FindListingReviews extends FindListingReviewsEvent {
  final String? guid;
  final String urlSlug;

  const FindListingReviews({
    this.guid,
    required this.urlSlug,
    required super.filter,
  });
  @override
  List<Object?> get props => [guid, urlSlug, filter];
}

class RefreshListingReviews extends FindListingReviewsEvent {
  final String urlSlug;

  const RefreshListingReviews({
    required this.urlSlug,
    required super.filter,
  });
  @override
  List<Object> get props => [urlSlug, filter];
}
