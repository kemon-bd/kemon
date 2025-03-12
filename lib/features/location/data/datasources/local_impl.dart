import '../../../../core/shared/shared.dart';
import '../../location.dart';

class LocationLocalDataSourceImpl extends LocationLocalDataSource {
  final Map<String, LocationEntity> locations = {};
  final Map<String?, List<DivisionWithListingCountEntity>> all = {};
  final Map<String, List<DivisionWithListingCountEntity>> categories = {};

  @override
  void add({
    required String urlSlug,
    required LocationEntity location,
  }) {
    locations[urlSlug] = location;
  }

  @override
  void addAll({
    required String? query,
    required List<DivisionWithListingCountEntity> divisions,
  }) {
    all[query] = divisions;
    for (DivisionWithListingCountEntity di in divisions) {
      locations[di.urlSlug] = di;
      for (DistrictWithListingCountEntity ds in di.districts) {
        locations[ds.urlSlug] = ds;
        for (ThanaWithListingCountEntity t in ds.thanas) {
          locations[t.urlSlug] = t;
        }
      }
    }
  }

  @override
  void removeAll() {
    locations.clear();
    categories.clear();
    all.clear();
  }

  @override
  LocationEntity find({
    required String urlSlug,
  }) {
    final item = locations[urlSlug];
    if (item == null) {
      throw LocationNotFoundInLocalCacheFailure();
    }
    return item;
  }

  @override
  List<DivisionWithListingCountEntity> findAll({required String? query}) {
    final items = all[query];
    if (items == null) {
      throw LocationNotFoundInLocalCacheFailure();
    }
    return items;
  }

  String buildKey({
    required Identity industry,
    Identity? category,
    Identity? subCategory,
  }) =>
      '${industry.guid}-${category?.guid}-${subCategory?.guid}';

  @override
  void addByCategory({
    required Identity industry,
    required Identity? category,
    required Identity? subCategory,
    required List<DivisionWithListingCountEntity> divisions,
  }) {
    final key = buildKey(
      industry: industry,
      category: category,
      subCategory: subCategory,
    );
    categories[key] = divisions;
    for (DivisionWithListingCountEntity di in divisions) {
      locations[di.urlSlug] = di;
      for (DistrictWithListingCountEntity ds in di.districts) {
        locations[ds.urlSlug] = ds;
        for (ThanaWithListingCountEntity t in ds.thanas) {
          locations[t.urlSlug] = t;
        }
      }
    }
  }

  @override
  List<DivisionWithListingCountEntity> findByCategory({
    required Identity industry,
    required Identity? category,
    required Identity? subCategory,
  }) {
    final key = buildKey(
      industry: industry,
      category: category,
      subCategory: subCategory,
    );
    final item = categories[key];
    if (item == null) {
      throw LocationNotFoundInLocalCacheFailure();
    }
    return item;
  }
}
