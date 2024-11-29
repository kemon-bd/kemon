part of 'location_bloc.dart';

abstract class FindBusinessesByLocationState extends Equatable {
  final String query;
  final SortBy? sortBy;
  final List<int> ratings;

  const FindBusinessesByLocationState({
    required this.query,
    required this.sortBy,
    required this.ratings,
  });

  @override
  List<Object?> get props => [query, sortBy, ratings];
}

class FindBusinessesByLocationInitial extends FindBusinessesByLocationState {
  const FindBusinessesByLocationInitial()
      : super(
          query: '',
          sortBy: SortBy.recommended,
          ratings: const [],
        );
}

class FindBusinessesByLocationLoading extends FindBusinessesByLocationState {
  const FindBusinessesByLocationLoading({
    required super.query,
    required super.sortBy,
    required super.ratings,
  });
}

class FindBusinessesByLocationError extends FindBusinessesByLocationState {
  final Failure failure;

  const FindBusinessesByLocationError({
    required this.failure,
    required super.query,
    required super.sortBy,
    required super.ratings,
  });

  @override
  List<Object?> get props => [failure, query, sortBy, ratings];
}

class FindBusinessesByLocationDone extends FindBusinessesByLocationState {
  final int page;
  final int total;
  final List<LocationEntity> related;
  final List<BusinessEntity> businesses;

  const FindBusinessesByLocationDone({
    required this.page,
    required super.query,
    required this.total,
    required this.related,
    required this.businesses,
    required super.sortBy,
    required super.ratings,
  });

  @override
  List<Object?> get props =>
      [businesses, total, page, related, query, sortBy, ratings];
}

class FindBusinessesByLocationPaginating extends FindBusinessesByLocationDone {
  const FindBusinessesByLocationPaginating({
    required super.page,
    required super.query,
    required super.total,
    required super.related,
    required super.businesses,
    required super.sortBy,
    required super.ratings,
  });

  @override
  List<Object?> get props =>
      [businesses, total, page, related, query, sortBy, ratings];
}
