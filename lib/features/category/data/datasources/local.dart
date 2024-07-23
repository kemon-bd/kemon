import '../../../../core/shared/shared.dart';
import '../../category.dart';

abstract class CategoryLocalDataSource {
  FutureOr<void> add({
    required CategoryEntity category,
  });

  FutureOr<void> addAll({
    required List<CategoryEntity> categories,
  });

  FutureOr<void> addAllByIndustry({
    required String industry,
    required List<CategoryEntity> categories,
  });

  FutureOr<CategoryEntity> find({
    required String urlSlug,
  });

  FutureOr<List<CategoryEntity>> findByIndustry({
    required String industry,
  });

  FutureOr<void> removeAll();
}
