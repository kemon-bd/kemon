import '../../../../core/shared/shared.dart';
import '../../lookup.dart';

class FindLookupUseCase {
  final LookupRepository repository;

  FindLookupUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<LookupEntity>>> call({
    required LookupKey key,
  }) async {
    return await repository.find(key: key);
  }
}
