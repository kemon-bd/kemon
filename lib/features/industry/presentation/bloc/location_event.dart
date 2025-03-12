part of 'location_bloc.dart';

sealed class FindIndustriesByLocationEvent extends Equatable {
  const FindIndustriesByLocationEvent();

  @override
  List<Object?> get props => [];
}

class FindIndustriesByLocation extends FindIndustriesByLocationEvent {
  final String division;
  final String? district;
  final String? thana;

  const FindIndustriesByLocation({
    required this.division,
    this.district,
    this.thana,
  });

  @override
  List<Object?> get props => [division, district, thana];
}

class SearchIndustriesByLocation extends FindIndustriesByLocation {
  final String query;


  const SearchIndustriesByLocation({
    required this.query,
    required super.division,
    super.district,
    super.thana,
  });

  @override
  List<Object?> get props => [query, division, district, thana];
}
