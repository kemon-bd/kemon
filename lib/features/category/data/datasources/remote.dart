import '../../../../core/shared/shared.dart';
import '../../category.dart';

abstract class CategoryRemoteDataSource {
  FutureOr<List<CategoryModel>> featured();
  
  FutureOr<CategoryModel> find({
    required String urlSlug,
  });

  FutureOr<List<CategoryModel>> industry({
    required String urlSlug,
  });

  FutureOr<CategoryPaginatedResponse> all({
    required int page,
    required String? industry,
    required String? query,
  });
}
