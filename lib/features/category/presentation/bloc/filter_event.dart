part of 'filter_bloc.dart';

sealed class CategoryListingsFilterEvent extends Equatable {
  const CategoryListingsFilterEvent();

  @override
  List<Object?> get props => [];
}

class ApplyCategoryListingsFilter extends CategoryListingsFilterEvent {
  final SubCategoryEntity? subCategory;
  final LookupEntity? division;
  final LookupEntity? district;
  final LookupEntity? thana;
  final RatingRange rating;

  const ApplyCategoryListingsFilter({
    required this.subCategory,
    required this.division,
    required this.district,
    required this.thana,
    required this.rating,
  });

  @override
  List<Object?> get props => [
        subCategory,
        division,
        district,
        thana,
        rating,
      ];
}

class ResetCategoryListingsFilter extends CategoryListingsFilterEvent {
  const ResetCategoryListingsFilter();

  @override
  List<Object?> get props => [];
}
