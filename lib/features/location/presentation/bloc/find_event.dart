part of 'find_bloc.dart';

abstract class FindLocationEvent extends Equatable {
  const FindLocationEvent();

  @override
  List<Object> get props => [];
}

class FindLocation extends FindLocationEvent {
  final String urlSlug;

  const FindLocation({
    required this.urlSlug,
  });
  @override
  List<Object> get props => [urlSlug];
}

class RefreshLocation extends FindLocationEvent {
  final String urlSlug;

  const RefreshLocation({
    required this.urlSlug,
  });
  @override
  List<Object> get props => [urlSlug];
}
