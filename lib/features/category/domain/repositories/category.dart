import '../../../../core/shared/shared.dart';
import '../../../industry/industry.dart';
import '../../category.dart';

typedef IndustryBasedCategories = ({IndustryEntity industry, List<CategoryEntity> categories});

typedef CategoryPaginatedResponse = ({
  int total,
  List<IndustryBasedCategories> results,
});

abstract class CategoryRepository {
  FutureOr<Either<Failure, CategoryEntity>> find({
    required String urlSlug,
  });

  FutureOr<Either<Failure, List<CategoryEntity>>> industry({
    required String urlSlug,
  });

  FutureOr<Either<Failure, List<CategoryEntity>>> featured();

  FutureOr<Either<Failure, CategoryPaginatedResponse>> all({
    required int page,
    required String? industry,
    required String? query,
  });

  FutureOr<Either<Failure, CategoryPaginatedResponse>> refreshAll({
    required int page,
    required String? industry,
    required String? query,
  });
}
