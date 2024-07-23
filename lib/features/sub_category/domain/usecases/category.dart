import '../../../../core/shared/shared.dart';
import '../../sub_category.dart';

class SubCategoriesByCategoryUseCase {
  final SubCategoryRepository repository;

  SubCategoriesByCategoryUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<SubCategoryEntity>>> call({
    required String category,
  }) async {
    return await repository.category(category: category);
  }
}
