part of 'find_bloc.dart';

abstract class FindUserReviewsEvent extends Equatable {
  const FindUserReviewsEvent();

  @override
  List<Object> get props => [];
}

class FindUserReviews extends FindUserReviewsEvent {
  final Identity user;

  const FindUserReviews({
    required this.user,
  });
  @override
  List<Object> get props => [user];
}
