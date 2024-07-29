part of 'featured_bloc.dart';

sealed class FeaturedLocationsEvent extends Equatable {
  const FeaturedLocationsEvent();

  @override
  List<Object> get props => [];
}

class FeaturedLocations extends FeaturedLocationsEvent {
  const FeaturedLocations();
}
