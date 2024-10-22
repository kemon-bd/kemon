part of 'find_bloc.dart';

abstract class FindBusinessEvent extends Equatable {
  const FindBusinessEvent();

  @override
  List<Object> get props => [];
}

class FindBusiness extends FindBusinessEvent {
  final String urlSlug;

  const FindBusiness({
    required this.urlSlug,
  });
  @override
  List<Object> get props => [urlSlug];
}

class RefreshBusiness extends FindBusinessEvent {
  final String urlSlug;

  const RefreshBusiness({
    required this.urlSlug,
  });
  @override
  List<Object> get props => [urlSlug];
}
