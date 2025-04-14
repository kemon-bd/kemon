import '../../../../core/shared/shared.dart';
import '../../sub_category.dart';

abstract class SubCategoryRemoteDataSource {
  FutureOr<List<SubCategoryModel>> category({
    required String category,
  });
  FutureOr<SubCategoryModel> find({
    required String urlSlug,
  });
}
