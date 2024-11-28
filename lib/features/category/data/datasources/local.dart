import '../../../../core/shared/shared.dart';
import '../../category.dart';

typedef CategoriesPaginationKey = ({
  int page,
  String? query,
  String? industry,
});

abstract class CategoryLocalDataSource {
  FutureOr<void> add({
    required String urlSlug,
    required CategoryEntity category,
  });
  FutureOr<void> featured({
    required List<CategoryEntity> categories,
  });
  
  FutureOr<CategoryEntity> find({
    required String urlSlug,
  });

  FutureOr<void> cachePagination({
    required CategoriesPaginationKey key,
    required CategoryPaginatedResponse result,
  });

  FutureOr<CategoryPaginatedResponse> findPagination({
    required CategoriesPaginationKey key,
  });

  FutureOr<void> removeAll();
}
