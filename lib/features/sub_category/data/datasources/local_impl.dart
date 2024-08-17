import '../../../../core/shared/shared.dart';
import '../../sub_category.dart';

class SubCategoryLocalDataSourceImpl extends SubCategoryLocalDataSource {
  final Map<String, SubCategoryEntity> _cache = {};
  final Map<String, List<SubCategoryEntity>> _category = {};

  @override
  FutureOr<void> add({
    required SubCategoryEntity subCategory,
  }) async {
    _cache[subCategory.urlSlug] = subCategory;
    return Future.value();
  }

  @override
  FutureOr<void> addAll({
    required List<SubCategoryEntity> subCategories,
  }) async {
    for (final subCategory in subCategories) {
      await add(subCategory: subCategory);
    }
    return Future.value();
  }

  @override
  FutureOr<void> addAllByCategory({
    required String category,
    required List<SubCategoryEntity> subCategories,
  }) async {
    _category[category] = subCategories;
    await addAll(subCategories: subCategories);
    return Future.value();
  }

  @override
  FutureOr<SubCategoryEntity> find({
    required String urlSlug,
  }) async {
    final category = _cache[urlSlug];

    if (category == null) {
      throw SubCategoryNotFoundInLocalCacheFailure();
    }
    return category;
  }

  @override
  FutureOr<List<SubCategoryEntity>> findByCategory({
    required String category,
  }) async {
    final categories = _category[category];

    if (categories == null) {
      throw CategoryNotFoundInLocalCacheFailure();
    }
    return categories;
  }

  @override
  FutureOr<void> removeAll() async {
    _cache.clear();
    _category.clear();
    return Future.value();
  }
}
