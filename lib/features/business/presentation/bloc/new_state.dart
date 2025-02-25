part of 'new_bloc.dart';

sealed class NewListingState extends Equatable {
  const NewListingState();

  @override
  List<Object> get props => [];
}

final class NewListingInitial extends NewListingState {}

final class NewListingError extends NewListingState {
  final Failure failure;
  const NewListingError({
    required this.failure,
  });
}

final class NewListingLoading extends NewListingState {}

final class NewListingDone extends NewListingState {
  const NewListingDone();
}
