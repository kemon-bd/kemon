import '../../../../core/shared/shared.dart';
import '../../search.dart';

abstract class SearchRemoteDataSource {
  Future<AutoCompleteSuggestions> suggestion({
    required String query,
  });

  Future<SearchResults> result({
    required String query,
    required FilterOptions filter,
  });
}
