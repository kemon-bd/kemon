import '../../../../core/shared/shared.dart';
import '../../category.dart';

class FindCategoryUseCase {
  final CategoryRepository repository;

  FindCategoryUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, CategoryEntity>> call({
    required String urlSlug,
  }) async {
    return await repository.find(urlSlug: urlSlug);
  }
}
