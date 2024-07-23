part of 'featured_bloc.dart';

sealed class FeaturedLocationEvent extends Equatable {
  const FeaturedLocationEvent();

  @override
  List<Object> get props => [];
}

class FeaturedLocation extends FeaturedLocationEvent {
  const FeaturedLocation();
}
