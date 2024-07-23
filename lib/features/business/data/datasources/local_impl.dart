import '../../../../core/shared/shared.dart';
import '../../business.dart';

class BusinessLocalDataSourceImpl extends BusinessLocalDataSource {
  final Map<String, BusinessEntity> _cache = {};

  @override
  FutureOr<void> add({
    required BusinessEntity business,
  }) {
    _cache[business.guid] = business;
  }

  @override
  FutureOr<void> addAll({
    required List<BusinessEntity> items,
  }) {
    for (final item in items) {
      _cache[item.guid] = item;
    }
  }

  @override
  FutureOr<void> update({
    required BusinessEntity business,
  }) {
    _cache[business.guid] = business;
  }

  @override
  FutureOr<void> remove({
    required String guid,
  }) {
    _cache.remove(guid);
  }

  @override
  FutureOr<void> removeAll() {
    _cache.clear();
  }

  @override
  FutureOr<BusinessEntity> find({
    required String urlSlug,
  }) {
    final item = _cache[urlSlug];
    if (item == null) {
      throw BusinessNotFoundInLocalCacheFailure();
    }
    return item;
  }
}
