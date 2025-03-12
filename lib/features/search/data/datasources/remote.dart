import '../../../../core/shared/shared.dart';
import '../../search.dart';

abstract class SearchRemoteDataSource {
  Future<List<SearchSuggestionModel>> suggestion({
    required String query,
  });

  Future<SearchResults> result({
    required String query,
    required FilterOptions filter,
  });
}
