import '../shared.dart';
import '../../../features/sub_category/sub_category.dart';

extension SubCategoryEntityExtension on SubCategoryEntity {
  Map<String, dynamic> get toMap {
    return {
      "name" : name.full,
      "icon": icon,
      "urlSlug" : urlSlug,
    };
  }
}

extension SubCategoryModelExtension on SubCategoryModel {}
