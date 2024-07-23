import '../../../../core/shared/shared.dart';
import '../../lookup.dart';

abstract class LookupRepository {
  FutureOr<Either<Failure, List<LookupEntity>>> find({
    required LookupKey key,
  });
}
