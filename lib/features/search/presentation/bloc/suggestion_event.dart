part of 'suggestion_bloc.dart';

sealed class SearchSuggestionEvent extends Equatable {
  const SearchSuggestionEvent();

  @override
  List<Object> get props => [];
}

class SearchSuggestion extends SearchSuggestionEvent {
  final String query;
  const SearchSuggestion({
    required this.query,
  });

  @override
  List<Object> get props => [query];
}

class ResetSuggestion extends SearchSuggestionEvent {
  const ResetSuggestion();

  @override
  List<Object> get props => [];
}
