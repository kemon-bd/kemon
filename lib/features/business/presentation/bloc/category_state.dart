part of 'category_bloc.dart';

abstract class FindBusinessesByCategoryState extends Equatable {
  final String query;
  final SortBy? sortBy;
  final LookupEntity? division;
  final LookupEntity? district;
  final LookupEntity? thana;
  final SubCategoryEntity? subCategory;
  final List<int> ratings;

  const FindBusinessesByCategoryState({
    required this.query,
    required this.sortBy,
    required this.ratings,
    required this.division,
    required this.district,
    required this.thana,
    required this.subCategory,
  });

  @override
  List<Object?> get props =>
      [query, sortBy, ratings, division, district, thana, subCategory];
}

class FindBusinessesByCategoryInitial extends FindBusinessesByCategoryState {
  const FindBusinessesByCategoryInitial()
      : super(
          query: '',
          sortBy: SortBy.recommended,
          ratings: const [],
          division: null,
          district: null,
          thana: null,
          subCategory: null,
        );
}

class FindBusinessesByCategoryLoading extends FindBusinessesByCategoryState {
  const FindBusinessesByCategoryLoading({
    required super.query,
    required super.sortBy,
    required super.ratings,
    required super.division,
    required super.district,
    required super.thana,
    required super.subCategory,
  });
}

class FindBusinessesByCategoryError extends FindBusinessesByCategoryState {
  final Failure failure;

  const FindBusinessesByCategoryError({
    required this.failure,
    required super.query,
    required super.sortBy,
    required super.ratings,
    required super.division,
    required super.district,
    required super.thana,
    required super.subCategory,
  });

  @override
  List<Object?> get props =>
      [failure, query, sortBy, ratings, division, district, thana, subCategory];
}

class FindBusinessesByCategoryDone extends FindBusinessesByCategoryState {
  final int page;
  final int total;
  final List<CategoryEntity> related;
  final List<BusinessEntity> businesses;

  const FindBusinessesByCategoryDone({
    required this.page,
    required super.query,
    required this.total,
    required this.related,
    required this.businesses,
    required super.sortBy,
    required super.ratings,
    required super.division,
    required super.district,
    required super.thana,
    required super.subCategory,
  });

  @override
  List<Object?> get props => [
        businesses,
        total,
        page,
        related,
        query,
        sortBy,
        ratings,
        division,
        district,
        thana,
        subCategory
      ];
}

class FindBusinessesByCategoryPaginating extends FindBusinessesByCategoryDone {
  const FindBusinessesByCategoryPaginating({
    required super.page,
    required super.query,
    required super.total,
    required super.related,
    required super.businesses,
    required super.sortBy,
    required super.ratings,
    required super.division,
    required super.district,
    required super.thana,
    required super.subCategory,
  });

  @override
  List<Object?> get props => [
        businesses,
        total,
        page,
        related,
        query,
        sortBy,
        ratings,
        division,
        district,
        thana,
        subCategory
      ];
}
