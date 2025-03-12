part of 'location_bloc.dart';

sealed class FindLocationsByCategoryEvent extends Equatable {
  const FindLocationsByCategoryEvent();

  @override
  List<Object?> get props => [];
}

class FindLocationsByCategory extends FindLocationsByCategoryEvent {
  final Identity industry;
  final Identity? category;
  final Identity? subCategory;

  const FindLocationsByCategory({
    required this.industry,
    this.category,
    this.subCategory,
  });

  @override
  List<Object?> get props => [industry, category, subCategory];
}

class SearchLocationsByCategory extends FindLocationsByCategory {
  final String query;

  const SearchLocationsByCategory({
    required this.query,
    required super.industry,
    super.category,
    super.subCategory,
  });

  @override
  List<Object?> get props => [query, industry, category, subCategory];
}
