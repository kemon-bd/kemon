import '../../../../core/shared/shared.dart';
import '../../category.dart';

class CategoryLocalDataSourceImpl extends CategoryLocalDataSource {
  final Map<String, CategoryEntity> _cache = {};
  final Map<String, List<CategoryEntity>> _industry = {};

  @override
  FutureOr<void> add({
    required CategoryEntity category,
  }) {
    _cache[category.urlSlug] = category;
  }

  @override
  FutureOr<void> addAll({
    required List<CategoryEntity> categories,
  }) {
    for (final category in categories) {
      add(category: category);
    }
  }

  @override
  FutureOr<void> addAllByIndustry({
    required String industry,
    required List<CategoryEntity> categories,
  }) {
    _industry[industry] = categories;
    addAll(categories: categories);
  }

  @override
  FutureOr<CategoryEntity> find({
    required String urlSlug,
  }) {
    final category = _cache[urlSlug];

    if (category == null) {
      throw CategoryNotFoundInLocalCacheFailure();
    }
    return category;
  }

  @override
  FutureOr<List<CategoryEntity>> findByIndustry({
    required String industry,
  }) {
    final categories = _industry[industry];

    if (categories == null) {
      throw IndustryNotFoundInLocalCacheFailure();
    }
    return categories;
  }

  @override
  FutureOr<void> removeAll() {
    _cache.clear();
    _industry.clear();
  }
}
