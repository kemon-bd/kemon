part of 'filter_bloc.dart';

class FilterState extends Equatable {
  final SortBy? sortBy;
  final LocationEntity? division;
  final LocationEntity? district;
  final LocationEntity? thana;
  final SubCategoryEntity? subCategory;
  final List<int> ratings;

  const FilterState({
    required this.sortBy,
    required this.division,
    required this.district,
    required this.thana,
    required this.subCategory,
    required this.ratings,
  });

  @override
  List<Object?> get props => [sortBy, division, district, thana, subCategory, ratings];
}

class DefaultFilter extends FilterState {
  const DefaultFilter()
      : super(
          sortBy: null,
          division: null,
          district: null,
          thana: null,
          subCategory: null,
          ratings: const <int>[],
        );
}
