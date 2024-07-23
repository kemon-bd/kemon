import '../../../../core/shared/shared.dart';
import '../../category.dart';

abstract class CategoryRepository {
  FutureOr<Either<Failure, CategoryEntity>> find({
    required String urlSlug,
  });

  FutureOr<Either<Failure, List<CategoryEntity>>> industry({
    required String industry,
  });

  FutureOr<Either<Failure, List<CategoryEntity>>> featured();
}
