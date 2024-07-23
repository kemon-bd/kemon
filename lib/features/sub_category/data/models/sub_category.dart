import '../../../../core/shared/shared.dart';
import '../../sub_category.dart';

class SubCategoryModel extends SubCategoryEntity {
  const SubCategoryModel({
    required super.identity,
    required super.name,
    required super.icon,
    required super.urlSlug,
  });

  factory SubCategoryModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      assert(
        map.containsKey('guid'),
        'SubCategoryModel.parse: "guid" not found.',
      );
      assert(
        map['guid'] is String,
        'SubCategoryModel.parse: "guid" is not a String.',
      );
      final String guid = map['guid'] as String;

      assert(
        map.containsKey('name'),
        'SubCategoryModel.parse: "name" not found.',
      );
      assert(
        map['name'] is String,
        'SubCategoryModel.parse: "name" is not a String.',
      );
      final String name = map['name'] as String;

      assert(
        map.containsKey('icon'),
        'SubCategoryModel.parse: "icon" not found.',
      );
      assert(
        map['icon'] is String,
        'SubCategoryModel.parse: "icon" is not a String.',
      );
      final String icon = map['icon'] as String;

      assert(
        map.containsKey('urlslug'),
        'SubCategoryModel.parse: "urlslug" not found.',
      );
      assert(
        map['urlslug'] is String,
        'SubCategoryModel.parse: "urlslug" is not a String.',
      );
      final String urlSlug = map['urlslug'] as String;

      return SubCategoryModel(
        identity: Identity.guid(guid: guid),
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
