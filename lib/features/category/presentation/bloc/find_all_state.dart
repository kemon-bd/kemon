part of 'find_all_bloc.dart';

abstract class FindAllCategoriesState extends Equatable {
  final String? industry;
  final String? query;
  const FindAllCategoriesState({
    this.industry,
    this.query,
  });

  @override
  List<Object?> get props => [industry, query];
}

class FindAllCategoriesInitial extends FindAllCategoriesState {
  const FindAllCategoriesInitial() : super();
}

class FindAllCategoriesLoading extends FindAllCategoriesState {
  const FindAllCategoriesLoading({
    required super.industry,
    required super.query,
  });

  @override
  List<Object?> get props => [industry, query];
}

class FindAllCategoriesError extends FindAllCategoriesState {
  final Failure failure;

  const FindAllCategoriesError({
    required this.failure,
    required super.industry,
    required super.query,
  });

  @override
  List<Object?> get props => [failure, industry, query];
}

class FindAllCategoriesDone extends FindAllCategoriesState {
  final int page;
  final int total;
  final List<IndustryBasedCategories> results;

  const FindAllCategoriesDone({
    required this.page,
    required this.total,
    required this.results,
    required super.industry,
    required super.query,
  });

  @override
  List<Object?> get props => [page, total, results, industry, query];
}

class FindAllCategoriesPaginating extends FindAllCategoriesDone {

  const FindAllCategoriesPaginating({
    required super.page,
    required super.total,
    required super.results,
    required super.industry,
    required super.query,
  });

  @override
  List<Object?> get props => [page, total, results, industry, query];
}
