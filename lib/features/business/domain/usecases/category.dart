import '../../../../core/shared/shared.dart';
import '../../business.dart';

class BusinessesByCategoryUseCase {
  final BusinessRepository repository;

  BusinessesByCategoryUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<BusinessEntity>>> call({
    required String category,
  }) async {
    return await repository.category(category: category);
  }
}
