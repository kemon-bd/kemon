import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../../search/search.dart';
import '../../sub_category.dart';

class SubCategoryModel extends SubCategoryEntity implements CategoryEntity {
  const SubCategoryModel({
    required super.identity,
    required super.industry,
    required super.category,
    required super.name,
    required super.icon,
    required super.urlSlug,
  });

  factory SubCategoryModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      assert(
        map.containsKey('name'),
        'SubCategoryModel.parse: "name" not found.',
      );
      assert(
        map['name'] is String,
        'SubCategoryModel.parse: "name" is not a String.',
      );
      final String name = map['name'] as String;

      // assert(
      //   map.containsKey('icon'),
      //   'SubCategoryModel.parse: "icon" not found.',
      // );
      assert(
        map['icon'] is String? || map['logo'] is String?,
        'SubCategoryModel.parse: "icon" is not a String?.',
      );
      final String icon = map['icon'] ?? map['logo'] ?? '';

      assert(
        map.containsKey('urlSlug'),
        'SubCategoryModel.parse: "urlSlug" not found.',
      );
      assert(
        map['urlSlug'] is String,
        'SubCategoryModel.parse: "urlSlug" is not a String.',
      );
      final String urlSlug = map['urlSlug'] as String;

      return SubCategoryModel(
        industry: Identity.guid(guid: map['industry'] ?? ''),
        category: Identity.guid(guid: map['category'] ?? ''),
        identity: Identity.guid(guid: map['guid'] ?? ''),
        name: Name.full(name: name),
        icon: icon,
        urlSlug: urlSlug,
      );
    } catch (e, stackTrace) {
      throw SubCategoryModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}

class SubCategoryWithListingCountModel extends SubCategoryWithListingCountEntity
    implements SubCategoryModel, SubCategoryEntity, CategoryEntity {
  const SubCategoryWithListingCountModel({
    required super.identity,
    required super.industry,
    required super.category,
    required super.name,
    required super.icon,
    required super.urlSlug,
    required super.listings,
  });

  factory SubCategoryWithListingCountModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      final subCategory = SubCategoryModel.parse(map: map);
      return SubCategoryWithListingCountModel(
        industry: subCategory.industry,
        category: subCategory.category,
        identity: subCategory.identity,
        name: subCategory.name,
        icon: subCategory.icon,
        urlSlug: subCategory.urlSlug,
        listings: map['count'] ?? 0,
      );
    } catch (e, stackTrace) {
      throw SubCategoryModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}

class SubCategorySuggestionModel extends SubCategorySuggestionEntity
    implements SubCategoryEntity, SubCategoryModel, SearchSuggestionEntity, SearchSuggestionModel {
  const SubCategorySuggestionModel({
    required super.category,
    required super.identity,
    required super.industry,
    required super.name,
    required super.icon,
    required super.urlSlug,
  });

  factory SubCategorySuggestionModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      final subCategory = SubCategoryModel.parse(map: map);
      return SubCategorySuggestionModel(
        industry: subCategory.industry,
        category: subCategory.category,
        identity: subCategory.identity,
        name: subCategory.name,
        icon: subCategory.icon,
        urlSlug: subCategory.urlSlug,
      );
    } catch (e, stackTrace) {
      throw SubCategoryModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
