import '../../../../core/shared/shared.dart';
import '../../search.dart';

abstract class SearchLocalDataSource {
  Future<AutoCompleteSuggestions> findSuggestion({
    required String query,
  });

  Future<SearchResults> findResult({
    required String query,
    required FilterOptions filter,
  });

  Future<void> addSuggestion({
    required String query,
    required AutoCompleteSuggestions suggestions,
  });

  Future<void> addResult({
    required String query,
    required FilterOptions filter,
    required SearchResults results,
  });

  Future<void> removeAll();
}
