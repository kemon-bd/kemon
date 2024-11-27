import '../../../../core/shared/shared.dart';
import '../../category.dart';

class RefreshAllCategoryUseCase {
  final CategoryRepository repository;

  RefreshAllCategoryUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, CategoryPaginatedResponse>> call({
    required int page,
    required String? industry,
    required String? query,
  }) async {
    return await repository.refreshAll(page: page, industry: industry, query: query);
  }
}
