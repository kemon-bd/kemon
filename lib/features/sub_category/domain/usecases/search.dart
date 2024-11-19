import '../../../../core/shared/shared.dart';
import '../../sub_category.dart';

class SearchSubCategoriesByCategoryUseCase {
  final SubCategoryRepository repository;

  SearchSubCategoriesByCategoryUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<SubCategoryEntity>>> call({
    required String category,
    required String query,
  }) async {
    return await repository.search(category: category, query: query);
  }
}
