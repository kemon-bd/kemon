import '../../../../core/shared/shared.dart';
import '../../category.dart';

class FindCategoriesByIndustryUseCase {
  final CategoryRepository repository;

  FindCategoriesByIndustryUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<CategoryEntity>>> call({
    required String urlSlug,
  }) async {
    return await repository.industry(urlSlug: urlSlug);
  }
}
