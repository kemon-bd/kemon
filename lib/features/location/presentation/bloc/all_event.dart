part of 'all_bloc.dart';

sealed class FindAllLocationsEvent extends Equatable {
  const FindAllLocationsEvent();

  @override
  List<Object> get props => [];
}

class FindAllLocations extends FindAllLocationsEvent {
  const FindAllLocations();
}

class SearchAllLocations extends FindAllLocationsEvent {
  final String query;
  const SearchAllLocations({
    required this.query,
  });
}
