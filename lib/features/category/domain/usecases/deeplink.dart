import '../../../../core/shared/shared.dart';
import '../../category.dart';

class FindCategoryDeeplinkUseCase {
  final CategoryRepository repository;

  FindCategoryDeeplinkUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, CategoryEntity>> call({
    required String urlSlug,
  }) async {
    return await repository.deeplink(urlSlug: urlSlug);
  }
}
