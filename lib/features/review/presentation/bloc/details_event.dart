part of 'details_bloc.dart';

sealed class FindReviewDetailsEvent extends Equatable {
  const FindReviewDetailsEvent();

  @override
  List<Object> get props => [];
}

class FindReviewDetails extends FindReviewDetailsEvent {
  final Identity review;

  const FindReviewDetails({
    required this.review,
  });
  @override
  List<Object> get props => [review];
}

class RefreshReviewDetails extends FindReviewDetailsEvent {
  final Identity review;

  const RefreshReviewDetails({
    required this.review,
  });
  @override
  List<Object> get props => [review];
}
