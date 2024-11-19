part of 'category_bloc.dart';

abstract class SubCategoriesByCategoryEvent extends Equatable {
  const SubCategoriesByCategoryEvent();

  @override
  List<Object> get props => [];
}

class SubCategoriesByCategory extends SubCategoriesByCategoryEvent {
  final String category;

  const SubCategoriesByCategory({
    required this.category,
  });
  @override
  List<Object> get props => [category];
}

class SearchSubCategoriesByCategory extends SubCategoriesByCategoryEvent {
  final String category;
  final String query;

  const SearchSubCategoriesByCategory({
    required this.category,
    required this.query,
  });
  @override
  List<Object> get props => [category, query];
}
