import '../../../../core/shared/shared.dart';
import '../../sub_category.dart';

abstract class SubCategoryRepository {
  FutureOr<Either<Failure, SubCategoryEntity>> find({
    required String urlSlug,
  });

  FutureOr<Either<Failure, List<SubCategoryEntity>>> category({
    required String category,
  });

  FutureOr<Either<Failure, List<SubCategoryEntity>>> search({
    required String category,
    required String query,
  });
}
