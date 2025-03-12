part of 'all_bloc.dart';

sealed class FindAllLocationsState extends Equatable {
  const FindAllLocationsState();

  @override
  List<Object> get props => [];
}

final class FindAllLocationsInitial extends FindAllLocationsState {}

final class FindAllLocationsError extends FindAllLocationsState {
  final Failure failure;
  const FindAllLocationsError({
    required this.failure,
  });
  @override
  List<Object> get props => [failure];
}

final class FindAllLocationsLoading extends FindAllLocationsState {}

final class FindAllLocationsDone extends FindAllLocationsState {
  final List<DivisionWithListingCountEntity> divisions;
  const FindAllLocationsDone({
    required this.divisions,
  });
  @override
  List<Object> get props => [divisions];
}
