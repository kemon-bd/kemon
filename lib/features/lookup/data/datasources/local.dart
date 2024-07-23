import '../../../../core/shared/shared.dart';
import '../../../lookup/lookup.dart';

typedef LookupKey = ({Lookups key, String? parent});

abstract class LookupLocalDataSource {
  FutureOr<void> cache({
    required LookupKey key,
    required List<LookupModel> items,
  });

  FutureOr<List<LookupModel>> find({
    required LookupKey key,
  });

  FutureOr<LookupModel> findByValue({
    required LookupKey key,
    required String value,
  });
}
