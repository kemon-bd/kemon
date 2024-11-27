import '../shared.dart';
import '../../../features/category/category.dart';
import '../../../features/industry/industry.dart';

extension CategoriesEntityExtension on Iterable<CategoryEntity> {
  List<CategoryEntity> get distinct {
    final Map<String, CategoryEntity> map = {};
    for (final row in this) {
      map[row.urlSlug] = row;
    }
    return map.values.toList();
  }
}

extension CategoryEntityExtension on CategoryEntity {}

extension CategoryModelExtension on CategoryModel {}

extension IndustryBasedCategoriesExtension on List<IndustryBasedCategories> {
  int get count {
    final int c = fold<int>(0, (sum, row) => sum + row.categories.length);
    return c;
  }

  bool lastItem({
    required CategoryEntity category,
  }) {
    return last.categories.last.urlSlug.same(as: category.urlSlug);
  }

  List<IndustryBasedCategories> stitch(List<IndustryBasedCategories> rows) {
    final Map<IndustryEntity, Set<CategoryEntity>> map = {};

    // Populate map with initial rows
    for (final row in this) {
      map[row.industry] = {...row.categories};
    }

    // Merge with new rows
    for (final row in rows) {
      if (map.containsKey(row.industry)) {
        map[row.industry]!.addAll(row.categories);
      } else {
        map[row.industry] = {...row.categories};
      }
    }

    // Convert map back to List<IndustryBasedCategories>
    return map.entries.map((entry) => (industry: entry.key, categories: entry.value.toList())).toList();
  }
}
