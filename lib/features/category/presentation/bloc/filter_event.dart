part of 'filter_bloc.dart';

sealed class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object?> get props => [];
}

class ApplyFilter extends FilterEvent {
  final SortBy? sortBy;
  final LocationEntity? division;
  final LocationEntity? district;
  final LocationEntity? thana;
  final SubCategoryEntity? subCategory;
  final List<int> ratings;

  const ApplyFilter({
    required this.sortBy,
    required this.division,
    required this.district,
    required this.thana,
    required this.subCategory,
    required this.ratings,
  });

  @override
  List<Object?> get props =>
      [sortBy, division, district, thana, subCategory, ratings];
}
