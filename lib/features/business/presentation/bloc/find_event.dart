part of 'find_bloc.dart';

abstract class FindBusinessEvent extends Equatable {
  const FindBusinessEvent();

  @override
  List<Object> get props => [];
}

class FindBusiness extends FindBusinessEvent {
  final String urlSlug;
  final List<int> filter;

  const FindBusiness({
    required this.urlSlug,
    this.filter = const [],
  });
  @override
  List<Object> get props => [urlSlug, filter];
}

class RefreshBusiness extends FindBusinessEvent {
  final String urlSlug;

  const RefreshBusiness({
    required this.urlSlug,
  });
  @override
  List<Object> get props => [urlSlug];
}
