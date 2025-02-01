part of 'location_bloc.dart';

abstract class FindBusinessesByLocationEvent extends Equatable {
  const FindBusinessesByLocationEvent();

  @override
  List<Object?> get props => [];
}

class FindBusinessesByLocation extends FindBusinessesByLocationEvent {
  final String? query;
  final IndustryEntity? industry;
  final CategoryEntity? category;
  final SubCategoryEntity? sub;
  final SortBy? sort;
  final List<int> ratings;
  final String location;
  final String? division;
  final String? district;
  final String? thana;

  const FindBusinessesByLocation({
    required this.location,
    this.industry,
    this.category,
    this.sub,
    this.query,
    this.sort,
    this.ratings = const [],
    required this.division,
    required this.district,
    required this.thana,
  });
  @override
  List<Object?> get props => [location, query, sort, ratings, division, district, thana];
}

class RefreshBusinessesByLocation extends FindBusinessesByLocationEvent {
  final String? query;
  final IndustryEntity? industry;
  final CategoryEntity? category;
  final SubCategoryEntity? sub;
  final SortBy? sort;
  final List<int> ratings;
  final String location;
  final String? division;
  final String? district;
  final String? thana;

  const RefreshBusinessesByLocation({
    required this.location,
    this.industry,
    this.category,
    this.sub,
    this.query,
    this.sort,
    this.ratings = const [],
    required this.division,
    required this.district,
    required this.thana,
  });
  @override
  List<Object?> get props => [location, query, sort, ratings, division, district, thana];
}

class PaginateBusinessesByLocation extends FindBusinessesByLocationEvent {
  final String? query;
  final IndustryEntity? industry;
  final CategoryEntity? category;
  final SubCategoryEntity? sub;
  final SortBy? sort;
  final List<int> ratings;
  final int page;
  final String location;
  final String? division;
  final String? district;
  final String? thana;

  const PaginateBusinessesByLocation({
    required this.page,
    this.industry,
    this.category,
    this.sub,
    required this.location,
    this.query,
    this.sort,
    this.ratings = const [],
    required this.division,
    required this.district,
    required this.thana,
  });
  @override
  List<Object?> get props => [location, query, sort, ratings, division, district, thana];
}
