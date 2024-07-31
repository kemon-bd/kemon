import '../../../../core/shared/shared.dart';
import '../../industry.dart';

class IndustryLocalDataSourceImpl extends IndustryLocalDataSource {
  final Map<String, IndustryEntity> _cache = {};

  @override
  FutureOr<void> add({
    required IndustryEntity industry,
  }) {
    _cache[industry.urlSlug] = industry;
  }

  @override
  FutureOr<void> addAll({
    required List<IndustryEntity> industries,
  }) {
    for (final item in industries) {
      _cache[item.urlSlug] = item;
    }
  }

  @override
  FutureOr<void> removeAll() {
    _cache.clear();
  }

  @override
  FutureOr<List<IndustryEntity>> findAll() {
    final item = _cache.values.toList();
    if (item.isEmpty) {
      throw IndustryNotFoundInLocalCacheFailure();
    }
    return item;
  }

  @override
  FutureOr<IndustryEntity> find({
    required String urlSlug,
  }) async {
    final item = _cache[urlSlug];
    if (item == null) {
      throw IndustryNotFoundInLocalCacheFailure();
    }
    return item;
  }
}
