import '../../../../core/shared/shared.dart';
import '../../location.dart';

class FindLocationsByCategoriesUseCase {
  final LocationRepository repository;

  FindLocationsByCategoriesUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<DivisionWithListingCountEntity>>> call({
    required String? query,
    required Identity industry,
    Identity? category,
    Identity? subCategory,
  }) async {
    return await repository.category(
      query: query,
      category: category,
      subCategory: subCategory,
      industry: industry,
    );
  }
}
