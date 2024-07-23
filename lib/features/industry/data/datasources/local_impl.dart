import '../../../../core/shared/shared.dart';
import '../../industry.dart';

class IndustryLocalDataSourceImpl extends IndustryLocalDataSource {
  final Map<String, IndustryEntity> _cache = {};

  @override
  FutureOr<void> addAll({
    required List<IndustryEntity> items,
  }) {
    for (final item in items) {
      _cache[item.identity.guid] = item;
    }
  }

  @override
  FutureOr<void> removeAll() {
    _cache.clear();
  }

  @override
  FutureOr<List<IndustryEntity>> find() {
    final item = _cache.values.toList();
    if (item.isEmpty) {
      throw IndustryNotFoundInLocalCacheFailure();
    }
    return item;
  }
}
