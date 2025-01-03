import '../../../../core/shared/shared.dart';
import '../../category.dart';

class FindAllCategoryUseCase {
  final CategoryRepository repository;

  FindAllCategoryUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, CategoryPaginatedResponse>> call({
    required int page,
    required String? industry,
    required String? query,
  }) async {
    return await repository.all(page: page, industry: industry, query: query);
  }
}
