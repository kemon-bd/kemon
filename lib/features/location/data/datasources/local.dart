import '../../../../core/shared/shared.dart';
import '../../location.dart';

abstract class LocationLocalDataSource {
  void add({
    required String urlSlug,
    required LocationEntity location,
  });

  void addAll({
    required String? query,
    required List<DivisionWithListingCountEntity> divisions,
  });

  void addByCategory({
    required Identity industry,
    required Identity? category,
    required Identity? subCategory,
    required List<DivisionWithListingCountEntity> divisions,
  });

  void removeAll();

  LocationEntity find({
    required String urlSlug,
  });

  List<DivisionWithListingCountEntity> findAll({
    required String? query,
  });
  List<DivisionWithListingCountEntity> findByCategory({
    required Identity industry,
    required Identity? category,
    required Identity? subCategory,
  });
}
