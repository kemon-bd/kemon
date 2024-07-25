import '../../../../core/shared/shared.dart';
import '../../search.dart';

class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  final Client client;

  SearchRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<SearchResults> result({
    required String query,
    required FilterOptions filter,
  }) async {
    // TODO: implement result
    throw UnimplementedError();
  }

  @override
  Future<AutoCompleteSuggestions> suggestion({
    required String query,
  }) async {
    // TODO: implement suggestion
    throw UnimplementedError();
  }
}
