import '../../../../core/shared/shared.dart';
import '../../../industry/industry.dart';
import '../../category.dart';

abstract class CategoryLocalDataSource {
  void add({
    required String urlSlug,
    required CategoryEntity category,
  });

  CategoryEntity find({
    required String urlSlug,
  });

  void addIndustry({
    required String industry,
    required List<CategoryEntity> categories,
  });

  List<CategoryEntity> findIndustry({
    required String industry,
  });

  void addAll({
    required String? query,
    required List<IndustryWithListingCountEntity> industries,
  });

  List<IndustryWithListingCountEntity> findAll({
    required String? query,
  });
  void addByLocation({
    required String? query,
    required String division,
    String? district,
    String? thana,
    required String industry,
    required List<CategoryEntity> categories,
  });
  List<CategoryEntity> findByLocation({
    required String? query,
    required String division,
    String? district,
    String? thana,
    required String industry,
  });

  void removeAll();
}
