part of 'filter_bloc.dart';

sealed class LocationListingsFilterState extends Equatable {
  final IndustryEntity? industry;
  final CategoryEntity? category;
  final SubCategoryEntity? subCategory;
  final RatingRange rating;
  const LocationListingsFilterState({
    required this.industry,
    required this.category,
    required this.subCategory,
    required this.rating,
  });

  @override
  List<Object?> get props => [
        industry,
        category,
        subCategory,
        rating,
      ];
}

final class DefaultLocationListingsFilterState extends LocationListingsFilterState {
  const DefaultLocationListingsFilterState()
      : super(
          industry: null,
          category: null,
          subCategory: null,
          rating: RatingRange.all,
        );

  @override
  List<Object?> get props => [
        industry,
        category,
        subCategory,
        rating,
      ];
}

final class CustomLocationListingsFilterState extends LocationListingsFilterState {
  const CustomLocationListingsFilterState({
    required super.industry,
    required super.category,
    required super.subCategory,
    required super.rating,
  });
  @override
  List<Object?> get props => [
        industry,
        category,
        subCategory,
        rating,
      ];
}
