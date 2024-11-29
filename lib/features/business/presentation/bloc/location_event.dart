part of 'location_bloc.dart';

abstract class FindBusinessesByLocationEvent extends Equatable {
  const FindBusinessesByLocationEvent();

  @override
  List<Object?> get props => [];
}

class FindBusinessesByLocation extends FindBusinessesByLocationEvent {
  final String? query;
  final SortBy? sort;
  final List<int> ratings;
  final String location;

  const FindBusinessesByLocation({
    required this.location,
    this.query,
    this.sort,
    this.ratings = const [],
  });
  @override
  List<Object?> get props => [location, query, sort, ratings];
}

class RefreshBusinessesByLocation extends FindBusinessesByLocationEvent {
  final String? query;
  final SortBy? sort;
  final List<int> ratings;
  final String location;

  const RefreshBusinessesByLocation({
    required this.location,
    this.query,
    this.sort,
    this.ratings = const [],
  });
  @override
  List<Object?> get props => [location, query, sort, ratings];
}

class PaginateBusinessesByLocation extends FindBusinessesByLocationEvent {
  final String? query;
  final SortBy? sort;
  final List<int> ratings;
  final int page;
  final String location;

  const PaginateBusinessesByLocation({
    required this.page,
    required this.location,
    this.query,
    this.sort,
    this.ratings = const [],
  });
  @override
  List<Object?> get props => [location, query, sort, ratings];
}
