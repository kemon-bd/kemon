import '../../../../core/shared/shared.dart';
import '../../industry.dart';

class IndustryLocalDataSourceImpl extends IndustryLocalDataSource {
  List<IndustryEntity>? _all;
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
    _all = industries;
    return Future.value();
  }

  @override
  FutureOr<void> removeAll() async {
    _cache.clear();
    return Future.value();
  }

  @override
  FutureOr<List<IndustryEntity>> findAll() async {
    if (_all == null) {
      throw IndustryNotFoundInLocalCacheFailure();
    }
    return _all!;
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
