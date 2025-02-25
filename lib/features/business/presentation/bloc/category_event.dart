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
  final CategoryEntity? category;
  final List<int> ratings;
  final String urlSlug;

  const FindBusinessesByCategory({
    required this.urlSlug,
    this.query,
    this.sort,
    this.division,
    this.district,
    this.thana,
    this.subCategory,
    this.category,
    this.ratings = const [],
  });
  @override
  List<Object?> get props => [urlSlug, query, sort, division, district, thana, subCategory, ratings];
}

class RefreshBusinessesByCategory extends FindBusinessesByCategoryEvent {
  final String? query;
  final SortBy? sort;
  final LookupEntity? division;
  final LookupEntity? district;
  final LookupEntity? thana;
  final CategoryEntity? category;
  final SubCategoryEntity? subCategory;
  final List<int> ratings;
  final String urlSlug;

  const RefreshBusinessesByCategory({
    required this.urlSlug,
    this.query,
    this.sort,
    this.division,
    this.district,
    this.thana,
    this.subCategory,
    this.category,
    this.ratings = const [],
  });
  @override
  List<Object?> get props => [urlSlug, query, sort, division, district, thana, subCategory, ratings];
}

class PaginateBusinessesByCategory extends FindBusinessesByCategoryEvent {
  final String? query;
  final SortBy? sort;
  final LookupEntity? division;
  final LookupEntity? district;
  final LookupEntity? thana;
  final CategoryEntity? category;
  final SubCategoryEntity? subCategory;
  final List<int> ratings;
  final int page;
  final String urlSlug;

  const PaginateBusinessesByCategory({
    required this.page,
    required this.urlSlug,
    this.query,
    this.sort,
    this.division,
    this.district,
    this.thana,
    this.category,
    this.subCategory,
    this.ratings = const [],
  });
  @override
  List<Object?> get props => [urlSlug, query, sort, division, district, thana, subCategory, ratings];
}
