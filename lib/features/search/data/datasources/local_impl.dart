import '../../../../core/shared/shared.dart';
import '../../search.dart';

class SearchLocalDataSourceImpl extends SearchLocalDataSource {
  final Map<String, AutoCompleteSuggestions> _suggestions = {};
  final Map<(String, FilterOptions), SearchResults> _results = {};

  @override
  Future<void> addResult({
    required String query,
    required FilterOptions filter,
    required SearchResults results,
  }) async {
    _results[(query, filter)] = results;
  }

  @override
  Future<void> addSuggestion({
    required String query,
    required AutoCompleteSuggestions suggestions,
  }) async {
    _suggestions[query] = suggestions;
  }

  @override
  Future<SearchResults> findResult({
    required String query,
    required FilterOptions filter,
  }) async {
    final result = _results[(query, filter)];
    if (result != null) {
      return result;
    } else {
      throw SearchResultsNotFoundInLocalCacheFailure();
    }
  }

  @override
  Future<AutoCompleteSuggestions> findSuggestion({
    required String query,
  }) async {
    final suggestions = _suggestions[query];
    if (suggestions != null) {
      return suggestions;
    } else {
      throw SearchSuggestionsNotFoundInLocalCacheFailure();
    }
  }

  @override
  Future<void> removeAll() async {
    _suggestions.clear();
    _results.clear();
  }
}
