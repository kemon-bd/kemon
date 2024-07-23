part of 'industry_bloc.dart';

sealed class CategoriesByIndustryEvent extends Equatable {
  const CategoriesByIndustryEvent();

  @override
  List<Object> get props => [];
}

class CategoriesByIndustry extends CategoriesByIndustryEvent {
  final String industry;

  const CategoriesByIndustry({
    required this.industry,
  });

  @override
  List<Object> get props => [industry];
}
