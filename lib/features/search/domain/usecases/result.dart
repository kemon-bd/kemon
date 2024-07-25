import '../../../../core/shared/shared.dart';
import '../../search.dart';

class SearchResultUseCase {
  final SearchRepository repository;

  SearchResultUseCase({
    required this.repository,
  });

  Future<Either<Failure, SearchResults>> call({
    required String query,
    required FilterOptions filter,
  }) async {
    return await repository.result(query: query, filter: filter);
  }
}
