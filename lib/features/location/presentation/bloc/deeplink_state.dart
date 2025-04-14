part of 'deeplink_bloc.dart';

sealed class LocationDeeplinkState extends Equatable {
  const LocationDeeplinkState();

  @override
  List<Object> get props => [];
}

final class LocationDeeplinkInitial extends LocationDeeplinkState {}

final class LocationDeeplinkLoading extends LocationDeeplinkState {}

final class LocationDeeplinkError extends LocationDeeplinkState {
  final Failure failure;

  const LocationDeeplinkError({
    required this.failure,
  });
  @override
  List<Object> get props => [failure];
}

final class LocationDeeplinkDone extends LocationDeeplinkState {
  final LocationEntity location;

  const LocationDeeplinkDone({
    required this.location,
  });

  @override
  List<Object> get props => [location];
}
