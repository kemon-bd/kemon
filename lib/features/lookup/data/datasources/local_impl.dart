import '../../../../core/shared/shared.dart';
import '../../../lookup/lookup.dart';

class LookupLocalDataSourceImpl extends LookupLocalDataSource {
  final Map<LookupKey, List<LookupModel>> _items = {};

  @override
  FutureOr<void> cache({
    required LookupKey key,
    required List<LookupModel> items,
  }) async {
    _items[key] = items;
  }

  @override
  FutureOr<List<LookupModel>> find({
    required LookupKey key,
  }) async {
    if (_items.containsKey(key)) {
      return _items[key] ?? [];
    }
    throw LookupNotFoundInLocalCacheFailure();
  }

  @override
  FutureOr<LookupModel> findByValue({
    required LookupKey key,
    required String value,
  }) async {
    final items = _items[key] ?? [];
    final item = items.firstWhereOrNull((e) => e.value == value);
    if (item != null) {
      return item;
    }
    throw LookupNotFoundInLocalCacheFailure();
  }
}
