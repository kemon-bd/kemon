part of 'result_bloc.dart';

sealed class SearchResultEvent extends Equatable {
  const SearchResultEvent();

  @override
  List<Object> get props => [];
}

class SearchResult extends SearchResultEvent {
  final String query;
  final FilterOptions filter;

  const SearchResult({
    required this.query,
    required this.filter,
  });

  @override
  List<Object> get props => [query, filter];
}
