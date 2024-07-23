import '../../../../core/shared/shared.dart';
import '../../sub_category.dart';

class FindSubCategoryUseCase {
  final SubCategoryRepository repository;

  FindSubCategoryUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, SubCategoryEntity>> call({
    required String urlSlug,
  }) async {
    return await repository.find(urlSlug: urlSlug);
  }
}
