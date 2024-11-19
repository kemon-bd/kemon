import '../../../../core/shared/shared.dart';
import '../../category.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.identity,
    required super.name,
    required super.icon,
    required super.urlSlug,
  });

  factory CategoryModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      assert(
        map['guid'] is String?,
        'CategoryModel.parse: "guid" is not a String.',
      );
      final String guid = map['guid'] ?? '';

      assert(
        map.containsKey('name'),
        'CategoryModel.parse: "name" not found.',
      );
      assert(
        map['name'] is String,
        'CategoryModel.parse: "name" is not a String.',
      );
      final String name = map['name'] as String;

      // assert(
      //   map.containsKey('icon'),
      //   'CategoryModel.parse: "icon" not found.',
      // );
      assert(
        map['icon'] is String?,
        'CategoryModel.parse: "icon" is not a String?.',
      );
      final String icon = map['icon'] ?? '';

      assert(
        map.containsKey('urlslug'),
        'CategoryModel.parse: "urlslug" not found.',
      );
      assert(
        map['urlslug'] is String,
        'CategoryModel.parse: "urlslug" is not a String.',
      );
      final String urlSlug = map['urlslug'] as String;

      return CategoryModel(
        identity: Identity.guid(guid: guid),
        name: Name.full(name: name),
        icon: icon,
        urlSlug: urlSlug,
      );
    } catch (e, stackTrace) {
      throw CategoryModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
