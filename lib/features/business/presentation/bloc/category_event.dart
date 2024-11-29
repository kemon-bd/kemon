part of 'category_bloc.dart';

abstract class FindBusinessesByCategoryEvent extends Equatable {
  const FindBusinessesByCategoryEvent();

  @override
  List<Object?> get props => [];
}

class FindBusinessesByCategory extends FindBusinessesByCategoryEvent {
  final String? query;
  final SortBy? sort;
  final LookupEntity? division;
  final LookupEntity? district;
  final LookupEntity? thana;
  final SubCategoryEntity? subCategory;
  final List<int> ratings;
  final String category;

  const FindBusinessesByCategory({
    required this.category,
    this.query,
    this.sort,
    this.division,
    this.district,
    this.thana,
    this.subCategory,
    this.ratings = const [],
  });
  @override
  List<Object?> get props =>
      [category, query, sort, division, district, thana, subCategory, ratings];
}

class RefreshBusinessesByCategory extends FindBusinessesByCategoryEvent {
  final String? query;
  final SortBy? sort;
  final LookupEntity? division;
  final LookupEntity? district;
  final LookupEntity? thana;
  final SubCategoryEntity? subCategory;
  final List<int> ratings;
  final String category;

  const RefreshBusinessesByCategory({
    required this.category,
    this.query,
    this.sort,
    this.division,
    this.district,
    this.thana,
    this.subCategory,
    this.ratings = const [],
  });
  @override
  List<Object?> get props =>
      [category, query, sort, division, district, thana, subCategory, ratings];
}

class PaginateBusinessesByCategory extends FindBusinessesByCategoryEvent {
  final String? query;
  final SortBy? sort;
  final LookupEntity? division;
  final LookupEntity? district;
  final LookupEntity? thana;
  final SubCategoryEntity? subCategory;
  final List<int> ratings;
  final int page;
  final String category;

  const PaginateBusinessesByCategory({
    required this.page,
    required this.category,
    this.query,
    this.sort,
    this.division,
    this.district,
    this.thana,
    this.subCategory,
    this.ratings = const [],
  });
  @override
  List<Object?> get props =>
      [category, query, sort, division, district, thana, subCategory, ratings];
}
