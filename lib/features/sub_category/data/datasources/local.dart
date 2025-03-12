import '../../../../core/shared/shared.dart';
import '../../sub_category.dart';

abstract class SubCategoryLocalDataSource {
  FutureOr<void> add({
    required SubCategoryEntity subCategory,
  });

  FutureOr<void> addAll({
    required List<SubCategoryEntity> subCategories,
  });

  FutureOr<void> addAllByCategory({
    required String category,
    required List<SubCategoryEntity> subCategories,
  });

  FutureOr<SubCategoryEntity> find({
    required String urlSlug,
  });

  FutureOr<List<SubCategoryEntity>> findByCategory({
    required String category,
  });
  void addByLocation({
    required String? query,
    required String division,
    String? district,
    String? thana,
    required String industry,
    required String category,
    required List<SubCategoryEntity> subCategories,
  });
  List<SubCategoryEntity> findByLocation({
    required String? query,
    required String division,
    String? district,
    String? thana,
    required String industry,
    required String category,
  });

  FutureOr<void> removeAll();
}
