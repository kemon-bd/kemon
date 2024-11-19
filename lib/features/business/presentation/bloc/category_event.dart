part of 'category_bloc.dart';

abstract class FindBusinessesByCategoryEvent extends Equatable {
  const FindBusinessesByCategoryEvent();

  @override
  List<Object?> get props => [];
}

class FindBusinessesByCategory extends FindBusinessesByCategoryEvent {
  final SortBy? sort;
  final LocationEntity? division;
  final LocationEntity? district;
  final LocationEntity? thana;
  final SubCategoryEntity? subCategory;
  final List<int> ratings;
  final String category;

  const FindBusinessesByCategory({
    required this.category,
    this.sort,
    this.division,
    this.district,
    this.thana,
    this.subCategory,
    this.ratings = const [],
  });
  @override
  List<Object?> get props => [category, sort, division, district, thana, subCategory, ratings];
}

class PaginateBusinessesByCategory extends FindBusinessesByCategoryEvent {
  final SortBy? sort;
  final LocationEntity? division;
  final LocationEntity? district;
  final LocationEntity? thana;
  final SubCategoryEntity? subCategory;
  final List<int> ratings;
  final int page;
  final String category;

  const PaginateBusinessesByCategory({
    required this.page,
    required this.category,
    this.sort,
    this.division,
    this.district,
    this.thana,
    this.subCategory,
    this.ratings = const [],
  });
  @override
  List<Object> get props => [category, page];
}
