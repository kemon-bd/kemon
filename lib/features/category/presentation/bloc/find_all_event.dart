part of 'find_all_bloc.dart';

abstract class FindAllCategoriesEvent extends Equatable {
  final String? industry;
  final String? query;
  const FindAllCategoriesEvent({
    this.industry,
    this.query,
  });

  @override
  List<Object?> get props => [industry, query];
}

class FindAllCategories extends FindAllCategoriesEvent {
  const FindAllCategories({
    required super.industry,
    required super.query,
  });
  @override
  List<Object?> get props => [industry, query];
}

class PaginateAllCategories extends FindAllCategoriesEvent {
  final int page;
  const PaginateAllCategories({
    required this.page,
    required super.industry,
    required super.query,
  });
  @override
  List<Object?> get props => [page, industry, query];
}

class RefreshAllCategories extends FindAllCategoriesEvent {
  const RefreshAllCategories({
    required super.industry,
    required super.query,
  });
  @override
  List<Object?> get props => [industry, query];
}