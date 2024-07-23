part of 'featured_bloc.dart';

sealed class FeaturedLocationState extends Equatable {
  const FeaturedLocationState();

  @override
  List<Object> get props => [];
}

final class FeaturedLocationInitial extends FeaturedLocationState {}

final class FeaturedLocationError extends FeaturedLocationState {
  final Failure failure;

  const FeaturedLocationError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

final class FeaturedLocationLoading extends FeaturedLocationState {
  const FeaturedLocationLoading();
}

final class FeaturedLocationDone extends FeaturedLocationState {
  final List<LocationEntity> locations;

  const FeaturedLocationDone({
    required this.locations,
  });

  @override
  List<Object> get props => [locations];
}
