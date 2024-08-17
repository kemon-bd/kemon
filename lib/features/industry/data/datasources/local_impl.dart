import '../../../../core/shared/shared.dart';
import '../../industry.dart';

class IndustryLocalDataSourceImpl extends IndustryLocalDataSource {
  final Map<String, IndustryEntity> _cache = {};

  @override
  FutureOr<void> add({
    required IndustryEntity industry,
  }) async {
    _cache[industry.urlSlug] = industry;
    return Future.value();
  }

  @override
  FutureOr<void> addAll({
    required List<IndustryEntity> industries,
  }) async {
    for (final item in industries) {
      _cache[item.urlSlug] = item;
    }
    return Future.value();
  }

  @override
  FutureOr<void> removeAll() async {
    _cache.clear();
    return Future.value();
  }

  @override
  FutureOr<List<IndustryEntity>> findAll() async {
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
