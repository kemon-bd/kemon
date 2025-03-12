import '../../../../core/shared/shared.dart';
import '../../../industry/industry.dart';
import '../../category.dart';

class FindAllCategoryUseCase {
  final CategoryRepository repository;

  FindAllCategoryUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<IndustryWithListingCountEntity>>> call({
    required String? query,
  }) async {
    return await repository.all(query: query);
  }
}
