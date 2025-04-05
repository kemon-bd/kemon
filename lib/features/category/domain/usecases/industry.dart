import '../../../../core/shared/shared.dart';
import '../../category.dart';

class FindCategoriesByIndustryUseCase {
  final CategoryRepository repository;

  FindCategoriesByIndustryUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<CategoryEntity>>> call({
    required Identity industry,
  }) async {
    return await repository.industry(identity: industry);
  }
}
