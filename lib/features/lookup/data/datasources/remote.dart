import '../../../../core/shared/shared.dart';
import '../../lookup.dart';

abstract class LookupRemoteDataSource {
  FutureOr<List<LookupModel>> find({
    required LookupKey key,
  });
}
