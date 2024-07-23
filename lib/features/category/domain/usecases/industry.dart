import '../../../../core/shared/shared.dart';
import '../../category.dart';

class CategoriesByIndustryUseCase {
  final CategoryRepository repository;

  CategoriesByIndustryUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<CategoryEntity>>> call({
    required String industry,
  }) async {
    return await repository.industry(industry: industry);
  }
}
