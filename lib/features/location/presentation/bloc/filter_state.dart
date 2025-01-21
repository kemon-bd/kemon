part of 'filter_bloc.dart';

sealed class LocationListingsFilterState extends Equatable {
  final CategoryEntity? category;
  final SubCategoryEntity? subCategory;
  final String? division;
  final String? district;
  final String? thana;
  final RatingRange rating;
  const LocationListingsFilterState({
    required this.category,
    required this.subCategory,
    required this.division,
    required this.district,
    required this.thana,
    required this.rating,
  });

  @override
  List<Object?> get props => [
        category,
        subCategory,
        division,
        district,
        thana,
        rating,
      ];
}

final class DefaultLocationListingsFilterState extends LocationListingsFilterState {
  const DefaultLocationListingsFilterState()
      : super(
          category: null,
          subCategory: null,
          division: null,
          district: null,
          thana: null,
          rating: RatingRange.all,
        );

  @override
  List<Object?> get props => [
        category,
        subCategory,
        division,
        district,
        thana,
        rating,
      ];
}

final class CustomLocationListingsFilterState extends LocationListingsFilterState {
  const CustomLocationListingsFilterState({
    required super.category,
    required super.subCategory,
    required super.division,
    required super.district,
    required super.thana,
    required super.rating,
  });
  @override
  List<Object?> get props => [
        category,
        subCategory,
        division,
        district,
        thana,
        rating,
      ];
}
