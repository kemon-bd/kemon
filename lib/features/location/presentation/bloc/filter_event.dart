part of 'filter_bloc.dart';

sealed class LocationListingsFilterEvent extends Equatable {
  const LocationListingsFilterEvent();

  @override
  List<Object?> get props => [];
}

class ApplyLocationListingsFilter extends LocationListingsFilterEvent {
  final IndustryEntity? industry;
  final CategoryEntity? category;
  final SubCategoryEntity? subCategory;
  final RatingRange rating;

  const ApplyLocationListingsFilter({
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

class ResetLocationListingsFilter extends LocationListingsFilterEvent {
  const ResetLocationListingsFilter();

  @override
  List<Object?> get props => [];
}
