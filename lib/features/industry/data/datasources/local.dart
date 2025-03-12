import '../../../../core/shared/shared.dart';
import '../../industry.dart';

abstract class IndustryLocalDataSource {
  void add({
    required IndustryEntity industry,
  });

  void addAll({
    required String? query,
    required List<IndustryEntity> industries,
  });

  void addByLocation({
    required String division,
    String? district,
    String? thana,
    required List<IndustryWithListingCountModel> industries,
  });

  void removeAll();

  List<IndustryEntity> findAll({
    required String? query,
  });

  List<IndustryWithListingCountModel> findByLocation({
    required String division,
    String? district,
    String? thana,
  });

  IndustryEntity find({
    required String urlSlug,
  });
}
