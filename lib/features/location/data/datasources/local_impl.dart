import '../../../../core/shared/shared.dart';
import '../../location.dart';

class LocationLocalDataSourceImpl extends LocationLocalDataSource {
  final Map<String, LocationEntity> _cache = {};

  @override
  FutureOr<void> add({
    required LocationEntity location,
  }) {
    _cache[location.urlSlug] = location;
  }

  @override
  FutureOr<void> addAll({
    required List<LocationEntity> locations,
  }) {
    for (final item in locations) {
      _cache[item.urlSlug] = item;
    }
  }

  @override
  FutureOr<void> removeAll() {
    _cache.clear();
  }

  @override
  FutureOr<LocationEntity> find({
    required String urlSlug,
  }) {
    final item = _cache[urlSlug];
    if (item == null) {
      throw LocationNotFoundInLocalCacheFailure();
    }
    return item;
  }
}
