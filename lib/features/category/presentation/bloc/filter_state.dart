part of 'filter_bloc.dart';

sealed class CategoryListingsFilterState extends Equatable {
  final SubCategoryEntity? subCategory;
  final LookupEntity? division;
  final LookupEntity? district;
  final LookupEntity? thana;
  final RatingRange rating;
  const CategoryListingsFilterState({
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

final class DefaultCategoryListingsFilterState extends CategoryListingsFilterState {
  const DefaultCategoryListingsFilterState()
      : super(
          subCategory: null,
          division: null,
          district: null,
          thana: null,
          rating: RatingRange.all,
        );

  @override
  List<Object?> get props => [
        subCategory,
        division,
        district,
        thana,
        rating,
      ];
}

final class CustomCategoryListingsFilterState extends CategoryListingsFilterState {
  const CustomCategoryListingsFilterState({
    required super.subCategory,
    required super.division,
    required super.district,
    required super.thana,
    required super.rating,
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
