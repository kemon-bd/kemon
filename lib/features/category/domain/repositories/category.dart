import '../../../../core/shared/shared.dart';
import '../../../industry/industry.dart';
import '../../category.dart';

typedef IndustryBasedCategories = ({IndustryEntity industry, List<CategoryEntity> categories});

abstract class CategoryRepository {
  FutureOr<Either<Failure, CategoryEntity>> find({
    required String urlSlug,
  });

  FutureOr<Either<Failure, List<CategoryEntity>>> industry({
    required Identity identity,
  });

  FutureOr<Either<Failure, List<CategoryEntity>>> featured();

  FutureOr<Either<Failure, List<IndustryWithListingCountEntity>>> all({
    required String? query,
  });
  FutureOr<Either<Failure, List<IndustryWithListingCountEntity>>> refreshAll();
}
