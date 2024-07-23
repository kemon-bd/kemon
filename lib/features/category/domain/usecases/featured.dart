import '../../../../core/shared/shared.dart';
import '../../category.dart';

class FeaturedCategoriesUseCase {
  final CategoryRepository repository;

  FeaturedCategoriesUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<CategoryEntity>>> call() async {
    return await repository.featured();
  }
}
