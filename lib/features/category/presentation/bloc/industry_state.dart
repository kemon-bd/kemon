part of 'industry_bloc.dart';

abstract class CategoriesByIndustryState extends Equatable {
  const CategoriesByIndustryState();

  @override
  List<Object> get props => [];
}

class CategoriesByIndustryInitial extends CategoriesByIndustryState {
  const CategoriesByIndustryInitial();
}

class CategoriesByIndustryLoading extends CategoriesByIndustryState {
  const CategoriesByIndustryLoading();
}

class CategoriesByIndustryError extends CategoriesByIndustryState {
  final Failure failure;

  const CategoriesByIndustryError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class CategoriesByIndustryDone extends CategoriesByIndustryState {
  final List<CategoryEntity> categories;

  const CategoriesByIndustryDone({required this.categories});

  @override
  List<Object> get props => [categories];
}
