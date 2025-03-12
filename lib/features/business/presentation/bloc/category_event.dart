part of 'category_bloc.dart';

abstract class FindBusinessesByCategoryEvent extends Equatable {
  const FindBusinessesByCategoryEvent();

  @override
  List<Object?> get props => [];
}

class FindBusinessesByCategory extends FindBusinessesByCategoryEvent {
  final Identity industry;
  final Identity? category;
  final Identity? subCategory;
  final String? division;
  final String? district;
  final String? thana;
  final SortBy? sort;
  final RatingRange ratings;

  const FindBusinessesByCategory({
    required this.industry,
    this.category,
    this.subCategory,
    this.division,
    this.district,
    this.thana,
    this.sort,
    this.ratings = RatingRange.all,
  });
  
  @override
  List<Object?> get props => [
        sort,
        ratings,
        industry,
        category,
        subCategory,
      ];
}

class SearchBusinessesByCategory extends FindBusinessesByCategoryEvent {
  final String query;
  final Identity industry;
  final Identity? category;
  final Identity? subCategory;
  final String? division;
  final String? district;
  final String? thana;
  final SortBy? sort;
  final RatingRange ratings;

  const SearchBusinessesByCategory({
    required this.industry,
    this.category,
    this.subCategory,
    this.division,
    this.district,
    this.thana,
    required this.query,
    this.sort,
    this.ratings = RatingRange.all,
  });
  
  @override
  List<Object?> get props => [
        query,
        sort,
        ratings,
        industry,
        category,
        subCategory,
      ];
}

class RefreshBusinessesByCategory extends FindBusinessesByCategoryEvent {
  final Identity industry;
  final Identity? category;
  final Identity? subCategory;
  final String? division;
  final String? district;
  final String? thana;
  final SortBy? sort;
  final RatingRange ratings;

  const RefreshBusinessesByCategory({
    required this.industry,
    this.category,
    this.subCategory,
    this.sort,
    this.division,
    this.district,
    this.thana,
    this.ratings = RatingRange.all,
  });

  @override
  List<Object?> get props => [
        sort,
        ratings,
        industry,
        category,
        subCategory,
        division,
        district,
        thana,
      ];
}
