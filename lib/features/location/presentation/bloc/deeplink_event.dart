part of 'deeplink_bloc.dart';

sealed class LocationDeeplinkEvent extends Equatable {
  const LocationDeeplinkEvent();

  @override
  List<Object> get props => [];
}

final class LocationDeeplink extends LocationDeeplinkEvent {
  final String urlSlug;

  const LocationDeeplink({
    required this.urlSlug,
  });
  @override
  List<Object> get props => [urlSlug];
}
