part of 'industry_bloc.dart';

sealed class FindCategoriesByIndustryEvent extends Equatable {
  const FindCategoriesByIndustryEvent();

  @override
  List<Object> get props => [];
}

class FindCategoriesByIndustry extends FindCategoriesByIndustryEvent {
  final String industry;

  const FindCategoriesByIndustry({required this.industry});
}
