part of 'suggestion_bloc.dart';

sealed class SearchSuggestionState extends Equatable {
  const SearchSuggestionState();

  @override
  List<Object> get props => [];
}

class SearchSuggestionInitial extends SearchSuggestionState {
  const SearchSuggestionInitial();
}

class SearchSuggestionLoading extends SearchSuggestionState {
  const SearchSuggestionLoading();
}

class SearchSuggestionError extends SearchSuggestionState {
  final Failure failure;
  const SearchSuggestionError({
    required this.failure,
  });
}

class SearchSuggestionDone extends SearchSuggestionState {
  final List<SearchSuggestionEntity> suggestions;
  const SearchSuggestionDone({
    required this.suggestions,
  });
}
