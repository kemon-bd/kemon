import '../../../../core/shared/shared.dart';
import '../../../industry/industry.dart';
import '../../category.dart';

class RefreshAllCategoryUseCase {
  final CategoryRepository repository;

  RefreshAllCategoryUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<IndustryWithListingCountEntity>>> call() async {
    return await repository.refreshAll();
  }
}
