part of 'find_bloc.dart';

abstract class FindBusinessState extends Equatable {
  const FindBusinessState();

  @override
  List<Object> get props => [];
}

class FindBusinessInitial extends FindBusinessState {
  const FindBusinessInitial();
}

class FindBusinessLoading extends FindBusinessState {
  const FindBusinessLoading();
}

class FindBusinessError extends FindBusinessState {
  final Failure failure;

  const FindBusinessError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class FindBusinessDone extends FindBusinessState {
  final BusinessEntity business;
  final List<ListingReviewEntity> reviews;

  const FindBusinessDone({
    required this.business,
    required this.reviews,
  });

  @override
  List<Object> get props => [business, reviews];
}
