part of 'category_bloc.dart';

abstract class FindBusinessesByCategoryEvent extends Equatable {
  const FindBusinessesByCategoryEvent();

  @override
  List<Object> get props => [];
}

class FindBusinessesByCategory extends FindBusinessesByCategoryEvent {
  final String category;

  const FindBusinessesByCategory({
    required this.category,
  });
  @override
  List<Object> get props => [category];
}

class PaginateBusinessesByCategory extends FindBusinessesByCategoryEvent {
  final int page;
  final String category;

  const PaginateBusinessesByCategory({
    required this.page,
    required this.category,
  });
  @override
  List<Object> get props => [category, page];
}