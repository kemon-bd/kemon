import '../../../../core/shared/shared.dart';
import '../../location.dart';

class LocationLocalDataSourceImpl extends LocationLocalDataSource {
  final Map<String, LocationEntity> _cache = {};

  @override
  FutureOr<void> add({
    required LocationEntity location,
  }) {
    _cache[location.guid] = location;
  }

  @override
  FutureOr<void> addAll({
    required List<LocationEntity> locations,
  }) {
    for (final item in locations) {
      _cache[item.guid] = item;
    }
  }

  @override
  FutureOr<void> update({
    required LocationEntity location,
  }) {
    _cache[location.guid] = location;
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
  FutureOr<LocationEntity> find({
    required String guid,
  }) {
    final item = _cache[guid];
    if (item == null) {
      throw LocationNotFoundInLocalCacheFailure();
    }
    return item;
  }
}
