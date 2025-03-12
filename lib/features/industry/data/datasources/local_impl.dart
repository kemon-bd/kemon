import '../../../../core/shared/shared.dart';
import '../../industry.dart';

class IndustryLocalDataSourceImpl extends IndustryLocalDataSource {
  final Map<String?, List<IndustryEntity>> _all = {};
  final Map<String, List<IndustryWithListingCountModel>> _location = {};
  final Map<String, IndustryEntity> _cache = {};

  @override
  void add({
    required IndustryEntity industry,
  }) async {
    _cache[industry.urlSlug] = industry;
    return Future.value();
  }

  @override
  void addAll({
    required String? query,
    required List<IndustryEntity> industries,
  }) {
    for (final item in industries) {
      _cache[item.urlSlug] = item;
    }
    _all[query] = industries;
    return;
  }

  @override
  void removeAll() async {
    _cache.clear();
    _all.clear();
    _location.clear();
    return Future.value();
  }

  @override
  List<IndustryEntity> findAll({
    required String? query,
  })  {
    final items = _all[query];
    if (items == null) {
      throw IndustryNotFoundInLocalCacheFailure();
    }
    return items;
  }

  @override
  IndustryEntity find({
    required String urlSlug,
  })  {
    final item = _cache[urlSlug];
    if (item == null) {
      throw IndustryNotFoundInLocalCacheFailure();
    }
    return item;
  }

  @override
  void addByLocation({
    required String division,
    String? district,
    String? thana,
    required List<IndustryWithListingCountModel> industries,
  }) {
    final String key = buildKey(division: division, district: district, thana: thana);
    for (final item in industries) {
      _cache[item.urlSlug] = item;
    }
    _location[key] = industries;
    return;
  }

  @override
  List<IndustryWithListingCountModel> findByLocation({
    required String division,
    String? district,
    String? thana,
  }) {
    final String key = buildKey(division: division, district: district, thana: thana);
    final items = _location[key];
    if (items == null) {
      throw IndustryNotFoundInLocalCacheFailure();
    }
    return items;
  }

  String buildKey({
    required String division,
    String? district,
    String? thana,
  }) =>
      '$division-$district-$thana';
}
