part of 'failure.dart';

class SearchResultsNotFoundInLocalCacheFailure extends Failure {
  SearchResultsNotFoundInLocalCacheFailure()
      : super(
          message: 'Search results not found in local cache.',
        );
}

class SearchSuggestionsNotFoundInLocalCacheFailure extends Failure {
  SearchSuggestionsNotFoundInLocalCacheFailure()
      : super(
          message: 'Search suggestions not found in local cache.',
        );
}
