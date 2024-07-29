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
  final List<String> businesses;
  final List<IndustryEntity> industries;
  final List<CategoryEntity> categories;
  final List<SubCategoryEntity> subCategories;
  final AutoCompleteSuggestions suggestions;
  const SearchSuggestionDone({
    required this.businesses,
    required this.industries,
    required this.categories,
    required this.subCategories,
    required this.suggestions,
  });
}
