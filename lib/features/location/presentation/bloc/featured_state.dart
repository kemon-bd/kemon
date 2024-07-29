part of 'featured_bloc.dart';

sealed class FeaturedLocationsState extends Equatable {
  const FeaturedLocationsState();

  @override
  List<Object> get props => [];
}

final class FeaturedLocationsInitial extends FeaturedLocationsState {}

final class FeaturedLocationsError extends FeaturedLocationsState {
  final Failure failure;

  const FeaturedLocationsError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

final class FeaturedLocationsLoading extends FeaturedLocationsState {
  const FeaturedLocationsLoading();
}

final class FeaturedLocationsDone extends FeaturedLocationsState {
  final List<LocationEntity> locations;

  const FeaturedLocationsDone({
    required this.locations,
  });

  @override
  List<Object> get props => [locations];
}
