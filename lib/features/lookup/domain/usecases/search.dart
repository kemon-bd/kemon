import '../../../../core/shared/shared.dart';
import '../../lookup.dart';

class SearchLookupUseCase {
  final LookupRepository repository;

  SearchLookupUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<LookupEntity>>> call({
    required LookupKey key,
    required String query,
  }) async {
    return await repository.search(key: key, query: query);
  }
}
