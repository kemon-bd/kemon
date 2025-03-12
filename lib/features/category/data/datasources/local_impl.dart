import 'package:kemon/features/industry/domain/entities/industry.dart';

import '../../../../core/shared/shared.dart';
import '../../category.dart';

class CategoryLocalDataSourceImpl extends CategoryLocalDataSource {
  final Map<String, CategoryEntity> categories = {};
  final Map<String?, List<IndustryWithListingCountEntity>> allCategories = {};
  final Map<String, List<CategoryEntity>> industyCategories = {};
  final Map<String, List<CategoryEntity>> location = {};

  @override
  void add({
    required String urlSlug,
    required CategoryEntity category,
  }) {
    categories[urlSlug] = category;
  }

  @override
  void addAll({
    required String? query,
    required List<IndustryWithListingCountEntity> industries,
  }) {
    allCategories[query] = industries;

    for (IndustryWithListingCountEntity industry in industries) {
      addIndustry(industry: industry.urlSlug, categories: industry.categories);
      for (CategoryEntity category in industry.categories) {
        add(urlSlug: category.urlSlug, category: category);
      }
    }
  }

  @override
  void addIndustry({
    required String industry,
    required List<CategoryEntity> categories,
  }) {
    industyCategories[industry] = categories;
  }

  @override
  CategoryEntity find({
    required String urlSlug,
  }) {
    final CategoryEntity? entity = categories[urlSlug];

    if (entity == null) {
      throw CategoriesNotFoundInLocalCacheFailure();
    }

    return entity;
  }

  @override
  List<IndustryWithListingCountEntity> findAll({
    required String? query,
  }) {
    final List<IndustryWithListingCountEntity>? entities = allCategories[query];

    if (entities == null) {
      throw CategoriesNotFoundInLocalCacheFailure();
    }

    return entities;
  }

  @override
  List<CategoryEntity> findIndustry({
    required String industry,
  }) {
    final List<CategoryEntity>? entities = allCategories[industry];

    if (entities == null) {
      throw CategoriesNotFoundInLocalCacheFailure();
    }

    return entities;
  }

  @override
  void removeAll() {
    location.clear();
    categories.clear();
    allCategories.clear();
    industyCategories.clear();
  }

  @override
  void addByLocation({
    required String? query,
    required String division,
    String? district,
    String? thana,
    required String industry,
    required List<CategoryEntity> categories,
  }) {
    final String key = buildLocationKey(query: query, division: division, industry: industry, district: district, thana: thana);
    for (CategoryEntity category in categories) {
      add(urlSlug: category.urlSlug, category: category);
    }
    location[key] = categories;
  }

  @override
  List<CategoryEntity> findByLocation({
    required String? query,
    required String division,
    String? district,
    String? thana,
    required String industry,
  }) {
    final String key = buildLocationKey(query: query, division: division, industry: industry, district: district, thana: thana);
    final entities = location[key];

    if (entities == null) {
      throw CategoriesNotFoundInLocalCacheFailure();
    }

    return entities;
  }

  String buildLocationKey({
    required String? query,
    required String division,
    String? district,
    String? thana,
    required String industry,
  }) =>
      '$query-$division-$district-$thana-$industry';
}
