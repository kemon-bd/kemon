part of 'location_bloc.dart';

sealed class FindBusinessesByLocationEvent extends Equatable {
  const FindBusinessesByLocationEvent();

  @override
  List<Object?> get props => [];
}

class FindBusinessesByLocation extends FindBusinessesByLocationEvent {
  final String division;
  final String? district;
  final String? thana;
  final String? query;
  final Identity? industry;
  final Identity? category;
  final Identity? subCategory;
  final SortBy? sort;
  final RatingRange ratings;

  const FindBusinessesByLocation({
    required this.division,
    this.district,
    this.thana,
    this.query,
    this.industry,
    this.category,
    this.subCategory,
    this.sort,
    this.ratings = RatingRange.all,
  });

  @override
  List<Object?> get props => [
        division,
        district,
        thana,
        query,
        industry,
        category,
        subCategory,
        sort,
        ratings,
      ];
}


class RefreshBusinessesByLocation extends FindBusinessesByLocationEvent {
  final String division;
  final String? district;
  final String? thana;
  final String? query;
  final Identity? industry;
  final Identity? category;
  final Identity? subCategory;
  final SortBy? sort;
  final RatingRange ratings;

  const RefreshBusinessesByLocation({
    required this.division,
    this.district,
    this.thana,
    this.query,
    this.industry,
    this.category,
    this.subCategory,
    this.sort,
    this.ratings = RatingRange.all,
  });

  @override
  List<Object?> get props => [
        division,
        district,
        thana,
        query,
        industry,
        category,
        subCategory,
        sort,
        ratings,
      ];
}


