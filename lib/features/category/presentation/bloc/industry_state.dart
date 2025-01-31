part of 'industry_bloc.dart';

sealed class FindCategoriesByIndustryState extends Equatable {
  const FindCategoriesByIndustryState();

  @override
  List<Object> get props => [];
}

final class FindCategoriesByIndustryInitial extends FindCategoriesByIndustryState {}

final class FindCategoriesByIndustryLoading extends FindCategoriesByIndustryState {}

final class FindCategoriesByIndustryError extends FindCategoriesByIndustryState {
  final Failure failure;

  const FindCategoriesByIndustryError({
    required this.failure,
  });
}

final class FindCategoriesByIndustryDone extends FindCategoriesByIndustryState {
  final List<CategoryEntity> categories;

  const FindCategoriesByIndustryDone({
    required this.categories,
  });
}
