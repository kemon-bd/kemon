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
