part of 'find_bloc.dart';

abstract class FindReviewEvent extends Equatable {
  const FindReviewEvent();

  @override
  List<Object> get props => [];
}

class FindReview extends FindReviewEvent {
  final Identity user;

  const FindReview({
    required this.user,
  });
  @override
  List<Object> get props => [user];
}
